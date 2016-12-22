//
//  Macros.h
//  Art Judaica
//
//  Created by BiGapps Interactive on 12/30/14.
//  Copyright (c) 2014 BiGapps2014. All rights reserved.
//

#ifndef Art_Judaica_Macros_h
#define Art_Judaica_Macros_h
#define mainAppColor [UIColor colorWithRed:0.123 green:0.595 blue:1 alpha:1]

#define mainAppColor [UIColor colorWithRed:0.123 green:0.595 blue:1 alpha:1]

#define secondaryAppColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8]

#define mainBlackColor [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]
#define colorGrey [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1.0]

#define Mainorang [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1.0]

#define mainRed [UIColor colorWithRed:0.984 green:0.255 blue:0.306 alpha:1]
#define mainGreen [UIColor colorWithRed:141/255.0 green:190/255.0 blue:81/255.0 alpha:1.0]

#define colorLightGrey [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0]
#define RESPONSE_OK [jsonDict[keyDStatus] integerValue]==1
#define GENERALDATA [AppData sharedInstance].generalInfo
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SMALL_SCREEN ([UIScreen mainScreen].bounds.size.height < 500)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6PLUS (IS_IPHONE && [[UIScreen mainScreen] nativeScale] == 3.0f)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)
#define DEAD_TOKEN  [NSString stringWithFormat:@"0000000000000000000000000000000000000000000000000000000000000000"]

//#define MEDIUM_SCREEN ([UIScreen mainScreen].bounds.size.height < 500)

#define SCREEN [UIScreen mainScreen].bounds
#define APPDATA [AppData sharedInstance]

#define MYDELAYACTION

//double delayInSeconds = 2.0;
//dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//    //code to be executed on the main queue after delay
//    
//});

////WEBVIEW////
//NSString *myHTMLText = [NSString stringWithFormat:@"<html>"
//                        "<head><style type='text/css'>"
//                        ".main_text {"
//                        "   display: block;"
//                        "   font-family:[fontName];"
//                        "   text-decoration:none;"
//                        "   font-size:[fontSize]px;"
//                        "   color:[fontColor];"
//                        "   line-height: [fontSize]px;"
//                        "   font-weight:normal;"
//                        "   text-align:[textAlign];"
//                        "}"
//                        "</style></head>"
//                        "<body> <SPAN class='main_text'>[text]</SPAN></body></html>"];
//UIFont *font = [UIFont fontWithName:@"OpenSansHebrew-Regular" size:14];
//myHTMLText = [myHTMLText stringByReplacingOccurrencesOfString: @"[text]" withString: GENERALDATA.terms];
//myHTMLText = [myHTMLText stringByReplacingOccurrencesOfString: @"[fontName]" withString:@"OpenSansHebrew-Regular"];
//myHTMLText = [myHTMLText stringByReplacingOccurrencesOfString: @"[fontSize]" withString: @"15"];
//myHTMLText = [myHTMLText stringByReplacingOccurrencesOfString: @"[fontColor]" withString: @"#ffffff"];
//myHTMLText = [myHTMLText stringByReplacingOccurrencesOfString: @"[textAlign]" withString: @"right"];
/////////WEBVIEW////////////
//




#define APPDATA [AppData sharedInstance]
#define PLACEHOLDER [UIImage imageNamed:@"plaseholder"]
#define FONT [UIFont fontWithName:@"OpenSansHebrew-Regular" size:16]


//[UIView animateWithDuration:0.4 animations:^{
//    _popupView.alpha = 0.0;
//}completion:^(BOOL finished) {
//
//
//}];

//    ///////
//
//    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0,-SCREEN.size.height/1.5,SCREEN.size.width,SCREEN.size.height/1.5)] ;
//    topview.backgroundColor = [UIColor whiteColor];
//    UILabel* titleV = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
//    titleV.text = @" © BiGapps Interactive. Team Leader: Tim Friedland v1.3.5";
//    titleV.textAlignment = NSTextAlignmentLeft;
//    titleV.font = [UIFont fontWithName:@"OpenSansHebrew-Regular" size:8];
//    titleV.textColor = mainAppColor;
//    titleV.center = CGPointMake(topview.center.x, 142) ;
//    [topview addSubview:titleV];
//
//    [_MainTable addSubview:topview];
//
//    /////


#define BTN_APPROVE DPLocalizedString(@"btn.approve", nil)
#define BTN_CANCEL DPLocalizedString(@"btn.cancel", nil)
#define BTN_SAVE_PIC DPLocalizedString(@"btn.savePic", nil)
#define BTN_ENLARGE DPLocalizedString(@"btn.enlargePic", nil)
#define BTN_ADD_TO_CART DPLocalizedString(@"btn.addToCart", nil)
#define FACTORY [PageFactory sharedInstance]
#define ALERT_ERROR [NSString autolocalizingStringWithLocalizationKey:@"error.fillDetails"]
#define USER_IS_GUEST !APPDATA.loggedIn

#define kOFFSET_FOR_KEYBOARD 80.0


//Block Macros
#define UPDATE_CART( product ) \
{\
JDProduct* prod = [[JDProduct alloc]init];\
prod.productDetails = [NSDictionary dictionaryWithDictionary:product];\
prod.qttyToBuy = amount;\
prod.minOrder = [product[keyDMinOrder] intValue];\
prod.productCode = product[keyDProductCode];\
[APPDATA updateCartWithProduct:prod];\
}

//#define LEFT_MENU [FACTORY getLeftMenuVC]
//#define RIGHT_MENU [FACTORY getRightMenuVC]
//
////#define PURCHES_VC [FACTORY getPutcheseVC]
////
////#define TERMS_VC [FACTORY getTermsInfoVC]
////
////#define SPLSH_VC [FACTORY getsplashVC]
//
//
//
//
//#define  MOVE_MENU [[NSNotificationCenter defaultCenter]postNotificationName:@"MOVE_MAIN" object:nil]
//
//#define  MOVE_BACK [[NSNotificationCenter defaultCenter]postNotificationName:@"MOVE_BACK" object:nil]
//
//#define  MOVE_DOWN [[NSNotificationCenter defaultCenter]postNotificationName:@"MOVE_DOWN" object:nil]
//
//#define  MOVE_UP [[NSNotificationCenter defaultCenter]postNotificationName:@"MOVE_UP" object:nil]
//
//
//#define  PUSH_PURCHES [[NSNotificationCenter defaultCenter]postNotificationName:@"PUSH_PURCHES" object:nil]





//#define NIMOLOG( string , myObject ) \
//{\
//[AppUtil starsLogWithText:string andObject:myObject];\
//}

#define NIMOLOG( string ) \
{\
    NSLog(@"\n********⛔************\n%@\n***********⛔*********\n",string);\
}

#define NIMOLOGVALUE( string , object ) \
{\
NSLog(@"\n********************\n%@ : %@\n********************\n",string, object);\
}

#define ADD_LOAD_MORE_BUTTON \
{\
UIView* loadMoreView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 45)];\
UIButton* loadButton = [[UIButton alloc]initWithFrame:loadMoreView.frame];\
[loadButton addTarget:self action:@selector(loadMoreProducts) forControlEvents:UIControlEventTouchUpInside];\
[loadButton setTitle:DPLocalizedString(@"btn.continue", nil) forState:UIControlStateNormal];\
loadButton.titleLabel.font = [AppUtil getFontWithSize:20];\
[loadButton setBackgroundColor:orangeAppColor];\
[loadMoreView addSubview:loadButton];\
[self.tableView setTableFooterView:loadMoreView];\
}


#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication]statusBarFrame].size.height
#endif
