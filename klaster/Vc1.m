//
//  Vc1.m
//  klaster
//
//  Created by Menny Alterscu on 12/4/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import "Vc1.h"
#import "MennyDataSourceAutoComlete.h"
#import "klaster-Swift.h"
#import "DWBubbleMenuButton.h"
#import "userCell.h"


@interface Vc1 ()<GMSMapViewDelegate,CLLocationManagerDelegate,AW_NavigateDelegate>
@property (strong,nonatomic) userCell *cell;
//
@property (strong,nonatomic) IBOutlet BetterSegmentedControl *oneswitch;
- (IBAction)betteChange:(BetterSegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sampleLabel;
@property (nonatomic, strong)  UIImage* toBeIcon;
@property (nonatomic, strong)  GMSCameraPosition *camera;
@property (nonatomic) BOOL IsSerchByRoom;

//
@property(nonatomic) CGFloat latCUR;
@property(nonatomic) CGFloat lonCUR;

@end
#define SCREEN [UIScreen mainScreen].bounds
NSString  *const GoogleKey = @"AIzaSyAUBg3xOdDpYtLUaQi3VVLIV1tOA68J314";

@implementation Vc1{
    
    GClusterManager *clusterManager;
}
int mapMovesCounterTT = 0;
float latISR = 31.82222;
float lonISR = 34.92222;
float const base_ZOOM = 2;
@synthesize sampleLabel = _sampleLabel;
@synthesize autoCompleterarry = _autoCompleter;



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   


    
    
    
   
    
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   // [mapView addSubview:_txtSerch];

  
        [self re_find_me];

 
//    double delayInSeconds = 4.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//    //        //code to be executed on the main queue after delay
//            
//            //mark MAP FUNC
//  //  [self markerMyMapWithDict:@{}];
//            
//            [self setDatabse];
//        });
    

    self.oneswitch.titles = @[@"חדר",@"כתובת"];
    self.vewiDrop2.hidden =YES;
    _txtAddress.alpha =1.0f;
    _txtAddress.delegate= self;
    
    
    UILabel *homeLabel = [self createHomeButtonView];
    
    
    // Create up menu button
    homeLabel = [self createHomeButtonView];
    
    DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width -25,
                                                                                          self.view.frame.size.height - homeLabel.frame.size.height - 10.f,
                                                                                          homeLabel.frame.size.width+20,
                                                                                          homeLabel.frame.size.height)
                                                            expansionDirection:DirectionUp];
    //upMenuView.backgroundColor = [UIColor yellowColor];
    upMenuView.homeButtonView = homeLabel;
    
    [upMenuView addButtons:[self createDemoButtonArray]];
    
    UIWindow *frontWindow = [[[UIApplication sharedApplication] windows]
                             lastObject];
   
    [frontWindow addSubview:upMenuView];
    
}
-(void)re_find_me
{
    _locationManager = [[AW_Navigate alloc]initWithUseAuthorizationStatus:kCLAuthorizationStatusAuthorizedWhenInUse];
    _locationManager.delegate = self;
    _markerU = [[GMSMarker alloc] init];
    [_locationManager startLocationServices];
    
   
    

\
}



-(void)AW_Navigate:(AW_Navigate *)awNav didGetCurrentLocation:(CLLocation *)location
{
    
    // MARKER FOR MY LOCATION
    
    double lat = location.coordinate.latitude;

    double lng = location.coordinate.longitude;
    
    NSLog(@">>>>>>>>>>>>>>ME!!!!!!!>>>>>>>>>>>>.%f",location.coordinate.latitude);
    NSLog(@">>>>>>>>>>>>>>ME!!!!!!!>>>>>>>>>>>>.%f",location.coordinate.longitude);
    
    _markerU.position = CLLocationCoordinate2DMake(lat, lng);
    _markerU.title = @"ME";
    
    _toBeIcon = [UIImage imageNamed:@"searchuserover"];
    
    _toBeIcon = [self imageWithImage:_toBeIcon scaledToSize:CGSizeMake(SCREEN.size.width/7, SCREEN.size.width/7)];
    
    _markerU.icon = _toBeIcon;
    _markerU.map = _mapView;
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        
        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithFloat: 1.7f] forKey:kCATransactionAnimationDuration];
        _camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude  longitude:location.coordinate.longitude zoom: 15];
        [_mapView animateToCameraPosition: _camera];
        [CATransaction commit];
    });

    [_locationManager stopUpdatingLocations];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _instaPinsArray = [NSMutableArray array];
    _clusteredPinsArray = [NSMutableArray array];
    
  
    _camera = [GMSCameraPosition cameraWithLatitude:latISR
                                                            longitude:lonISR
                                                                 zoom:base_ZOOM];
    
