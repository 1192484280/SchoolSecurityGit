//
//  ScaningViewController.m
//  SchoolSecurity
//
//  Created by zhangming on 17/9/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ScaningViewController.h"
#import "SGQRCode.h"
#import "ScanedViewController.h"
#import "ScanModel.h"
#import "ScanList.h"
#import "SecurityScanAgree+CoreDataProperties.h"

@interface ScaningViewController ()<SGQRCodeScanManagerDelegate>
{
    int flag;
}
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (weak, nonatomic) SGQRCodeScanManager *manager;

@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;

@property (nonatomic, strong) UIView *flashView;

@end

@implementation ScaningViewController

- (UIView *)flashView{
    
    if (!_flashView) {
        
        _flashView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100)];
        
        [_flashView addSubview:self.flashlightBtn];
    }
    return _flashView;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
    flag = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    
    [self setupQRCodeScanning];
    
    [self.view addSubview:self.flashView];
    
    [self setupBackBtnNavBarWithTitle:@"扫描"];
    
}

- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
    }
    return _scanningView;
}
- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)setupQRCodeScanning {
    
    SGQRCodeScanManager *manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    manager.delegate = self;
    self.manager = manager;
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    
    if (metadataObjects != nil && metadataObjects.count > 0) {
        
        if (flag > 0) {
            
            return;
        }
        flag ++ ;
        
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSDictionary *dic = (id)obj.stringValue;
        
        NSLog(@"扫描结果：%@",dic);
        if (self.flashlightBtn.selected) {
            
            [self onflashlightBtn:self.flashlightBtn];
        }
        
        ScanModel *model = [ScanModel mj_objectWithKeyValues:dic];
        
        //计算时间差是否超出before_time
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM-dd HH:mm";
        NSDate *data = [format dateFromString:model.format_visitor_time];
        
        NSDateComponents *cmps = [NSDate deltaFrom:data];
        
        if (cmps.year || cmps.month || cmps.day || cmps.day > [model.before_time integerValue]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"来访时间不在预约时间范围内！" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [scanManager SG_stopRunning];
                [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
            return;
        }
        
        [scanManager SG_stopRunning];
        [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        [ScanList sharedInstance].scanModel = model;
        
        ScanedViewController *VC = [[ScanedViewController alloc] init];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        CGFloat flashlightBtnW = 65;
        CGFloat flashlightBtnH = 87;
        CGFloat flashlightBtnX = (ScreenWidth - 65)/2;
        CGFloat flashlightBtnY = (100 - 87)/2;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(onflashlightBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)onflashlightBtn:(UIButton *)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        
        [SGQRCodeHelperTool SG_openFlashlight];
        
    }else{
        
        [SGQRCodeHelperTool SG_CloseFlashlight];
    }
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
