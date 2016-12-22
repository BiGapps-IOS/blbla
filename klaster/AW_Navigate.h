//
//  AW_Navigate.h
//  Art Judaica
//
//  Created by BiGapps Interactive on 1/5/15.
//  Copyright (c) 2015 BiGapps2014. All rights reserved.
//
//
//  AW_Navigate.h
//  Art Judaica
//
//  Created by BiGapps Interactive on 1/5/15.
//  Copyright (c) 2015 BiGapps2014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol AW_NavigateDelegate;

@interface AW_Navigate : NSObject <CLLocationManagerDelegate>

#pragma mark - Properties
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong , nonatomic) CLLocation* currentLocation;

@property (weak, nonatomic) id<AW_NavigateDelegate> delegate;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) CLAuthorizationStatus authorizationStatus;

#pragma markj - Methods
-(instancetype)initWithDestinationLatitude:(double)latitude longitude:(double)longitude andUseAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus;
-(instancetype)initWithUseAuthorizationStatus:(CLAuthorizationStatus)authorizationStatus;
-(void)navigateWithLatitude:(double)lat andLongitude:(double)lon inAddress:(NSString*)address;
-(void)navigate;
-(void)startLocationServices;

-(void)stopUpdatingLocations;
@end


@protocol AW_NavigateDelegate <NSObject>

-(void)AW_Navigate:(AW_Navigate*)awNav didGetCurrentLocation:(CLLocation*)location;

@end