//    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    mapView.myLocationEnabled = NO;
//    mapView.settings.myLocationButton = YES;
//    mapView.settings.compassButton = NO;
//    self.view = mapView;
    
    _mapView.settings.zoomGestures = YES;
    _mapView.settings.rotateGestures = NO;
    _mapView.settings.tiltGestures = NO;
    _mapView.camera = _camera;
    
    
    
    _mapView.delegate = self;

    
    
    clusterManager = [GClusterManager managerWithMapView:_mapView
                                               algorithm:[[NonHierarchicalDistanceBasedAlgorithm alloc] init]
                                                renderer:[[GDefaultClusterRenderer alloc] initWithMapView:_mapView]];
    
    [_mapView setDelegate:clusterManager];
    [clusterManager setDelegate:self];
    
    
    [self setDatabse];
    
    [clusterManager cluster];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Gobitch:)
                                                 name:@"GOME"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloaddatawithNewpredict:)
                                                 name:@"GETPREDICT"
                                               object:nil];
    


}

-(void)Gobitch:(NSNotification*)marker
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        
        [CATransaction begin];
        [CATransaction setValue:[NSNumber numberWithFloat: 1.7f] forKey:kCATransactionAnimationDuration];
        _camera = [GMSCameraPosition cameraWithLatitude:((GMSMarker*)[marker object]).position.latitude  longitude: ((GMSMarker*)[marker object]).position.longitude zoom: 15];
        [_mapView animateToCameraPosition: _camera];
        [CATransaction commit];
    });
    
}
-(void)markerMyMapWithDict:(NSDictionary*)jsonDict
{
    
    
    for (int i = 0; i < ((NSArray*)jsonDict[@"results"]).count; i ++) {
        
        double delayInSeconds = 0.2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            
            float rndID = (arc4random()%999);
            
            
            NSString* testingTitle;
            if(i % 2 == 0)
            {
                testingTitle = [NSString stringWithFormat:@"ROOM"];
            }
            else
            {
                testingTitle = [NSString stringWithFormat:@"USER"];
            }
            
            
            
            
            NSDictionary* thisResult = [((NSArray*)jsonDict[@"results"]) objectAtIndex:i];
            
          //  [GENERALDATA.markersDict setObject:@"aa" forKey:[NSString stringWithFormat:@"%@", [thisResult objectForKey:@"id"]]];
            
            
           [self seedMarkersWithLat:[[thisResult objectForKey:@"latitude"]floatValue] andLon:[[thisResult objectForKey:@"longitude"]floatValue] andTitle:testingTitle];
            
            
            
        });
        
        
        
    }
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
       // [mapView clear];
        
        NSMutableArray* coordinArray = [NSMutableArray array];
        for (int i = 0; i < _instaPinsArray.count; i ++)
        {
            
            
            // for (int i=0; i<12; i++) {
            Spot* spot = [self generateSpotWithMarker:((GMSMarker*)[_instaPinsArray objectAtIndex:i])];
            [clusterManager addItem:spot];
            // }
            
            [clusterManager cluster];
            
        }
        
    });
    
//    _markerU.title = @"MENNY";
//    Spot* spot = [self generateSpotWithMarker:_markerU];
//    [clusterManager addItem:spot];
    // }
    
    [clusterManager cluster];
    

}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    if(marker == _markerU)
    {
        marker.title = @"menny";
        return YES;
    }
    if([marker.title isEqualToString:@"ME"])
    {
        NSLog(@">>>>>>>>>>>>>>>>>>>>>FOUND ME>>>>>>>>>>>>>>>>>>>");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GOME" object:marker];
    }
    

    if(((NSArray*)marker.userData).count >0&&((NSArray*)marker.userData).count >1)
    {
        
        NSLog(@">>>>>>>>>>>>>>>>>>>>>THIS IS CLUSTER>>>>>>>>>>>>>>>>>>");
        
        [self.view addSubview:_uservcpop];
        _uservcpop.frame = CGRectMake(0, SCREEN.size.height-self.uservcpop.frame.size.height -50 , SCREEN.size.width, self.uservcpop.frame.size.height);
//        _pop = [[KLCPopup alloc]init];
//        _usersPop = [UsersTablePop customView];
//        _pop.contentView = _usersPop;
//        _pop.showType=(KLCPopupShowType)KLCPopupShowTypeSlideInFromBottom;
//        _pop.dismissType=(KLCPopupDismissType)KLCPopupDismissTypeSlideOutToBottom;
////        _pop.maskType =KLCPopupMaskTypeNone;
//        [_pop show];
        
    }
    else
    {
        
        NSLog(@">>>>>>>>>>>>>>>>>>>>>THIS IS SINGLE MARKER>>>>>>>>>>>>>>>>>>");
        
    }
    return NO;
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

