//
//  AW_Navigate.m
//  Art Judaica
//
//  Created by BiGapps Interactive on 1/5/15.
//  Copyright (c) 2015 BiGapps2014. All rights reserved.
//

#import "AW_Navigate.h"
BOOL inGpsMode = NO;
@implementation AW_Navigate

//IOS8
-(void)locationManager:(CLLocationManager*)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
    [self sendToDelegate];
}

-(void)sendToDelegate
{
    id<AW_NavigateDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(AW_Navigate:didGetCurrentLocation:)])
    {
        [strongDelegate AW_Navigate:self didGetCurrentLocation:self.currentLocation];
    }
}

-(void)stopLocationUpdates
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        
        
//        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")){
//            
//            [self.locationManager setAllowsBackgroundLocationUpdates:YES];
            
//        }
//        
//    } else if (status == kCLAuthorizationStatusAuthorized) {
//        // iOS 7 will redundantly call this line.
//        [self.locationManager startUpdatingLocation];
//    } else if (status > kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusDenied)
//    {
//        
  }
}


-(instancetype)initWithUseAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus
{
    self = [super init];
    if (self)
    {
        self.authorizationStatus = authorizationStatus;
    }
    
    return self;
}


-(instancetype)initWithDestinationLatitude:(double)latitude longitude:(double)longitude andUseAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus
{
    self = [super init];
    if (self)
    {
        self.latitude = latitude;
        self.longitude = longitude;
        self.authorizationStatus = authorizationStatus;
        
    }
    
    return self;
}
-(void)startLocationServices
{

    
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
    {
        // show the map
        // Custom initialization
        inGpsMode = YES;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        
      //  [AppUtil createActivityIndicatorInView];

        
//        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
//        {
            [self.locationManager requestAlwaysAuthorization];
            
        }
        [self.locationManager startUpdatingLocation];
//    } else
//    {
//        inGpsMode = NO;
//        self.currentLocation = nil;
//        
//        NSLog(@"DENIED");
//        
//        [AppUtil removeActivityIndicatorFromView];
//        
//       // [AppUtil makeGeneralToastWithText:@"לשימוש באפציה זו יש לאשר את שירותי המיקום -- בהגדרות המכשיר"];
//        
//        
//     //   [[[UIAlertView alloc]initWithTitle:@"לשימוש באפליקציה זו יש לאשר את שירותי המיקום - בהגדרות המכשיר" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//
//        [self.locationManager stopUpdatingLocation];
//
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"NO_LOCATION" object:nil];
//}
    
    if (!inGpsMode)
    {
       // UIAlertView *locationAlert = [[UIAlertView alloc]initWithTitle:@"Location Services Unavailable!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       // [locationAlert show];
        [self.locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NO_LOCATION" object:nil];

    }
    
}
-(void)stopUpdatingLocations
{
    [self.locationManager stopUpdatingLocation];
}
-(void)navigateUsingMapkitWithLatitude:(double)lat andLong:(double)lon
{
    NSURL *appUrl;
    CLLocation* dest = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
    
    //Is Google Maps App Installed ?
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        
        // Use Google Maps App to get Directions
        appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f&saddr=%f,%f", dest.coordinate.latitude, dest.coordinate.longitude, _currentLocation.coordinate.latitude,_currentLocation.coordinate.longitude]];
    }
    
    // Google Maps not Installed
    else {
        
        // Use Apple Maps App to get Directions
        appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=%f,%f",
                                       dest.coordinate.latitude, dest.coordinate.longitude,
                                       _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude]];
    }
    
    [[UIApplication sharedApplication] openURL:appUrl];
    
}
-(void)navigate
{
    [self navigateWithLatitude:self.latitude andLongitude:self.longitude inAddress:nil];
}

-(void)navigateWithLatitude:(double)lat andLongitude:(double)lon inAddress:(NSString*)address
{
    double latitude = lat;
    double longitude = lon;
    if (latitude && longitude)
    {
        if ([[UIApplication sharedApplication]
             canOpenURL:[NSURL URLWithString:@"waze://"]])
        {
            
            // Waze is installed. Launch Waze and start navigation
            NSString *urlStr =
            [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes",
             latitude, longitude];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            
        }
        else
        {
            
            [self navigateUsingMapkitWithLatitude:latitude andLong:longitude];
            
        }
        
    }
    else if (address)
    {
        if ([[UIApplication sharedApplication]
             canOpenURL:[NSURL URLWithString:@"waze://"]])
        {
            
            // Waze is installed. Launch Waze and start navigation
            NSString *urlStr =
            [NSString stringWithFormat:@"waze://?q=%@",
             address];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            
        }
        else
        {
            
            // Waze is not installed. Launch AppStore to install Waze app
            [[UIApplication sharedApplication] openURL:[NSURL
                                                        URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
        }
    }
    
}

@end
