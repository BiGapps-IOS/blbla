#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GMSMarker.h>

@protocol GClusterItem <NSObject>

@property (nonatomic, assign, readonly) CLLocationCoordinate2D position;

//PO TIM HOSIF MARKER ///


@property (nonatomic, strong) GMSMarker *marker;


@end
