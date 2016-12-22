#import <CoreText/CoreText.h>
#import "GDefaultClusterRenderer.h"
#import "GQuadItem.h"
#import "GCluster.h"
#import "Macros.h"
@implementation GDefaultClusterRenderer {
    GMSMapView *_map;
    NSMutableArray *_markerCache;
}

int counter = 0;

- (id)initWithMapView:(GMSMapView*)googleMap {
    if (self = [super init]) {
        _map = googleMap;
        _markerCache = [[NSMutableArray alloc] init];
        
        _markersDictT = [[NSMutableDictionary alloc]init];
        
        counter = 0;
    }
    return self;
}

- (void)clustersChanged:(NSSet*)clusters {
    for (GMSMarker *marker in _markerCache) {
        marker.map = nil;
    }
    
    [_markerCache removeAllObjects];
    
    for (id <GCluster> cluster in clusters) {
        GMSMarker *marker;
        marker = [[GMSMarker alloc] init];
        [_markerCache addObject:marker];
        
        //        NSUInteger count = cluster.items.count;
        //        if (count > 1) {
        //            marker.icon = [self generateClusterIconWithCount:count andType:blue];
        //
        //
        //
        //
        //        }
        //        else {
        //            marker.icon = cluster.marker.icon;
        //
        //           // marker.userData = cluster.marker.userData;
        //
        //        }
        //
        
        
        //           marker.userData = cluster.items;
        
        NSMutableArray* markersInCluster = [NSMutableArray array];
        
        NSSet* groups = cluster.items;
        for(GQuadItem* item in groups)
        {
            GMSMarker* marker = item.marker;
            
            if([markersInCluster indexOfObject:item.marker] == NSNotFound) {
                // your object is not in here
                
                
                
                
                [markersInCluster addObject:marker];
            }
            
        }
        
        marker.userData = markersInCluster;
        
        
        
        
        NSUInteger count = cluster.items.count;
        
        
        if (count > 1 ) {
            
            counter += count;
            
           // marker.icon = [self generateClusterIconWithCount:count andType:2];
            
            int User = 0;
            int Rooms = 0;
            BOOL ISme = NO;
            
            for (int y = 0; y < markersInCluster.count; y++)
            {
                
                
                 NSString *tester  = ((GMSMarker*)[markersInCluster objectAtIndex:y]).title;
                
//                NSString *tester = tempA;

                if([tester isEqualToString:@"ROOM"])
                {
                    
                    Rooms++;
                }
                else
                {
                    
                    User++;
                }
                
                if([tester isEqualToString:@"MENNY"])
                {
                    ISme =YES;
                    
                }
                
                
            }
            
            if(Rooms == 0 && User > 0)
            {
                marker.icon = [self generateClusterIconWithCount:count andType:0];
                
                
            }
            else  if(Rooms > 0 && User == 0)
            {
                marker.icon = [self generateClusterIconWithCount:count andType:1];
                
                
            }
            else if(Rooms > 0 && User > 0)
            {
                marker.icon = [self generateClusterIconWithCount:count andType:6];
                
                
            }
            
            if(ISme)
            {
                marker.icon = [self generateClusterIconWithCount:0 andType:8];
            }
            
            
            
            
        }
        else {
            
            counter ++;
            
            NSString* tempA = ((GMSMarker*)[markersInCluster objectAtIndex:0]).title;
            
            
            if([tempA isEqualToString:@"ROOM"])
            {
                marker.icon = [self generateClusterIconWithCount:0 andType:5];
                
            }
            else
            {
                marker.icon = [self generateClusterIconWithCount:0 andType:4];
                
            }
            if([tempA isEqualToString:@"MENNY"])
            {
                marker.icon = [self generateClusterIconWithCount:0 andType:8];
                
            }
            
            
        }
        
        //        else {
        //
        //
        //            UIImage *toBeIcon = [UIImage imageNamed:@"pin_empty_green"];
        //
        //            toBeIcon = [self imageWithImage:toBeIcon scaledToSize:CGSizeMake(SCREEN.size.width/20, SCREEN.size.width/15)];
        //
        //            marker.icon = toBeIcon;
        //
        //        }
        
        marker.position = cluster.position;
        
        
        marker.map = _map;
        marker.title = [NSString stringWithFormat:@"%f, %f",cluster.position.latitude,cluster.position.longitude];
        // NSLog(@"%f, %f, %d",cluster.position.latitude,cluster.position.longitude,count);
        
    }
}


//NSString* tKey = [NSString stringWithFormat:@"%f%f",marker.position.latitude, marker.position.longitude];
//
////marker.appearAnimation = kGMSMarkerAnimationPop;
//
//if(![_markersDictT objectForKey:tKey])
//{