-(void)seedMarkersWithLat:(float)latT andLon:(float)lonT andTitle:(NSString*)title
{
    
    GMSMarker *tempMarker;
    
    tempMarker = [[GMSMarker alloc] init];
    tempMarker.position = CLLocationCoordinate2DMake(latT, lonT);
    tempMarker.title = title;
    
    NSMutableArray* ttt = [NSMutableArray array];
    [ttt addObject:@"WROAR"];
    tempMarker.userData = [[NSArray alloc]initWithArray:ttt];
    
    
//    UIImage* toBeIconW = [UIImage imageNamed:@""];
//    
//    toBeIconW = [self imageWithImage:toBeIconW scaledToSize:CGSizeMake(SCREEN.size.width/10, SCREEN.size.width/7.5)];
//    
//    
//    
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,60,60)];
//    UIImageView *pinImageView = [[UIImageView alloc] initWithImage:toBeIconW];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15,5,60,60)];
//    
//    
//    label.textColor = [UIColor whiteColor];
//    label.text = @"";
//    //label.font = ...;
//    [label sizeToFit];
//    
//    [view addSubview:pinImageView];
//    [view addSubview:label];
//    //i.e. customize view to get what you need
//    
//    
//    UIImage *markerIcon = [self imageFromView:view];
//    tempMarker.icon = markerIcon;
    
    
    
    // tempMarker.map = _mapView;
    
    [_instaPinsArray addObject:tempMarker];
    
    
    
    
    
}

-(void)setDatabse
{
    NSLog(@"create database with realm tech for the first time");
    
    ///PO KORE SHATAT!!!
    
    NSMutableDictionary* tt = [NSMutableDictionary dictionary];
    
    NSMutableArray* resultZ = [NSMutableArray array];

    NSString* path  = [[NSBundle mainBundle] pathForResource:@"worker" ofType:@"json"];
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;

    NSDictionary *arrayResult = [NSDictionary dictionary];
    
    resultZ = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
    
    [tt setObject:resultZ forKey:@"results"];
    
    [self markerMyMapWithDict:tt];
}

    
    
    
    
    
    
//    
//    for (int i=0; i<[resultZ count]; i++) {
//        
//        arrayResult = [resultZ objectAtIndex:i];
//        
//        Spot* spot = [[Spot alloc] init];
//        spot.location = CLLocationCoordinate2DMake( [[arrayResult objectForKey:@"latitude"] doubleValue],[[arrayResult objectForKey:@"longitude"]  doubleValue]);
//        [clusterManager addItem:spot];
//        
//    }
//
//        
//        
//        for (int i = 0; i < ((NSArray*)jsonDict[keyDResults]).count; i ++) {
//            
//            double delayInSeconds = 0.2;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                
//                //code to be executed on the main queue after delay
//                //
//                float rnd1 = (arc4random()%9);
//                
//                float rnd2 = (arc4random()%9);
//                
//                float rndID = (arc4random()%999);
//                
//                
//                NSString* testingTitle;
//                if(i % 2 == 0)
//                {
//                    testingTitle = [NSString stringWithFormat:@"%f#YES",rndID];
//                }
//                else
//                {
//                    testingTitle = [NSString stringWithFormat:@"%f#NO",rndID];
//                }
//                
//                
//                
//                
//                NSDictionary* thisResult = [((NSArray*)jsonDict[keyDResults]) objectAtIndex:i];
//                
//                [GENERALDATA.markersDict setObject:@"aa" forKey:[NSString stringWithFormat:@"%@", [thisResult objectForKey:@"id"]]];
//                
//                
//                [self seedMarkersWithLat:[[thisResult objectForKey:@"lat"]floatValue] andLon:[[thisResult objectForKey:@"lon"]floatValue] andTitle:@"balls #and a half"];
//                
//                
                //CLLocationCoordinate2DMake(latT, lonT);
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// FIND MY LOCATION





#pragma  MARk GAMES WITH IMAGES


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


#pragma mark - GMSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay
{
}


