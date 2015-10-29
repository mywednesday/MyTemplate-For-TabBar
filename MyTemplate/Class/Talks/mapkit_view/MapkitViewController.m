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
    _mapView.showsUserLocation  = YES;//显示定位图标
    [_mapView  setUserTrackingMode:MAUserTrackingModeFollow];//设置定位模式
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
@end
