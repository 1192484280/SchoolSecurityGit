//
//  XGStartViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/29.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGStartViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <CoreMotion/CoreMotion.h>
#import "StepManager.h"
#import "XGSMViewController.h"
#import "XGTableList.h"

@interface XGStartViewController ()<AMapLocationManagerDelegate>
{
    int persent;
    int seconds;
    int minutes;
    int hour;
    IBOutlet UILabel *timeLa;
    
    BOOL ifLocation;
    NSTimer *_timer;
}

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) AMapLocationManager *locationManager;

@property (strong, nonatomic) NSMutableArray *pointArr;
@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation XGStartViewController

- (NSMutableArray *)pointArr{
    
    if (!_pointArr) {
        
        _pointArr = [NSMutableArray array];
    }
    
    return _pointArr;
}
- (NSTimer *)timer{
    
    if (!_timer) {
        
        _timer = _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(everyTime) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}


- (AMapLocationManager *)locationManager{
    
    if (!_locationManager) {
        
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        //最小定位距离
        _locationManager.distanceFilter = 20;
        
        //iOS9(不包含iOS9)之前设置允许后台定位参数,保持不会被系统挂起
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        _locationManager.allowsBackgroundLocationUpdates = YES;
        //iOS9(包含iOS9)之后新特性:将允许出现这种场景,同一app中多个locationmanager:一些只能在前台定位,另一些可在后台定位,并可随时禁止其后台定位.
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
        
        //返回逆地理编码信息
        [_locationManager setLocatingWithReGeocode:YES];
    }
    
    return _locationManager;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ifLocation = NO;
    
    //开始持续定位
    [self.locationManager startUpdatingLocation];
    
}


#pragma mark - 定位成功
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    ifLocation = YES;
    
    NSString *lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSLog(@"location:{lat:%@; lon:%@; accuracy:%f}", lat, lon, location.horizontalAccuracy);
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
    }
    
    
    NSDictionary *dic = @{
                          @"latitude":lat,
                          @"longtitude":lon
                          };
    
    [self.pointArr addObject:dic];
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    
    ifLocation = NO;
    
    
}

#pragma mark - 定时器方法
- (void)everyTime
{
    persent++;
    //每过１００毫秒，就让秒＋１，然后让毫秒在归零
    if(persent==100){
        seconds++;
        persent = 0;
        NSLog(@"%@",timeLa.text);
    }
    if (seconds == 60) {
        minutes++;
        seconds = 0;
    }
    
    if (minutes == 60) {
        hour++;
        minutes = 0;
    }
    
    if (hour > 0) {
        
        timeLa.text = [NSString stringWithFormat:@"%02d:%02d",hour,minutes];
    }else{
    
        timeLa.text = [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
    }
    
    
    CGFloat range = [StepManager sharedManager].step * 0.4 / 1000;
    self.rangeLa.text = [NSString stringWithFormat:@"%.2f",range];
}


- (IBAction)onStart:(UIButton *)sender {
    
    if (!ifLocation) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"开启定位，才可以正常记录您的巡更" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString * urlStr = @"App-Prefs:root=com.youjiesi.SchoolSecurity";
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
                
                
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];

        return;
    }

    _xgBtn.selected = !_xgBtn.selected;
    
    if (_xgBtn.selected) {
        
        
        [self postXGStartStore];

    }else{
        
        [self.locationManager stopUpdatingLocation];
        //暂停定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        [[StepManager sharedManager] stopWithStep];
        
        MJWeakSelf
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否保存巡更轨迹" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self postXGEndStore];
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
    
}

#pragma mark - 请求开始巡更接口
- (void)postXGStartStore{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *school_Id = [UserDefaultsTool getSchoolId];
    NSString *security_Id = [UserDefaultsTool getSecurityId];
    
    MJWeakSelf
    [store startXGWithSchoolId:school_Id andSecurityId:security_Id Success:^(NSString *p_id){
        
        [weakSelf removeLoadingView];
        
        [XGTableList sharedInstance].p_id = p_id;
        
        weakSelf.pointArr = [NSMutableArray arrayWithObject:[weakSelf.pointArr firstObject]];
        
        
        //启动定时器
        [weakSelf.timer setFireDate:[NSDate distantPast]];
        [StepManager sharedManager].step = 0;
        [[StepManager sharedManager] startWithStep];
        
    } Failure:^(NSError *error){
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
        
    }];
}

#pragma mark - 请求结束巡更接口
- (void)postXGEndStore{
    
    [self addLoadingView];
    
    BaseStore *store = [[BaseStore alloc] init];
    
    NSString *school_Id = [UserDefaultsTool getSchoolId];
    NSString *security_Id = [UserDefaultsTool getSecurityId];
    
    CGFloat range = [StepManager sharedManager].step * 0.4 / 1000;
    NSString *distance = [NSString stringWithFormat:@"%.2f",range];
    
    NSString *line = [self arrToJSON:self.pointArr];
    
    MJWeakSelf
    [store endXGWithSchoolId:school_Id andSecurityId:security_Id andP_id:[XGTableList sharedInstance].p_id andLine:line andDistance:distance Success:^{
        
        [weakSelf showSVPSuccess:@"保存成功"];
        
        if (weakSelf.xgEndBlock != nil) {
            
            weakSelf.xgEndBlock();
        }
        [weakSelf performSelector:@selector(goBack) withObject:nil afterDelay:1];
        
    } Failure:^(NSError *error) {
        
        [weakSelf showSVPError:[HttpTool handleError:error]];
    }];
    
}
// 将字典或者数组转化为JSON串
- (NSString *)arrToJSON:(NSArray *)pointArr
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:pointArr options:NSJSONWritingPrettyPrinted error:nil];
    
    if ([jsonData length]&&error== nil){
        
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return jsonStr;
    }else{
        return nil;
    }
}


- (void)goBack{
    
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)onScaningBtn:(UIButton *)sender {
    
    if (! (_xgBtn.selected)) {
        
        [self showMBPError:@"请先开始巡更"];
        return;
    }
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        XGSMViewController *xgVC = [[XGSMViewController alloc] init];
                        
                        [self.navigationController pushViewController:xgVC animated:YES];
                        
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) {
            
            // 用户允许当前应用访问相机
            XGSMViewController *xgVC = [[XGSMViewController alloc] init];
            
            [self.navigationController pushViewController:xgVC animated:YES];
            
        } else if (status == AVAuthorizationStatusDenied) {
            
            // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
    
}



- (void)returnXGEndBlock:(XGEndBlock)block{
    
    self.xgEndBlock = block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
