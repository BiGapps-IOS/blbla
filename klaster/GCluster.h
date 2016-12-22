#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GMSMarker.h>

@protocol GCluster <NSObject>

@property(nonatomic, assign, readonly) CLLocationCoordinate2D position;

@property(nonatomic, strong, readonly) NSSet *items;


@property(nonatomic, strong) NSMutableArray *markers;


@property(nonatomic, strong) GMSMarker *marker;

@end
