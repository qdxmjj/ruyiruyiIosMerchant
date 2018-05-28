//
//  JJMapViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/28.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "JJMapViewController.h"
#import "MapBottomView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface JJMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)BMKMapView *mapView;

@property (nonatomic, strong) BMKLocationService *locService;
// 地理编码
@property (nonatomic, strong) BMKGeoCodeSearch *geoCode;
// 经度
@property (nonatomic, assign) CGFloat longitude;
// 纬度
@property (nonatomic, assign) CGFloat latitude;
//店铺位置
@property(nonatomic,copy)NSString *storePosition;

/* 当前城市名称 */
@property(nonatomic,copy)NSString *currentCityString;

//创建反向地理编码选项对象
@property(nonatomic,strong)BMKReverseGeoCodeOption *reverseOption;

//新的标注点
@property(nonatomic,strong)BMKPointAnnotation *pointAnnotation;


@property(nonatomic,strong)MapBottomView *bottomView;
@end

@implementation JJMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = self.mapView;
    
    [self.view addSubview:self.bottomView];
    // 初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}


-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geoCode.delegate = nil;
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}



/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{

    
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    
//    region.span.latitudeDelta = 0.2;
//    region.span.longitudeDelta = 0.2;
    if (self.mapView)
    {
        self.mapView.region = region;
        
    }
    [_mapView setZoomLevel:19.0];
    [_locService stopUserLocationService];//定位完成停止位置更新
    
    //添加当前位置的标注
    CLLocationCoordinate2D coord;
    coord.latitude = userLocation.location.coordinate.latitude;
    coord.longitude = userLocation.location.coordinate.longitude;
    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
    _pointAnnotation.coordinate = coord;
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){coord.latitude,coord.longitude};

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView removeOverlays:self.mapView.overlays];
        [self.mapView setCenterCoordinate:coord animated:true];
        [self.mapView addAnnotation:_pointAnnotation];
    });
}

#pragma mark 点击其他位置
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    //
//    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);

    self.latitude = coordinate.latitude;
    self.longitude = coordinate.longitude;
    
    if (self.pointAnnotation) {
        [self.mapView removeAnnotation:self.pointAnnotation];
    }

    self.pointAnnotation.coordinate = coordinate;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView removeOverlays:self.mapView.overlays];
        [self.mapView setCenterCoordinate:coordinate animated:true];
        [self.mapView addAnnotation:self.pointAnnotation];
    });
    
    //给反向地理编码选项对象的坐标点赋值
    self.reverseOption.reverseGeoPoint=coordinate;
    //执行反地理编码
    [self.geoCode reverseGeoCode:self.reverseOption];
    
}

#pragma mark 自定义标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{

    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        if (annotation== self.pointAnnotation) {
            
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        BMKPinAnnotationView*annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        annotationView.draggable = YES;          //设置标注可以拖动，默认为NO
        annotationView.image = [UIImage imageNamed:@"ic_shop"];
        return annotationView;
        }
    }
    return nil;
}


#pragma mark 反地理位置检索周边
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
//    BMKAddressComponent *component=[[BMKAddressComponent alloc]init];
//    component=result.addressDetail;
//
//    NSLog(@"定位地址为：%@  %@",component.streetName,component.streetNumber);
    
    BMKPoiInfo *info = result.poiList[0];
    self.storePosition = info.name;
    self.bottomView.titleLab.text = info.name;
    self.bottomView.subTitleLab.text = info.address;
}

#pragma mark - 懒加载
-(BMKMapView *)mapView
{
    if (_mapView==nil) {
        _mapView=[[BMKMapView alloc]initWithFrame:self.view.bounds];
        _mapView.delegate=self;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.mapType = BMKMapTypeStandard;
    }
    return _mapView;
}

- (BMKGeoCodeSearch *)geoCode
{
    if (!_geoCode) {
        _geoCode = [[BMKGeoCodeSearch alloc] init];
        _geoCode.delegate = self;
    }
    return _geoCode;
}


-(MapBottomView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[MapBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-110, SCREEN_WIDTH, 110)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView.btn addTarget:self action:@selector(popViewControllerWithLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}


-(BMKReverseGeoCodeOption *)reverseOption{
    
    if (!_reverseOption) {
        
        _reverseOption = [[BMKReverseGeoCodeOption alloc]init];
    }
    
    
    return _reverseOption;
}
-(BMKPointAnnotation *)pointAnnotation{
    
    if (!_pointAnnotation) {
        
        _pointAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}

-(void)popViewControllerWithLocation{
    
    if (self.longitude&&self.latitude&&self.storePosition) {
        self.locationBlock(self.longitude, self.latitude,self.storePosition);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