-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
    NSLog(@"Moved Now");
    
    [_ivEmptyPin setCenter:_mapView.center];
    
    [self.view addSubview:_ivEmptyPin];
    
    
    
    //    double delayInSeconds = 0.5;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        //code to be executed on the main queue after delay
    //        //////*/*/*/*/*/*/ PannedPin   ///*/*/*/*/*/*/**/*/*/
    //
    //        [_ivEmptyPin setCenter:_mapView.center];
    //
    //        [self.view addSubview:_ivEmptyPin];
    //
    //        if(_canShowEmptyPin)
    //        {
    //            double delayInSeconds = 0.1;
    //            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //                //code to be executed on the main queue after delay
    //
    //                [UIView animateWithDuration:0.3 animations:^{
    //                    _ivEmptyPin.alpha = 1.0f;
    //                }completion:^(BOOL finished) {[AppData sharedInstance].noActivityIndicatorShown = YES;}];
    //
    //
    //            });
    //
    //        }
    //
    //        _canShowEmptyPin = YES;
    //
    //
    //
    //
    //        //////*/*/*/*/*/*/ PannedPin   ///*/*/*/*/*/*/**/*/*/
    //    });
    
    
    
    
}
//
-(BOOL)calculateDistanceBetweenSource:(CLLocationCoordinate2D)firstCoords andDestination:(CLLocationCoordinate2D)secondCoords
{
    
    // this radius is in KM => if miles are needed it is calculated during setter of Place.distance
    
    double nRadius = 6371;
    
    // Get the difference between our two points
    
    // then convert the difference into radians
    
    double nDLat = (firstCoords.latitude - secondCoords.latitude)* (M_PI/180);
    double nDLon = (firstCoords.longitude - secondCoords.longitude)* (M_PI/180);
    
    double nLat1 =  secondCoords.latitude * (M_PI/180);
    double nLat2 =  secondCoords.latitude * (M_PI/180);
    
    double nA = pow ( sin(nDLat/2), 2 ) + cos(nLat1) * cos(nLat2) * pow ( sin(nDLon/2), 2 );
    
    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
    
    double nD = nRadius * nC;
    
    NSLog(@"Distance is %f",nD);
    
    if(nD > 0.1)
    {
        
        //        _canShowEmptyPin = YES;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            // _ivEmptyPin.alpha = 1.0f;
        }completion:^(BOOL finished) {/*[AppData sharedInstance].noActivityIndicatorShown = YES;*/}];
        
        
        
        return YES;
        
        
    }
    else
    {
        //        _canShowEmptyPin = NO;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            _ivEmptyPin.alpha = 0.0f;
        }completion:^(BOOL finished) {/*[AppData sharedInstance].noActivityIndicatorShown = YES;*/}];
        
        
        return NO;
        
    }
    
    //return nD; // converts to miles or not (if en_) => implicit in method
}

-(double)calculateDistanceBetweenSourceToFloat:(CLLocationCoordinate2D)firstCoords andDestination:(CLLocationCoordinate2D)secondCoords
{
    
    // this radius is in KM => if miles are needed it is calculated during setter of Place.distance
    
    double nRadius = 6371;
    
    // Get the difference between our two points
    
    // then convert the difference into radians
    
    double nDLat = (firstCoords.latitude - secondCoords.latitude)* (M_PI/180);
    double nDLon = (firstCoords.longitude - secondCoords.longitude)* (M_PI/180);
    
    double nLat1 =  secondCoords.latitude * (M_PI/180);
    double nLat2 =  secondCoords.latitude * (M_PI/180);
    
    double nA = pow ( sin(nDLat/2), 2 ) + cos(nLat1) * cos(nLat2) * pow ( sin(nDLon/2), 2 );
    
    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
    
    double nD = nRadius * nC;
    
    NSLog(@"Distance is %f",nD);
    
    
    return nD; // converts to miles or not (if en_) => implicit in method
}

-(int)getZoom:(double)distance
{
    int ZOOM = 8;
    if(distance  > 19)
    {
        return 8;
    }
    
    if(distance < 19 && distance > 15)
    {
        return 8;
    }
    
    if(distance < 15 && distance > 10)
    {
        return 9;
    }
    
    
    if(distance < 10 && distance > 5)
    {
        return 10;
    }
    
    if(distance < 5 && distance > 3)
    {
        return 11;
    }
    
    
    if(distance < 3 && distance > 1)
    {
        return 12;
    }
    
    
    if(distance < 1 && distance > 0.5)
    {
        return 13;
    }
    
    
    if(distance < 0.5 && distance > 0)
    {
        return 14;
    }
    
    return ZOOM;
    
}


#pragma  MARK AUTOCOMLEETE CATRING


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    self.txtAddress.text = @"";
    
}

-(BOOL)textFieldShouldClear:(UITextField *)textField

{
    //
    //    [self hideGoButton];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    UITextInputMode *inputMode = [textField textInputMode];
    _languageFromText = inputMode.primaryLanguage;
    
    _languageFromText = [_languageFromText substringToIndex:2];  // <-- 2, not 1
    
    
    //Prevent Emoji
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage])
    {
        return NO;
    }
    
    
    
  
    
            NSString* text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            //  self.tableMode = search;
            
            //        [self hideGoButton];
            
            if (text.length > 0)
            {
                
                // [_btnGlassSmall setImage:[UIImage imageNamed:@"searchover"] forState:UIControlStateNormal];
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    
                    _viewDrop.alpha = 1.0f;
                    
                    
                    
                }completion:^(BOOL finished) {
                    
                    
                }];
            }
            
            else {
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    
                    
                    // [_viewDrop setFrame:(CGRectMake(_txtSerchAdress.frame.origin.x, _txtSerchAdress.frame.origin.y, _viewDrop.frame.size.width, 190))];
                    
                    //  _ivMessageBox.alpha = 0.0f;
                    //  _lblMessagesCount.alpha = 0.0f;
                    //                if(_canShowEmptyPin)
                    //                {
                    _viewDrop.alpha = 0.0f;
                    
                    //                }
                    
                }completion:^(BOOL finished) {
                }];
                //            [self hideEditAddressView];
                
            }
            if ([string isEqualToString:@""])
            {
                //            self.txtHouseNumber.hidden = YES;
                //            self.txtHouseNumber.text = @"";
            }
            
            [self sendTextForPredictions:text];
        
        
        
  
    
    
    
    
    
    return YES;
    
}





