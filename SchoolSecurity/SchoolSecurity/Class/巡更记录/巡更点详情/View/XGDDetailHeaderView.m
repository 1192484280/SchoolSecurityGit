//
//  XGDDetailHeaderView.m
//  SecurityManager
//
//  Created by zhangming on 17/8/28.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "XGDDetailHeaderView.h"

@interface XGDDetailHeaderView ()<MAMapViewDelegate> {
    
    //保存轨迹坐标
    CLLocationCoordinate2D * _runningCoords;
    
    NSUInteger _count;
    
    MAMultiPolyline * _polyline;
}


@property (nonatomic, strong) MAMapView *mapView;
@property (weak , nonatomic) UIImageView *bgImg;
@property (weak, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic)UIView *bgView;
@property (weak, nonatomic) UIView *maskView;
@end

@implementation XGDDetailHeaderView



- (MAMapView *)mapView{
    
    if (!_mapView) {
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, XGHeaderHeight - 103)];
        
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mapView.delegate = self;
        
        
    }
    return _mapView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        [self setup];
    }
    
    return self;
}

- (void)setup{

    [self addSubview:self.mapView];
    
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"XGDDetailHeaderView" owner:self options:nil] objectAtIndex:0];
    view.frame = CGRectMake(0, self.mapView.height, ScreenWidth, 103);
    [self addSubview:view];
}

 #pragma mark - 设置起点终点大头针
 - (void)setPointAnnotation:(XGDetailModel *)model{
 
 NSData *jsdata = [model.line mj_JSONData];
 
 //起点
 NSDictionary * startData = [NSDictionary dictionary];
 //终点
 NSDictionary * stopData = [NSDictionary dictionary];
 
 if (jsdata)
 {
 NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsdata options:NSJSONReadingAllowFragments error:nil];
 
 startData = [dataArray firstObject];
 stopData = [dataArray lastObject];
 
 
 }
 
 MAPointAnnotation *startPointAnnotation = [[MAPointAnnotation alloc] init];
 startPointAnnotation.coordinate = CLLocationCoordinate2DMake([startData[@"latitude"] doubleValue], [startData[@"longtitude"] doubleValue]);
 startPointAnnotation.title = @"起点";
 [_mapView addAnnotation:startPointAnnotation];
 
 
 MAPointAnnotation *stopPointAnnotation = [[MAPointAnnotation alloc] init];
 stopPointAnnotation.coordinate = CLLocationCoordinate2DMake([stopData[@"latitude"] doubleValue], [stopData[@"longtitude"] doubleValue]);
 stopPointAnnotation.title = @"终点";
 [_mapView addAnnotation:stopPointAnnotation];
 
 }
 
 #pragma mark - 大头针回调
 - (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
 {
 if ([annotation isKindOfClass:[MAPointAnnotation class]])
 {
 static NSString *reuseIndetifier = @"annotationReuseIndetifier";
 MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
 
 if (annotationView == nil)
 {
 annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
 reuseIdentifier:reuseIndetifier];
 }
 
 if ([annotation.title isEqualToString:@"起点"]) {
 
 annotationView.image = [UIImage imageNamed:@"icon_startAnima"];
 }else{
 
 annotationView.image = [UIImage imageNamed:@"icon_stopAnima"];
 }
 
 //设置中心点偏移，使得标注底部中间点成为经纬度对应点
 annotationView.centerOffset = CGPointMake(0, -18);
 return annotationView;
 }
 return nil;
 }

#pragma mark - mapview delegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if (overlay == _polyline)
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        [polylineRenderer setStrokeImage:[UIImage imageNamed:@"map_history"]];
        
        return polylineRenderer;
        
    }
    
    return nil;
}

- (void)setModel:(XGDetailModel *)model{
    
    self.distanceLa.text = [NSString stringWithFormat:@"%@公里",model.distance];
    [self.headerIm sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IP,model.headimg]] placeholderImage:[UIImage imageNamed:@"icon_imgLoading"]];
    self.userNameLa.text = model.sp_name;
    self.dateLa.text = [NSString stringWithFormat:@"%@",[model.patrol_add_time substringToIndex:10]];
    
    //绘制路线+起始点
    NSData *jsdata = [model.line mj_JSONData];
    
    NSMutableArray * indexes = [NSMutableArray array];
    if (jsdata)
    {
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsdata options:NSJSONReadingAllowFragments error:nil];
        
        _count = dataArray.count;
        _runningCoords = (CLLocationCoordinate2D *)malloc(_count * sizeof(CLLocationCoordinate2D));
        
        for (int i = 0; i < _count; i++)
        {
            @autoreleasepool
            {
                NSDictionary * data = dataArray[i];
                _runningCoords[i].latitude = [data[@"latitude"] doubleValue];
                _runningCoords[i].longitude = [data[@"longtitude"] doubleValue];
                
                [indexes addObject:@(i)];
            }
        }
    }
    
    _polyline = [MAMultiPolyline polylineWithCoordinates:_runningCoords count:_count drawStyleIndexes:indexes];
    
    [self.mapView addOverlay:_polyline];
    
    const CGFloat screenEdgeInset = 30;
    UIEdgeInsets inset = UIEdgeInsetsMake(screenEdgeInset, screenEdgeInset, screenEdgeInset, screenEdgeInset);
    [self.mapView setVisibleMapRect:_polyline.boundingMapRect edgePadding:inset animated:NO];
    
    //设置起点终点大头针
    [self setPointAnnotation:model];
}
 
@end

