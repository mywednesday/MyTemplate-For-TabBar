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


static NSString *APIKey = @"c85482a0a065bf9fdc4dc7910abf5d5b";



@interface MapkitViewController ()<CLLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate>

@property(nonatomic,strong) CLLocationManager* locationManager;
@property(nonatomic,strong) CLGeocoder* geocoder;
@property(nonatomic,strong) MAMapView* mapView;
@property(nonatomic,strong) AMapSearchAPI* mapSearchApi;
@property(nonatomic,strong) UIStepper *mySteper;        //控制地图的放大、缩小
@property(nonatomic,assign) double previousValue;       //记录点击钱UISteper的Value

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
//    _mapView.showsUserLocation  = YES;     //YES 为打开定位,NO 为关闭定位，IOS8+需要设置Info.list文件
    _mapView.mapType = MAMapTypeStandard;  //MAMapTypeStandard/MAMapTypeSatellite/MAMapTypeStandardNight(3D )
    _mapView.showTraffic = NO;             //实时路况,  要求MAMapTypeStandard模式
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
    //初始化定位服务
//    [self initLocation];
    
    
    
    
    //大头针 标注
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街 6 号";
    [_mapView addAnnotation:pointAnnotation];
    
    
    
    
    //添加缩放按钮  --  高德地图并没有提供实现此功能的控件
    _mySteper = [[UIStepper alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    _mySteper.maximumValue = 100;
    _mySteper.minimumValue = -100;
    _mySteper.value = 0;     //default : 0
    _previousValue = _mySteper.value;
    _mySteper.stepValue = 1;     //尽可能保持一个较大的范围
    _mySteper.tintColor = [UIColor redColor];
    [_mySteper addTarget:self action:@selector(steperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_mapView addSubview:_mySteper];
    [_mySteper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.right.equalTo(_mapView).offset(-70);
        make.bottom.equalTo(_mapView).offset(-20);
    }];
    
    
    
#pragma mark 设置地图显示中心点
//    CLLocationCoordinate2D chengduCoor2D = CLLocationCoordinate2DMake(37.324658, -122.019723);
//    [_mapView setCenterCoordinate:chengduCoor2D animated:YES];
    
    
    
#pragma mark 屏幕截图，保存到指定的文件
//    [self saveSnapshotInRect:CGRectMake(100, 100, 200, 200) toFile:@"wenzhiping"];
    
    
    
    
#pragma mark POI搜索
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
//    //构造 AMapPlaceSearchRequest 对象,配置关键字搜索参数
//    AMapPlaceSearchRequest *poiRequest = [[AMapPlaceSearchRequest alloc] init];
//    poiRequest.searchType = AMapSearchType_PlaceKeyword; poiRequest.keywords = @"俏江南";
//    poiRequest.city = @[@"beijing"];
//    poiRequest.requireExtension = YES;
//    //发起 POI 搜索
//    [_mapSearchApi AMapPlaceSearch: poiRequest];
    
    
    
#pragma mark 路径规划查询
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
//    //构造 AMapNavigationSearchRequest 对象,配置查询参数
//    AMapNavigationSearchRequest *naviRequest= [[AMapNavigationSearchRequest alloc] init];
//    naviRequest.searchType = AMapSearchType_NaviDrive;
//    naviRequest.requireExtension = YES;
//    naviRequest.origin = [AMapGeoPoint locationWithLatitude:39.994949 longitude:116.447265];
//    naviRequest.destination = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.447265];
//    
//    //发起路径搜索
//    [_mapSearchApi AMapNavigationSearch: naviRequest];

    
    
    
#pragma mark 正向地理编码
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey: APIKey Delegate:self];
//    //构造 AMapGeocodeSearchRequest 对象,address 为必选项,city 为可选项
//    AMapGeocodeSearchRequest *geoRequest = [[AMapGeocodeSearchRequest alloc] init]; geoRequest.searchType = AMapSearchType_Geocode;
//    geoRequest.address = @"西单";
//    geoRequest.city = @[@"beijing"];
//    //发起正向地理编码
//    [_mapSearchApi AMapGeocodeSearch: geoRequest];
    
  
    
#pragma mark 逆地理编码
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey: APIKey Delegate:self];
//    //构造 AMapReGeocodeSearchRequest 对象,address 为必选项,city 为可选项
//    AMapReGeocodeSearchRequest *reGeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
//    reGeoRequest.searchType = AMapSearchType_ReGeocode;
//    reGeoRequest.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
//    reGeoRequest.radius = 10000;
//    reGeoRequest.requireExtension = YES;
//    //发起逆地理编码
//    [_mapSearchApi AMapReGoecodeSearch: reGeoRequest];


