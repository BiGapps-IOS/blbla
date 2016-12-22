//
//  dfdfdf.h
//  klaster
//
//  Created by Menny Alterscu on 12/6/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dfdfdf : NSObject
//
//- (void)clustersChanged:(NSSet*)clusters {
//    for (GMSMarker *marker in _markerCache) {
//        marker.map = nil;
//    }
//    
//    [_markerCache removeAllObjects];
//    
//    for (id <GCluster> cluster in clusters) {
//        GMSMarker *marker;
//        marker = [[GMSMarker alloc] init];
//        [_markerCache addObject:marker];
//        
//        NSMutableArray* markersInCluster = [NSMutableArray array];
//        
//        NSSet* groups = cluster.items;
//        for(GQuadItem* item in groups)
//        {
//            GMSMarker* marker = item.marker;
//            
//            if([markersInCluster indexOfObject:item.marker] == NSNotFound) {
//                // your object is not in here
//                
//                [markersInCluster addObject:marker];
//            }
//            
//        }
//        
//        
//        marker.userData = markersInCluster;
//        
//        NSUInteger count = cluster.items.count;
//        
//        if (count > 1 ) {
//            
//            counter += count;
//            
//            marker.icon = [self generateClusterIconWithCount:count andType:2];
//            
//            int User = 0;
//            int Rooms = 0;
//            
//            for (int y = 0; y < markersInCluster.count; y++)
//            {
//                
//                
//                NSDictionary* tempA = ((GMSMarker*)[markersInCluster objectAtIndex:y]).userData;
//                
//                NSString *tester = [tempA objectForKey:@"Type"];
//                
//                
//                
//                if([tester isEqualToString:@"room"])
//                {
//                    
//                    Rooms++;
//                }
//                else
//                {
//                    
//                    User++;
//                }
//                
//                
//                
//            }
//            
//            if(Rooms == 0 && User > 0)
//            {
//                marker.icon = [self generateClusterIconWithCount:count andType:0];
//                
//                
//            }
//            else  if(Rooms > 0 && User == 0)
//            {
//                marker.icon = [self generateClusterIconWithCount:count andType:1];
//                
//                
//            }
//            else if(Rooms > 0 && User > 0)
//            {
//                marker.icon = [self generateClusterIconWithCount:count andType:1];
//                
//                
//            }
//            
//            
//        }
//        else {
//            
//            counter ++;
//            
//            
//            marker.icon = [self generateClusterIconWithCount:0 andType:2];
//            
//            
//        }
//        
//        //        else {
//        //
//        //
//        //            UIImage *toBeIcon = [UIImage imageNamed:@"pin_empty_green"];
//        //
//        //            toBeIcon = [self imageWithImage:toBeIcon scaledToSize:CGSizeMake(SCREEN.size.width/20, SCREEN.size.width/15)];
//        //
//        //            marker.icon = toBeIcon;
//        //
//        //        }
//        
//        marker.position = cluster.position;
//        
//        
//        marker.map = _map;
//        marker.title = [NSString stringWithFormat:@"%f, %f",cluster.position.latitude,cluster.position.longitude];
//        // NSLog(@"%f, %f, %d",cluster.position.latitude,cluster.position.longitude,count);
//        
//    }
//    
//
//    
//    
//}
//
//-(void)setLabel
//{
//    _lbl = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [_map addSubview:_lbl ];
//}
//
//
//// CREAT THE BIG CLUSTER IMAGE!//////
//- (UIImage*) generateClusterIconWithCount:(NSUInteger)count andType:(int)TYPE {
//    
//    int diameter = 40;
//    float inset = 2;
//    //    int textHeight = 13;
//    //    float textSize = 20.0f;
//    //
//    //    if (count>100) {
//    //         diameter = 60;
//    //        textHeight = 22;
//    //        textSize = 22.0f;
//    //
//    //    }
//    //    if (count<10) {
//    //        diameter = 30;
//    //        textHeight = 10;
//    //        textSize = 16.0f;
//    //
//    //    }
//    //
//    //
//    //
//    //    CGRect rect = CGRectMake(0, 0, diameter, diameter);
//    //    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    //
//    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    //    UIColor *color = [UIColor colorWithRed:212/255.0 green:83/255.0 blue:78/255.0 alpha:.9];
//    //    // set stroking color and draw circle
//    //    [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setStroke];
//    //    [color setFill];
//    //
//    //    CGContextSetLineWidth(ctx, inset);
//    //
//    //    // make circle rect 5 px from border
//    //    CGRect circleRect = CGRectMake(0, 0, diameter, diameter);
//    //    circleRect = CGRectInset(circleRect, inset, inset);
//    //
//    //    // draw circle
//    //    CGContextFillEllipseInRect(ctx, circleRect);
//    //    CGContextStrokeEllipseInRect(ctx, circleRect);
//    //
//    //    CGContextSetShadow (ctx, CGSizeMake(0.0f, 2.0f), 1);
//    //    CTFontRef myFont = CTFontCreateWithName( (CFStringRef)@"Helvetica", textSize, NULL);
//    //
//    //
//    //    NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
//    //            (__bridge id)myFont, (id)kCTFontAttributeName,
//    //                    [UIColor whiteColor], (id)kCTForegroundColorAttributeName, nil ];
//    //
//    //    // create a naked string
//    //    NSString *string = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)count];
//    //
//    //
//    //    NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:string
//    //                                                                       attributes:attributesDict];
//    //
//    //
//    //
//    //
//    //    // flip the coordinate system
//    //    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
//    //    CGContextTranslateCTM(ctx, 0, diameter);
//    //    CGContextScaleCTM(ctx, 1.0, -1.0);
//    //
//    //    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(stringToDraw));
//    //    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
//    //                                                                        frameSetter, /* Framesetter */
//    //                                                                        CFRangeMake(0, stringToDraw.length), /* String range (entire string) */
//    //                                                                        NULL, /* Frame attributes */
//    //                                                                        CGSizeMake(diameter, diameter), /* Constraints (CGFLOAT_MAX indicates unconstrained) */
//    //                                                                        NULL /* Gives the range of string that fits into the constraints, doesn't matter in your situation */
//    //                                                                        );
//    //    CFRelease(frameSetter);
//    //
//    //    //Get the position on the y axis
//    //    float midHeight = diameter;
//    //    midHeight -= suggestedSize.height;
//    //
//    //    float midWidth = diameter / 2;
//    //    midWidth -= suggestedSize.width / 2;
//    //
//    //    CTLineRef line = CTLineCreateWithAttributedString(
//    //            (__bridge CFAttributedStringRef)stringToDraw);
//    //    CGContextSetTextPosition(ctx, midWidth, textHeight);
//    //    CTLineDraw(line, ctx);
//    //
//    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    //    UIGraphicsEndImageContext();
//    //
//    //    return image;
//    
//    
//    UIImage* toBeIconW;
//    switch (TYPE) {
//        case 0:
//            toBeIconW = [UIImage imageNamed:@"insta_pin_blue"];
//            break;
//            
//        case 1:
//            toBeIconW = [UIImage imageNamed:@"greenpin"];
//            break;
//            
//        case 2 :[UIImage imageNamed:@"inbox_face"];break;
//            
//            
//        default:
//            break;
//    }
//    
//    
//    
//    toBeIconW = [self imageWithImage:toBeIconW scaledToSize:CGSizeMake(SCREEN.size.width/7.0, SCREEN.size.width/5.2)];
//    
//    
//    
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,90,90)];
//    UIImageView *pinImageView = [[UIImageView alloc] initWithImage:toBeIconW];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30,8,90,90)];
//    
//    
//    label.textColor =[UIColor blackColor];
//    label.text = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)count];
//    
//    
//    if(label.text.length < 2)
//    {
//        label.text = [NSString stringWithFormat:@" %@",label.text];
//        
//    }
//    
//    //  label.text
//    //label.font = ...;
//    
//    
//    UIFont* fontTitle = [UIFont fontWithName:@"OpenSansHebrew-Bold" size:18];
//    
//    label.font = fontTitle;
//    
//    [label sizeToFit];
//    
//    [view addSubview:pinImageView];
//    
//    if(count > 0)
//    {
//        [view addSubview:label];
//        
//    }
//    //i.e. customize view to get what you need
//    
//    
//    UIImage *markerIcon = [self imageFromView:view];
//    
//    
//    
//    return markerIcon;
//}
//
//- (UIImage *)imageFromView:(UIView *) view
//{
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
//    } else {
//        UIGraphicsBeginImageContext(view.frame.size);
//    }
//    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    // Pass 1.0 to force exact pixel size.
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}
@end
