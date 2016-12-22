//
//  dfdfdf.m
//  klaster
//
//  Created by Menny Alterscu on 12/6/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import "dfdfdf.h"

@implementation dfdfdf



/*
 //
 //  Vc1.m
 //  klaster
 //
 //  Created by Menny Alterscu on 12/4/16.
 //  Copyright © 2016 Menny Alterscu. All rights reserved.
 //
 
 #import "Vc1.h"
 #import "Spot.h"
 #import "NonHierarchicalDistanceBasedAlgorithm.h"
 #import "GDefaultClusterRenderer.h"
 #import "Macros.h"
 
 @interface Vc1 ()<GMSMapViewDelegate,CLLocationManagerDelegate>
 
 @property(strong,nonatomic) NSMutableArray* instaPinsArray;
 
 @property(strong,nonatomic) NSMutableArray* clusteredPinsArray;
 
 
 @end
 #define SCREEN [UIScreen mainScreen].bounds
 @implementation Vc1{
 GMSMapView *mapView;
 GClusterManager *clusterManager;
 }
 
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 _instaPinsArray = [NSMutableArray array];
 _clusteredPinsArray = [NSMutableArray array];
 GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:32.917864
 longitude:35.293715
 zoom:14];
 
 mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
 mapView.myLocationEnabled = NO;
 mapView.settings.myLocationButton = NO;
 mapView.settings.compassButton = NO;
 self.view = mapView;
 
 clusterManager = [GClusterManager managerWithMapView:mapView
 algorithm:[[NonHierarchicalDistanceBasedAlgorithm alloc] init]
 renderer:[[GDefaultClusterRenderer alloc] initWithMapView:mapView]];
 
 [mapView setDelegate:clusterManager];
 
 [self setDatabse];
 
 [clusterManager cluster];
 }
 
 -(void)setDatabse
 {
 NSLog(@"create database with realm tech for the first time");
 
 
 
 NSDictionary *jsonDict = [NSDictionary dictionary];
 
 
 NSMutableDictionary* tt = [NSMutableDictionary dictionary];
 
 NSMutableArray* resultZ = [NSMutableArray array];
 
 [tt setObject:resultZ forKey:@"results"];
 
 
 
 jsonDict = [NSDictionary dictionaryWithDictionary:tt];
 
 
 
 NSString* path  = [[NSBundle mainBundle] pathForResource:@"worker" ofType:@"json"];
 
 NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
 
 NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
 
 NSError *jsonError;
 
 NSDictionary *arrayResult = [NSDictionary dictionary];
 
 resultZ = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
 
 
 
 
 for (int i=0; i<[resultZ count]; i++) {
 
 arrayResult = [resultZ objectAtIndex:i];
 
 Spot* spot = [[Spot alloc] init];
 spot.location = CLLocationCoordinate2DMake( [[arrayResult objectForKey:@"latitude"] doubleValue],[[arrayResult objectForKey:@"longitude"]  doubleValue]);
 [clusterManager addItem:spot];
 
 }
 
 
 for (int i = 0 ; i < ((NSArray*)jsonDict[@"results"]).count; i ++)
 {
 double delayInSeconds = 0.2;
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
 
 //code to be executed on the main queue after delay
 
 float rndID = (arc4random()%999);
 NSString* testingTitle;
 if(i % 2 == 0)
 {
 testingTitle = @"room";
 }
 else
 {
 testingTitle = @"user";
 }
 
 
 
 
 NSDictionary* thisResult = [((NSArray*)jsonDict[@"results"]) objectAtIndex:i];
 
 //[GENERALDATA.markersDict setObject:@"aa" forKey:[NSString stringWithFormat:@"%@", [thisResult objectForKey:@"id"]]];
 
 
 [self seedMarkersWithLat:[[thisResult objectForKey:@"lat"]floatValue] andLon:[[thisResult objectForKey:@"lon"]floatValue] andDic:@{testingTitle:@"Type"}];
 
 
 });
 
 
 }
 
 double delayInSeconds = 1.0;
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
 //code to be executed on the main queue after delay
 [_mapView clear];
 
 NSMutableArray* coordinArray = [NSMutableArray array];
 for (int i = 0; i < _instaPinsArray.count; i ++)
 {
 
 
 // for (int i=0; i<12; i++) {
 Spot* spot = [self generateSpotWithMarker:((GMSMarker*)[_instaPinsArray objectAtIndex:i])];
 [clusterManager addItem:spot];
 // }
 
 [clusterManager cluster];
 
 
 //                CLLocationCoordinate2D new_coordinate;
 //                new_coordinate.latitude = ((GMSMarker*)[_instaPinsArray objectAtIndex:i]).position.latitude;
 //                new_coordinate.longitude = ((GMSMarker*)[_instaPinsArray objectAtIndex:i]).position.longitude;;
 
 
 //   CLLocationCoordinate2DMake(((GMSMarker*)[_instaPinsArray objectAtIndex:i]).position, ((GMSMarker*)[_instaPinsArray objectAtIndex:i]).position);
 
 
 //[coordinArray addObject:new_coordinate];
 }
 
 
 // [self centerCoordinateForCoordinates:[NSArray arrayWithArray:_instaPinsArray]]
 
 
 });
 
 
 }
 
 
 
 - (Spot*)generateSpotWithMarker:(GMSMarker*)marker {
 
 //    GMSMarker *marker = [[GMSMarker alloc] init];
 //    marker.title = [NSString stringWithFormat:@"Test %f", [self getRandomNumberBetween:1 maxNumber:100]];
 //    marker.position = CLLocationCoordinate2DMake(
 //                                                 [self getRandomNumberBetween:51.38494009999999 maxNumber:51.6723432],
 //                                                 [self getRandomNumberBetween:-0.3514683 maxNumber:0.148271]);
 
 Spot* spot = [[Spot alloc] init];
 spot.location = marker.position;
 
 //[marker setTitle:@"YOYO"];
 spot.marker = marker;
 
 
 
 [_clusteredPinsArray addObject:spot.marker];
 
 return spot;
 }
 
 
 - (Spot*)generateSpotWithMarker:(GMSMarker*)marker AndUserData:(NSArray*)data{
 
 //    GMSMarker *marker = [[GMSMarker alloc] init];
 //    marker.title = [NSString stringWithFormat:@"Test %f", [self getRandomNumberBetween:1 maxNumber:100]];
 //    marker.position = CLLocationCoordinate2DMake(
 //                                                 [self getRandomNumberBetween:51.38494009999999 maxNumber:51.6723432],
 //                                                 [self getRandomNumberBetween:-0.3514683 maxNumber:0.148271]);
 
 
 
 
 Spot* spot = [[Spot alloc] init];
 spot.location = marker.position;
 
 //[marker setTitle:@"YOYO"];
 spot.marker = marker;
 
 
 
 [_clusteredPinsArray addObject:spot.marker];
 
 return spot;
 }
 
 -(void)seedMarkersWithLat:(float)latT andLon:(float)lonT andDic:(NSDictionary*)dic
 {
 
 GMSMarker *tempMarker;
 
 tempMarker = [[GMSMarker alloc] init];
 tempMarker.position = CLLocationCoordinate2DMake(latT, lonT);
 tempMarker.userData = dic;
 
 //    NSMutableArray* ttt = [NSMutableArray array];
 //    [ttt addObject:@"WROAR"];
 //    tempMarker.userData = [[NSArray alloc]initWithArray:ttt];
 
 
 UIImage* toBeIconW = [UIImage imageNamed:@"mapover"];
 
 toBeIconW = [self imageWithImage:toBeIconW scaledToSize:CGSizeMake(SCREEN.size.width/10, SCREEN.size.width/7.5)];
 
 
 
 
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,60,60)];
 UIImageView *pinImageView = [[UIImageView alloc] initWithImage:toBeIconW];
 UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15,5,60,60)];
 
 
 label.textColor = [UIColor whiteColor];
 label.text = @"";
 //label.font = ...;
 [label sizeToFit];
 
 [view addSubview:pinImageView];
 [view addSubview:label];
 //i.e. customize view to get what you need
 
 
 UIImage *markerIcon = [self imageFromView:view];
 tempMarker.icon = markerIcon;
 
 
 [_instaPinsArray addObject:tempMarker];
 
 
 
 }
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 
 - (UIImage *)imageFromView:(UIView *) view
 {
 if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
 UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
 } else {
 UIGraphicsBeginImageContext(view.frame.size);
 }
 [view.layer renderInContext: UIGraphicsGetCurrentContext()];
 UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return image;
 }
 
 -(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
 // Pass 1.0 to force exact pixel size.
 UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
 [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 return newImage;
 }
 
 
 
 
 
 @end

 
 
 
 */
@end
