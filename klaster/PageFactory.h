//
//  PageFactory.h
//  BigLike
//
//  Created by BiGapps Interactive on 2/18/15.
//  Copyright (c) 2015 BiGapps2014. All rights reserved.
//

#import <Foundation/Foundation.h>



//#import "TermsVC.h"
//#import "Splash.h"




@interface PageFactory : NSObject

#pragma mark - Class Methods
+(PageFactory*)sharedInstance;


@property (strong, nonatomic)NSMutableArray* ArrayOfallViewAlive;
@end