#pragma mark - TableView



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"getAddressCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //    if (self.tableMode == search)
    //    {
    if(!_IsSerchByRoom)
    {
        NSAttributedString* text = [self getAddressWithBoldMatchForPrediction:[self.dataSource objectAtIndex:indexPath.row]];
        cell.textLabel.attributedText = text;
    }
    else
    {
        NSAttributedString* text =[self getAddressWithBold:[self.dataSource objectAtIndex:indexPath.row]];
        cell.textLabel.attributedText = text;

    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    //cell.textLabel.textAlignment = NSTextAlignmentRight;
    cell.textLabel.numberOfLines = 2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)reAlloc_addressSearchParamsDict
{
    _addressSearchParamsDict = [NSMutableDictionary dictionary];
    
    [_addressSearchParamsDict setObject:@"" forKey:@"address"];
    [_addressSearchParamsDict setObject:@"" forKey:@"city"];
    [_addressSearchParamsDict setObject:@"" forKey:@"street"];
    [_addressSearchParamsDict setObject:@"" forKey:@"neighborhood"];
    [_addressSearchParamsDict setObject:@"" forKey:@"lat"];
    [_addressSearchParamsDict setObject:@"" forKey:@"lon"];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.tableMode == search)
    //    {
    
    [self reAlloc_addressSearchParamsDict];
    if(!_IsSerchByRoom)
    {
        _main_Search_type = @"address";
        
        
        
        NSDictionary* selectedPredict = [self.dataSource objectAtIndex:indexPath.row];
        
        
        NSString *str =  [selectedPredict valueForKey:@"description"];
        self.txtAddress.text = @"";
        
        [self sendPredictToGetDetailsWithPlaceID:selectedPredict[@"place_id"]];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            self.txtAddress.text = str;
            self.txtAddress.adjustsFontSizeToFitWidth = YES;
            
            //**************SAVE THE ADRESS TO SEND SERVER BLANLA**************//
            
            
            //        GENERALDATA.Adress = str;
            NSLog(@"%@",selectedPredict);
            
            
            _viewDrop.alpha = 0.0f;
            
            
            
            
            //
            //                }
            
        }completion:^(BOOL finished) {
        }];
    
    }
    
    
    _defaultAddressString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    self.txtAddress.text = _defaultAddressString;
    
    self.tblDrop.hidden = YES;
    
}
-(void)sendPredictToGetDetailsWithPlaceID:(NSString*)placeId
{
    DataPuller* dataPuller = [[DataPuller alloc]init];
    NSString* url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?key=%@&placeid=%@&language=%@",GoogleKey,placeId, _languageFromText];
    dataPuller.pullMode = location;
    dataPuller.delegate = self;
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          [dataPuller sendHttpReqWithUrlString:url];
        //code to be executed on the main queue after delay
        
    });
  
}

-(void)sendTextForPredictions:(NSString*)text
{
    if(!_IsSerchByRoom)
    {
        DataPuller* dataPuller = [[DataPuller alloc]init];
        NSString* url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=%@&language=%@",text,GoogleKey, _languageFromText];
        dataPuller.pullMode = predictions;
        dataPuller.delegate = self;
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [dataPuller sendHttpReqWithUrlString:url];
        });
    }
    else
    {
        //myaotu
        
        
        _dataSource  = [[NSMutableArray alloc]initWithArray:_autoCompleter.prdections];
//        _dataSource = [[NSMutableArray alloc]initWithArray:@[@"ארץ לעולם לא",@"חיפה, הבית של ביגאפפס",@"חיפה,הבית של טים",@"רמת גן ,בינייין משה אביב",@"נתניה, סניף החמורים",@"תל,אביב ת קניון עזריאלי",@"תל אביב, נמל תל אביב",@"תל אביבת דיזנגוף סנטר",@"חיפהת הבית גיא"]];
// 
//        [self.tblDrop reloadData];
        
     
        
       
    }
    
    
}

-(void)reloaddatawithNewpredict:(NSNotification*)not
{
    _dataSource = [[NSMutableArray alloc]initWithArray:(NSMutableArray*)[not object]];
    [self.tblDrop reloadData];
    if (self.tblDrop.hidden)
        //        [self.tableContainerView removeGestureRecognizer:_recognizerEditAddress];
        
        self.tblDrop.hidden = NO;
}


