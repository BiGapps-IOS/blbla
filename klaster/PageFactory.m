//
//  PageFactory.m
//  BigLike
//
//  Created by BiGapps Interactive on 2/18/15.
//  Copyright (c) 2015 BiGapps2014. All rights reserved.
//

#import "PageFactory.h"
static PageFactory* pagesInstance;
@implementation PageFactory

+(PageFactory*)sharedInstance
{
    if (pagesInstance==nil)
    {
        pagesInstance=[PageFactory new];
        if(!pagesInstance.ArrayOfallViewAlive)
        {
            
        pagesInstance.ArrayOfallViewAlive = [[NSMutableArray alloc]init];
        
        }
    }
    return pagesInstance;
}




@end
