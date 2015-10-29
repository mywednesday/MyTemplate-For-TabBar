//
//  MapkitViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/28.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MapkitViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Masonry.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapSearchKit/AMapSearchObj.h>






@interface MapkitViewController ()<CLLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate>

@property(nonatomic,strong) CLLocationManager* locationManager;
@property(nonatomic,strong) CLGeocoder* geocoder;
@property(nonatomic,strong) MAMapView* mapView;
@property(nonatomic,strong) AMapSearchAPI* mapSearchApi;

@end





@implementation MapkitViewController


- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.leftBarButtonItemStyle = UILeftBarButtonItemStyleImage;
        self.sideSlipForNavBackWorked = YES;
        self.hidesBottomBarWhenPushed = YES;        //隐藏底部导航Bar
        
        
        [self congfigMAMap];        //配置高德地图
    }
    
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图";
    
    //初始化地图视图
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _mapView.language = MAMapLanguageZhCN;
    _mapView.showsUserLocation  = YES;      //显示当前位置，IOS8+需要设置Info.list文件
    _mapView.mapType = MAMapTypeStandard;  //MAMapTypeStandard/MAMapTypeSatellite/MAMapTypeStandardNight(3D )
    _mapView.showTraffic = NO;             //实时路况,  要求MAMapTypeStandard模式
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    //初始化定位服务
    [self initLocation];
    
    
    
    
    //大头针 标注
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init]; pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018); pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街 6 号";
    [_mapView addAnnotation:pointAnnotation];
    
    
    
    
    //添加缩放按钮
    UIStepper *mySteper = [[UIStepper alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    mySteper.maximumValue = 100;
    mySteper.minimumValue = -100;
    
    mySteper.value = 0;     //default : 0
    mySteper.stepValue = 1;     //尽可能保持一个较大的范围
    mySteper.tintColor = [UIColor redColor];
    [mySteper addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
    [_mapView addSubview:mySteper];
    [mySteper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.right.equalTo(_mapView).offset(-50);
        make.bottom.equalTo(_mapView).offset(-20);
    }];
    
}


/**
    配置高德地图SDK Key
 */
- (void) congfigMAMap {
    [MAMapServices sharedServices].apiKey = @"c85482a0a065bf9fdc4dc7910abf5d5b";
}


/**
    申请定位权限
 */
-  (void) initLocation
{
    if(nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    if([[[UIDevice  currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationManager requestAlwaysAuthorization];
}


/**
    初始化AMapSearchAPI
 */
-  (void) initSearch
{
    //构造AMapSearchAPI
    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:@"c85482a0a065bf9fdc4dc7910abf5d5b" Delegate:self];
    _mapSearchApi.language = AMapSearchLanguage_en;//设置语言
}


/*  POI 搜索.  */
-  (void)searchPOIWithKey:(NSString *)key adcode:(NSString *)adcode
{
    if (key.length == 0)
    {
        return;
    }
    
    //构造POI搜索对象AMapPlaceSearchRequest
    AMapPlaceSearchRequest  *place = [[AMapPlaceSearchRequest alloc] init];
    
    //设置关键字
    place.keywords = key;
    place.requireExtension = YES;//设置成YES，返回信息详细，较费流量
    if (adcode.length > 0)
    {
        place.city = @[adcode];
    }
    //发起查询
    [_mapSearchApi  AMapPlaceSearch:place];
}

//回调中显示结果
-  (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse  *)respons
{
    if (respons.pois.count == 0)
    {
        return;
    }
    NSMutableArray  *poiAnnotations = [NSMutableArray arrayWithCapacity:respons.pois.count];
    [respons.pois  enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
//        [poiAnnotations  addObject:[[POIAnnotation alloc] initWithPOI:obj]];          //找不到合适的类
    }];
    
    /*  将结果以annotation的形式加载到地图上. */
    [_mapView addAnnotations:poiAnnotations];
    
    /*  如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        _mapView.centerCoordinate = [poiAnnotations[0] coordinate];
    }
    
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [_mapView showAnnotations:poiAnnotations animated:NO];
    }
}




#pragma mark -- MAMapViewDelegate --
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    //设置标注样式
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        //可以改变标注的图标
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
        //设置中心心点偏移,使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, 18);
        
        annotationView.canShowCallout= YES; //设置气泡可以弹出,默认为 NO
        annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO
        annotationView.draggable = YES; //设置标注可以拖动,默认为 NO
        annotationView.pinColor = MAPinAnnotationColorGreen;
        return annotationView;
    }
    return nil;
}





@end
