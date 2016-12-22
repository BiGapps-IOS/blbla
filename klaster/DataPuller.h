//
//  CHDataPuller.h
//  Cheaper
//
//  Created by נמרוד בר on 11/03/14.
//  Copyright (c) 2014 BiGapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DataPullerDelegate;

typedef enum{
    predictions,
    location,
    final,
    geoCode,
    checkValid,
    finalAndPopView,
    finalWasChecked,
    findMe
}PullMode;
@protocol DataPullerDelegate;


@interface DataPuller : NSObject
-(void)sendHttpReqWithUrlString:(NSString*)urlString;
@property (strong, nonatomic) NSTimer* reconnectionTimer;
@property (nonatomic) PullMode pullMode;
@property (nonatomic, weak) id<DataPullerDelegate> delegate;
@end


@protocol DataPullerDelegate <NSObject>

- (void)DataPuller:(DataPuller*)dataPuller hasRerievedDataForType:(PullMode)pullType WithJson:(NSDictionary*)jsonDic fromString:(NSString*)jsonString;



@end