#pragma mark 公交站查询
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
//    
//    //构造AMapBusStopSearchRequest对象
//    AMapBusStopSearchRequest *busStopRequest = [[AMapBusStopSearchRequest alloc] init];
//    busStopRequest.keywords = @"信息工程学院";
//    busStopRequest.city = @[@"chengdu"];
//    
//    //发起公交站查询
//    [_mapSearchApi AMapBusStopSearch:busStopRequest];

    
    
    
#pragma mark 公交线路查询
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
//    
//    //构造AMapBusStopSearchRequest对象
//    AMapBusLineSearchRequest *busLineRequest = [[AMapBusLineSearchRequest alloc] init];
//    busLineRequest.keywords = @"304";
//    busLineRequest.city = @[@"chengdu"];
//    busLineRequest.requireExtension = YES;
//    
//    
//    //发起公交站查询
//    [_mapSearchApi AMapBusLineSearch: busLineRequest];
    
    
    
    
#pragma mark 输入提示搜索
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
//    
//    //构造AMapInputTipsSearchRequest对象
//    AMapInputTipsSearchRequest *inputTipsRequest = [[AMapInputTipsSearchRequest alloc] init];
//    inputTipsRequest.searchType = AMapSearchType_InputTips;
//    inputTipsRequest.keywords = @"茶";
//    inputTipsRequest.city = @[@"北京"];
//    
//    
//    //发起输入提示搜索
//    [_mapSearchApi AMapInputTipsSearch:inputTipsRequest];



    
#pragma mark 行政区划查询     栗子代码中有个类找不到
//    //初始化检索对象
//    _mapSearchApi = [[AMapSearchAPI alloc] initWithSearchKey:APIKey Delegate:self];
//    //构造 AMapDistrictSearchRequest 对象,keywords 为必选项
//    AMapDistrictSearchRequest *districtRequest = [[AMapDistrictSearchRequest alloc] init];
//    districtRequest.keywords = @"阜城县";
//    districtRequest.requireExtension = YES;
//    
//    //发起行政区划查询
//    [_mapSearchApi AMapDistrictSearch:districtRequest];

    


#pragma mark 两点之间的直线距离
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(39.989612,116.480972));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(39.990347,116.480441));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    NSLog(@"\ndistance = %lf米",distance);
    
    
    
    
#pragma mark 判断点是否在可视范围     暂时不可用
//    //1.将 annotation 的经纬度点转成投影点
//    MAMapPoint point = MAMapPointForCoordinate(annotation.coordinate); //2.判断该点是否在地图可视范围
//    BOOL isContains = MAMapRectContainsPoint(_mapView.visibleMapRect, point);
    
    
    


}


/**
    配置高德地图SDK Key
 */
- (void) congfigMAMap {
    [MAMapServices sharedServices].apiKey = APIKey;
}


/**
    申请定位权限
 */
-  (void) initLocation{
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
    if (adcode.length > 0)    {
        place.city = @[adcode];
    }
    //发起查询
    [_mapSearchApi  AMapPlaceSearch:place];
}




#pragma mark -- MAMapViewDelegate --
- (MAAnnotationView *) mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
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



#pragma mark -- AMapSearchDelegate --
//POI查询回调函数
-  (void) onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse  *)response{
    if (response.pois.count == 0)
        return;
    
    
    NSMutableArray  *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    [response.pois  enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        MAPointAnnotation *poi = [[MAPointAnnotation alloc] init];
        [poi setTitle:obj.name];
        [poi setCoordinate:CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude)];
        [poiAnnotations  addObject: poi];
    }];
    
    /*  将结果以annotation的形式加载到地图上. */
    [_mapView addAnnotations:poiAnnotations];
    
    
    if (poiAnnotations.count == 1) {        /*  如果只有一个结果，设置其为中心点. */
        
        _mapView.centerCoordinate = [poiAnnotations[0] coordinate];
        
    }else {         /* 如果有多个结果, 设置地图使所有的annotation都可见. */
        
        [_mapView showAnnotations:poiAnnotations animated:YES];
    }
    
    
    
}

//实时更新用户位置的回调函数
-(void) mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if(updatingLocation) {          //判断是否有更新
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

//实现路径搜索的回调函数
- (void) onNavigationSearchDone:(AMapNavigationSearchRequest *) request response:(AMapNavigationSearchResponse *)response{
    if(response.route == nil) {
        return;
    }
    //处理搜索结果
    NSString *route = [NSString stringWithFormat:@"Navi: %@", response.route]; NSLog(@"%@", route);
    //此处并没有将规划路线，显示到地图上
}

//实现正向地理编码的回调函数
- (void) onGeocodeSearchDone:(AMapGeocodeSearchRequest *) request response:(AMapGeocodeSearchResponse *)response{
    if(response.geocodes.count == 0)
        return;
    
    //处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count]; NSString *strGeocodes = @"";
    for (AMapTip *p in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes]; NSLog(@"Geocode: %@", result);
}

//实现逆地理编码的回调函数
- (void) onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if(response.regeocode != nil) {
        //处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@",response.regeocode];
        NSLog(@"ReGeo: %@", result);
    }
}

