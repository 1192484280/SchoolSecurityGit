//
//  XGSMViewController.m
//  SecurityManager
//
//  Created by zhangming on 17/8/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGSMViewController.h"
#import "SGQRCode.h"
#import "XGTableViewController.h"
#import "XGTableModel.h"
#import "XGTableList.h"

@interface XGSMViewController ()<SGQRCodeScanManagerDelegate>

@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIView *flashView;

@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;

@end

@implementation XGSMViewController

- (UIView *)flashView{
    
    if (!_flashView) {
        
        _flashView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100)];
        
        [_flashView addSubview:self.flashlightBtn];
    }
    return _flashView;
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


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [SGQRCodeHelperTool SG_CloseFlashlight];
    
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
    
    [self setupBackBtnNavBarWithTitle:@"扫描"];
    
    [self.view addSubview:self.flashView];
    
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
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager SG_stopRunning];
        [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSDictionary *dic = (id)obj.stringValue;
        
        NSLog(@"扫描结果：%@",dic);
        
        XGTableModel *model = [XGTableModel mj_objectWithKeyValues:dic];
    
        [XGTableList sharedInstance].xgTableModel = model;
        
        XGTableViewController *jumpVC = [[XGTableViewController alloc] init];
        
        [self.navigationController pushViewController:jumpVC animated:YES];
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

#pragma mark - 点击闪光灯按钮
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



@end