-(NSAttributedString*)getAddressWithBold:(NSString*)string
{
    UIFont *boldFont = [UIFont fontWithName:@"OpenSansHebrew-Bold" size:15];
    UIFont *regularFont = [UIFont fontWithName:@"OpenSansHebrew-Regular" size:15];
    
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentRight;
    
    // Create the attributes
    NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              regularFont, NSFontAttributeName,
                              [UIColor orangeColor],NSForegroundColorAttributeName,
                              nil];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           regularFont, NSFontAttributeName,
                           [UIColor blackColor],NSForegroundColorAttributeName,
                           nil];
    
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:attrs];
    
   
    [title addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, [title length])];
    NSAttributedString* finalTitle = (NSAttributedString*)title;
    
    return finalTitle;

    
    
    
}
-(NSAttributedString*)getAddressWithBoldMatchForPrediction:(NSDictionary*)predict
{
    
    NSString* text = predict[@"description"];
    UIFont *boldFont = [UIFont fontWithName:@"OpenSansHebrew-Bold" size:15];
    UIFont *regularFont = [UIFont fontWithName:@"OpenSansHebrew-Regular" size:15];
    
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.alignment = NSTextAlignmentRight;
    
    // Create the attributes
    NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              regularFont, NSFontAttributeName,
                              [UIColor orangeColor],NSForegroundColorAttributeName,
                              nil];
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           regularFont, NSFontAttributeName,
                           [UIColor blackColor],NSForegroundColorAttributeName,
                           nil];
    
    NSMutableAttributedString *title =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attrs];
    
    for (NSDictionary* match in predict[@"matched_substrings"])
    {
        int index = [match[@"offset"] intValue];
        int length = [match[@"length"] intValue];
        NSRange range = NSMakeRange(index, length);
        [title setAttributes:subAttrs range:range];
        
    }
    [title addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:NSMakeRange(0, [title length])];
    NSAttributedString* finalTitle = (NSAttributedString*)title;
    return finalTitle;
    
}


#pragma mark - DataPullerDelegate
-(void)DataPuller:(DataPuller *)dataPuller hasRerievedDataForType:(PullMode)pullType WithJson:(NSDictionary *)jsonDic fromString:(NSString *)jsonString
{
    
   
    if (pullType == predictions)
    {
        [self gotPredictions:jsonDic[@"predictions"]];
        
        //        [self.tableContainerView removeGestureRecognizer:_recognizerEditAddress];
        
        _tblDrop.hidden = NO;
        
        
    }
    else if (pullType == location)
    {
        [self selectedAddressDetailsWithJson:jsonDic andString:jsonString];
    }
    else  if (pullType == final){
        
        if ([jsonDic[@"predictions"] count]!=0)
        {
            
            
            _place_Id_To_send = [jsonDic[@"predictions"][0] valueForKey:@"place_id"];
            
            
            NSLog(@">*>*>*>******\n\n\n\n\n%@",_place_Id_To_send);
            
            DataPuller* dataPuller = [[DataPuller alloc]init];
            NSString* urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@&language=%@",_addressText,GoogleKey, _languageFromText];
            
            
            dataPuller.pullMode = geoCode;
            dataPuller.delegate = self;
            
            [dataPuller sendHttpReqWithUrlString:urlString];
            
        }
        
    }
    else if (pullType == geoCode)
    {
        
       
        if([[jsonDic objectForKey:@"status"] isEqualToString:@"OK"])
        {
            NSArray* array = [jsonDic objectForKey:@"results"];
            NSDictionary * dict;
            
            if(array)
            {
                dict = [array objectAtIndex:0];
            }
            
            if (dict)
            {
                NSDictionary* geometry = [dict objectForKey:@"geometry"];
                _locationTocheck = [geometry objectForKey:@"location"];
                
                /////////////////////////////////// got location  ---> check location //////////////////
                
                if( 2<3)
                {
                    NSLog(@"YES");
                    
                    [self.view endEditing:YES];
                    
                    
                    double testLat = [_locationTocheck[@"lat"]doubleValue];
                    double testLng = [_locationTocheck[@"lng"]doubleValue];
                    
                    double delayInSeconds = 1.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        
                        
                        [CATransaction begin];
                        [CATransaction setValue:[NSNumber numberWithFloat: 1.7f] forKey:kCATransactionAnimationDuration];
                        _camera = [GMSCameraPosition cameraWithLatitude: testLat longitude: testLng zoom: base_ZOOM];
                        [_mapView animateToCameraPosition: _camera];
                        [CATransaction commit];
                        
                        double delayInSeconds = 2.0;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            //code to be executed on the main queue after delay
                            
                            [CATransaction begin];
                            [CATransaction setValue:[NSNumber numberWithFloat: 1.7f] forKey:kCATransactionAnimationDuration];
                            _camera = [GMSCameraPosition cameraWithLatitude: testLat longitude: testLng zoom: 17];
                            [_mapView animateToCameraPosition: _camera];
                            [CATransaction commit];
                        });
                        
                    });
                    
                   


                    
                }
                else
                {
                    NSLog(@"NO");
                   
                   // [self hideKeyboard];
                    
                    
                    
                    
                    
                }
            }
            
            
        }
        ///***/*/
        
        
        
        
        
    }
    
    
    
    
    
    
    
}





