//
//  CHPostRequest.h
//  Cheaper
//
//  Created by נמרוד בר on 11/03/14.
//  Copyright (c) 2014 BiGapps. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PostRequestDelegate;


typedef enum {
 
    prLogin,
    prGetCategories,
    prGetbuissness,
    prGetbuissnessEvents,
    prGetProperties,
    prSearchProperties,
    prGetEmail,
    prSendPayment,
    prGetdays,
    prGetTime,
    
    

    prGetSearchez,
    prGetBanner,
    prGetSingleProperty,
    prUPDATENotificationsMappo,
    prGetNotificationsMappo,
    prSaveSearch,
    prDeleteSearch,
    prDeleteProperty,
    prGetFavs,
    prAddToFav,
    prRemoveFromFav,
    prOrderTaxi,
    prGotSMS,
    prCancelTrip,
    prTimeOutTrip,
    prOrderDetails,
    prGetOrderStatus,
    prGetDriverLocation,
    prGetLinx,
    prContents,
    prRatDriver,
    prRegister
    
}dataType;
@interface PostRequest : NSObject
@property (strong, nonatomic) NSString* params;
@property (strong, nonatomic) NSString* urlString;
@property (nonatomic) dataType dataType;
@property (weak, nonatomic) id<PostRequestDelegate> delegate;
-(void) sendHTTPPostWithUrlString:(NSString*)urlString;
@end

@protocol PostRequestDelegate <NSObject>

-(void)postRequest:(PostRequest*)postRequest gotResult:(NSDictionary*)jsonDict forDataType:(dataType)dataType;



@end