- (UIImage*) generateClusterIconWithCount:(NSUInteger)count andType:(int)TYPE {

    int diameter = 40;
    float inset = 2;
    //    int textHeight = 13;
    //    float textSize = 20.0f;
    //
    //    if (count>100) {
    //         diameter = 60;
    //        textHeight = 22;
    //        textSize = 22.0f;
    //
    //    }
    //    if (count<10) {
    //        diameter = 30;
    //        textHeight = 10;
    //        textSize = 16.0f;
    //
    //    }
    //
    //
    //
    //    CGRect rect = CGRectMake(0, 0, diameter, diameter);
    //    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    UIColor *color = [UIColor colorWithRed:212/255.0 green:83/255.0 blue:78/255.0 alpha:.9];
    //    // set stroking color and draw circle
    //    [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setStroke];
    //    [color setFill];
    //
    //    CGContextSetLineWidth(ctx, inset);
    //
    //    // make circle rect 5 px from border
    //    CGRect circleRect = CGRectMake(0, 0, diameter, diameter);
    //    circleRect = CGRectInset(circleRect, inset, inset);
    //
    //    // draw circle
    //    CGContextFillEllipseInRect(ctx, circleRect);
    //    CGContextStrokeEllipseInRect(ctx, circleRect);
    //
    //    CGContextSetShadow (ctx, CGSizeMake(0.0f, 2.0f), 1);
    //    CTFontRef myFont = CTFontCreateWithName( (CFStringRef)@"Helvetica", textSize, NULL);
    //
    //
    //    NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
    //            (__bridge id)myFont, (id)kCTFontAttributeName,
    //                    [UIColor whiteColor], (id)kCTForegroundColorAttributeName, nil ];
    //
    //    // create a naked string
    //    NSString *string = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)count];
    //
    //
    //    NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:string
    //                                                                       attributes:attributesDict];
    //
    //
    //
    //
    //    // flip the coordinate system
    //    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    //    CGContextTranslateCTM(ctx, 0, diameter);
    //    CGContextScaleCTM(ctx, 1.0, -1.0);
    //
    //    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(stringToDraw));
    //    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
    //                                                                        frameSetter, /* Framesetter */
    //                                                                        CFRangeMake(0, stringToDraw.length), /* String range (entire string) */
    //                                                                        NULL, /* Frame attributes */
    //                                                                        CGSizeMake(diameter, diameter), /* Constraints (CGFLOAT_MAX indicates unconstrained) */
    //                                                                        NULL /* Gives the range of string that fits into the constraints, doesn't matter in your situation */
    //                                                                        );
    //    CFRelease(frameSetter);
    //
    //    //Get the position on the y axis
    //    float midHeight = diameter;
    //    midHeight -= suggestedSize.height;
    //
    //    float midWidth = diameter / 2;
    //    midWidth -= suggestedSize.width / 2;
    //
    //    CTLineRef line = CTLineCreateWithAttributedString(
    //            (__bridge CFAttributedStringRef)stringToDraw);
    //    CGContextSetTextPosition(ctx, midWidth, textHeight);
    //    CTLineDraw(line, ctx);
    //
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    return image;


    UIImage* toBeIconW;
    switch (TYPE) {
        case 0:
            toBeIconW = [UIImage imageNamed:@"insta_pin_greenW"];
            break;

        case 1:
            toBeIconW = [UIImage imageNamed:@"insta_pin_blueW"];
            break;

                   
        case 4:
            toBeIconW = [UIImage imageNamed:@"insta_pin_green"];
            break;
        case 5:
            toBeIconW = [UIImage imageNamed:@"insta_pin_blue"];
            break;
            
        case 6:
            toBeIconW = [UIImage imageNamed:@"insta_pin_GB"];
            break;
            
        case 8:
            toBeIconW = [UIImage imageNamed:@"searchuserover"];
            break;


        default:
            break;
    }



    toBeIconW = [self imageWithImage:toBeIconW scaledToSize:CGSizeMake(SCREEN.size.width/7.0, SCREEN.size.width/5.2)];




    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,90,90)];
    UIImageView *pinImageView = [[UIImageView alloc] initWithImage:toBeIconW];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30,8,90,90)];


    label.textColor =[UIColor blackColor];
    label.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)count];


    if(label.text.length < 2)
    {
        label.text = [NSString stringWithFormat:@" %@",label.text];

    }

    //  label.text
    //label.font = ...;


    UIFont* fontTitle = [UIFont fontWithName:@"OpenSansHebrew-Bold" size:18];

    label.font = fontTitle;

    [label sizeToFit];

    [view addSubview:pinImageView];

    if(count > 0)
    {
        [view addSubview:label];

    }
    //i.e. customize view to get what you need


    UIImage *markerIcon = [self imageFromView:view];



    return markerIcon;
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