-(void)selectedAddressDetailsWithJson:(NSDictionary*)jsonDict andString:(NSString*)jsonString
{
    [self sendAddressWithOUTHouseNumber];
}

-(void)sendAddressWithOUTHouseNumber
{
    //    NSString* address = [NSString stringWithFormat:@"%@ %@",self.txtHouseNumber.text, self.txtSearch.text];
    
    NSString* address = [NSString stringWithFormat:@"%@", self.txtAddress.text];
    _addressText = address;
    
    [self sendFullFinalAddress:address];
}
-(void)sendFullFinalAddress:(NSString*)text
{
    DataPuller* dataPuller = [[DataPuller alloc]init];
    NSString* url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=%@&                                                                                                                                                                            language=%@",text,GoogleKey, _languageFromText];
    dataPuller.pullMode = final;
    dataPuller.delegate = self;
    [dataPuller sendHttpReqWithUrlString:url];
}
-(void)gotPredictions:(NSArray*)predictions
{
    NSMutableArray* predictionCheck = [[NSMutableArray alloc]init];
   
    for(int i=0; i < predictions.count && i<3 ;i++)
    {
        [predictionCheck addObject:[predictions objectAtIndex:i]];
    }
    
    self.dataSource = [NSMutableArray arrayWithArray:predictionCheck];
    
    
    [self.tblDrop reloadData];
    
   if (self.dataSource.count > 0){//Lena was here
        NSLog(@"SEARCH PLACE_ID = %@", self.dataSource[0][@"place_id"]);
        NSLog(@"SEARCH NAME = %@", self.dataSource[0][@"description"]);
        
        _takenPlaceID = self.dataSource[0][@"place_id"];//Lena was here
    }
    
    if (self.tblDrop.hidden)
        //        [self.tableContainerView removeGestureRecognizer:_recognizerEditAddress];
        
        self.tblDrop.hidden = NO;
}


#pragma  MARK AUTOCOMLEETE HARDCODED

- (MennyDataSourceAutoComlete *)autoCompleter
{
    if (!_autoCompleter)
    {
        NSMutableDictionary *options = [NSMutableDictionary dictionaryWithCapacity:2];
        [options setValue:[NSNumber numberWithBool:YES] forKey:ACOCaseSensitive];
        [options setValue:nil forKey:ACOUseSourceFont];
        
        _autoCompleter = [[MennyDataSourceAutoComlete alloc]initWithNewWithTextField:self.txtAddress inViewController:self withOptions:options];
        
        //handel drop view

        _autoCompleter.MautoCompleteDelegate = self;
        _autoCompleter.suggestionsDictionary = @[@"ארץ לעולם לא",@"חיפה, הבית של ביגאפפס",@"חיפה,הבית של טים",@"רמת גן ,בינייין משה אביב",@"נתניה, סניף החמורים",@"תל,אביב ת קניון עזריאלי",@"תל אביב, נמל תל אביב",@"תל אביבת דיזנגוף סנטר",@"חיפהת הבית גיא"];
    }
    return _autoCompleter;
}


- (IBAction)caseSwitchChanged:(UISwitch *)sender
{
    NSMutableDictionary *options = [self.autoCompleter.options mutableCopy];
    [options setValue:[NSNumber numberWithBool:sender.on] forKey:ACOCaseSensitive];
    self.autoCompleter.options = options;
}

- (IBAction)fontSwitchChanged:(UISwitch *)sender
{
    NSMutableDictionary *options = [self.autoCompleter.options mutableCopy];
    UIFont *cellLabelFont = (sender.on) ? nil : self.sampleLabel.font;
    [options setValue:cellLabelFont forKey:ACOUseSourceFont];
    self.autoCompleter.options = options;
}

- (void)viewDidUnload {
    [self setSampleLabel:nil];
    [self setSampleLabel:nil];
    [super viewDidUnload];
}

#pragma mark - AutoCompleteTableViewDelegate

- (NSArray*) autoCompletion:(MennyDataSourceAutoComlete*) completer suggestionsFor:(NSString*) string{
    // with the prodided string, build a new array with suggestions - from DB, from a service, etc.
   // handel drop view
    self.vewiDrop2.alpha = 1.0f;
    return @[@"ארץ לעולם לא",@"חיפה, הבית של ביגאפפס",@"חיפה,הבית של טים",@"רמת גן ,בינייין משה אביב",@"נתניה, סניף החמורים",@"תל,אביב ת קניון עזריאלי",@"תל אביב, נמל תל אביב",@"תל אביבת דיזנגוף סנטר",@"חיפהת הבית גיא"];;
    
}