//实现公交站查询的回调函数
- (void)onBusStopSearchDone:(AMapBusStopSearchRequest *)request response:(AMapBusStopSearchResponse *)response {
    if(response.busstops.count == 0)
        return;
    
    //处理查询结果
    NSString *busStopStr = @"";
    for (AMapBusStop *bs in response.busstops) {
        busStopStr = [NSString stringWithFormat:@"%@\nStop:%@",busStopStr,bs.description];
    }
    NSString *result = [NSString stringWithFormat:@"%ld\n%@\n%@",response.busstops.count, response.suggestion, busStopStr];
    NSLog(@"\n\n\nBusStop:%@", result);
}

//实现公交线路查询的回调函数
- (void)onBusLineSearchDone:(AMapBusLineSearchRequest *)request response:(AMapBusLineSearchResponse *)response {
    if(response.buslines.count == 0)
        return;
    
    //处理查询结果
    NSString *busLineStr = @"";
    for (AMapBusLine *bl in response.buslines) {
        busLineStr = [NSString stringWithFormat:@"%@\nLine:%@",busLineStr,bl.description];
    }
    NSString *result = [NSString stringWithFormat:@"%ld\n%@\n%@",response.buslines.count, response.suggestion, busLineStr];
    NSLog(@"\n\n\nBusStop:%@", result);
}

//实现输入提示的回调函数
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    if(response.tips.count == 0)
        return;
    
    //处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count:%ld",(long)response.count];
    NSString *tipsStr = @"";
    for (AMapTip *tip in response.tips) {
        tipsStr = [NSString stringWithFormat:@"%@\nTip:%@",tipsStr, tip.description];
    }
    
    NSString *result =  [NSString stringWithFormat:@"%@\n%@",strCount,tipsStr];
    NSLog(@"InputTips:%@",result);
    
}

//实现行政区划查询的回调函数
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response {
    if(response.districts.count == 0)
        return;
    
    for (AMapDistrict *dist in response.districts) {
        MAPointAnnotation *poiAnnotation = [[MAPointAnnotation alloc] init];
        poiAnnotation.coordinate = CLLocationCoordinate2DMake(dist.center.latitude, dist.center.longitude);
        poiAnnotation.title = dist.name;
        poiAnnotation.subtitle = dist.adcode;
        [self.mapView addAnnotation:poiAnnotation];
        if (dist.polylines.count > 0) {
            MAMapRect bounds = MAMapRectZero;
            for (NSString *polylineStr in dist.polylines) {
                //CommonUtility类找不到
                //MAPolyline *polyline = [CommonUtility polylineForCoordinateString:polylineStr];
                //[self.mapView addOverlay:polyline];
                //bounds = MAMapRectUnion(bounds, polyline.boundingMapRect);
            }
            [self.mapView setVisibleMapRect:bounds animated:YES];
        }
        // 下级区划
        for (AMapDistrict *subdist in dist.districts) {
            MAPointAnnotation *subAnnotation = [[MAPointAnnotation alloc] init];
            subAnnotation.coordinate = CLLocationCoordinate2DMake(subdist.center.latitude, subdist.center.longitude);
            subAnnotation.title = subdist.name;
            subAnnotation.subtitle = subdist.adcode;
            [self.mapView addAnnotation:subAnnotation];
        }
    }
}



/**
    屏幕截图，保存到指定的文件
 */
- (void) saveSnapshotInRect:(CGRect) rect toFile:(NSString *) filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [[MyGlobalHelper getSandboxDirectoryForDocuments] stringByAppendingPathComponent:@"test"];
    
    // 创建目录
    BOOL res = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (!res) {
        NSLog(@"文件夹创建失败");
        return;
    } else {
        NSLog(@"文件夹创建成功");
    }
    
    
    //创建文件
    NSString *testPath = [testDirectory stringByAppendingPathComponent: filename ? filename : @"test.jpg"];
    UIImage *screenshotImage = [_mapView takeSnapshotInRect:rect];
    res = [fileManager createFileAtPath:testPath contents:UIImageJPEGRepresentation(screenshotImage, 1) attributes:nil];
    if (res) {
        NSLog(@"图片保存成功: %@" ,testPath);
    }else
        NSLog(@"图片保存失败");
    
    
}




/**
    响应UISteper的 UIControlEventEditingChanged 事件
 */
- (void) steperValueChanged:(UIStepper *) stepper {
    if (stepper.value  > _previousValue) {      //点击了加号
        [_mapView setZoomLevel:_mapView.zoomLevel + 0.5 animated:YES];
    } else {        //点击了减号
        [_mapView setZoomLevel:_mapView.zoomLevel - 0.5 animated:YES];
    }
    _previousValue = stepper .value ;
}





























@end