- (void) autoCompletion:(MennyDataSourceAutoComlete*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index{
    // invoked when an available suggestion is selected
    NSLog(@"%@ - Suggestion chosen: %ld", completer, (long)index);
    [self.view endEditing:YES];
    //handel dropview
    self.vewiDrop2.alpha = 0.0f;
    //_ChooseStroe = YES;
}



- (IBAction)betteChange:(BetterSegmentedControl *)sender {
    
    
    switch(sender.index)
    {
        case 0:
        {
            NSLog(@"adress");
            _IsSerchByRoom = NO;
            _autoCompleter.isMenny = NO;
            _dataSource = [[NSMutableArray alloc]init];
            _txtAddress.alpha = 1.0f;
           
            _txtAddress.placeholder = @"חפש על פי כתובת";
            _txtAddress.text = @"";
//            [self.view endEditing:YES];
//
//            self.tblDrop.hidden = NO;
//            self.vewiDrop2.hidden =YES;
//            _autoCompleter.alpha  =0.0f;
            
            
        }
            break;
        case 1:
        {
            NSLog(@"room");
             [self.txtAddress addTarget:self.autoCompleter action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
            _txtAddress.alpha =1.0;
            _dataSource = [[NSMutableArray alloc]init];
            _IsSerchByRoom = YES;
            _autoCompleter.isMenny = YES;
//             _autoCompleter.alpha  =1.0f;
            _txtAddress.placeholder = @"חפש על פי חדר";
            _txtAddress.text = @"";
//            [self.view endEditing:YES];
//
//            self.tblDrop.hidden = YES;
//            self.vewiDrop2.hidden =NO;
//            
//            
        }
            break;
        default:break;
            
    }
}



- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0.f, 40.f, 40.f)];
    
    //    label.text = @"Tap";
    //    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor clearColor];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    NSArray *buton = @[@"A", @"B", @"C", @"D", @"E"];
    for ( int i = 0 ; i <= 4; i++ ) {
       

            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

            if(i==4)
            {
                button.frame = CGRectMake(0.f, 0.f, 20.0f, 40.0f);
                //        UIImageView *v1= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
                //        [button addSubview:v1];
                button.layer.cornerRadius = button.frame.size.height / 2.f;
                button.backgroundColor = [UIColor redColor];
                button.alpha = 0 ;
                button.clipsToBounds = YES;
                button.userInteractionEnabled = NO;
                //            button.tag = i++;
                
                
                [buttonsMutable addObject:button];
            }
        else
        {
            
            
            button.frame = CGRectMake(0.f, 0.f, 44, 44);
            //        UIImageView *v1= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search"]];
            //        [button addSubview:v1];
            button.layer.cornerRadius = button.frame.size.height / 2.f;
            button.backgroundColor = [UIColor blueColor];
            button.clipsToBounds = YES;
            button.tag = i;
        
            [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
            
            [buttonsMutable addObject:button];
        }
        
        
       
    }
    
    return [buttonsMutable copy];
}

- (void)test:(UIButton *)sender {
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
}

- (UIButton *)createButtonWithName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (IBAction)btnFindMe:(UIButton *)sender {
    
      [self re_find_me];
}

- (NSInteger)horizontalTableView:(PTEHorizontalTableView *)horizontalTableView RowsInSection:(NSInteger)section
{
     return 15;
}


- (UITableViewCell *)horizontalTableView:(PTEHorizontalTableView *)horizontalTableView
         cellIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    
    //   cell.textLabel.text =objects[indexPath.row];
    //    cell.backgroundColor = [UIColor cyanColor];
    //
    //    return cell;
    //'UITableView dataSource must return a cell from tableView:cellForRowAtIndexPath:'
    //        if (!_cell) {
    _cell = [[NSBundle mainBundle] loadNibNamed:@"userCell" owner:self options:nil][0];
    
    //        }
    
    //    _cell.lbl.adjustsFontSizeToFitWidth = NO;
    //    [_cell.lbl setTextAlignment:NSTextAlignmentRight];
    
    
    
    return _cell;
}

- (CGFloat)tableView:(PTEHorizontalTableView *)horizontalTableView widthForCellAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}



- (void)horizontalTableView:(PTEHorizontalTableView *)horizontalTableView didSelectIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected row -> %ld",(long)indexPath.row);
    [horizontalTableView.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)btnclosetable:(UIButton *)sender {
    
    _uservcpop.frame = CGRectMake(0, SCREEN.size.height+self.uservcpop.frame.size.height +50 , SCREEN.size.width, self.uservcpop.frame.size.height);
     [_uservcpop removeFromSuperview];
    
    
}
@end
