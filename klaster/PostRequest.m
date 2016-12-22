//
//  CHPostRequest.m
//  Cheaper
//
//  Created by נמרוד בר on 11/03/14.
//  Copyright (c) 2014 BiGapps. All rights reserved.
//

#import "PostRequest.h"
@interface PostRequest () <NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData* receivedData;
@property (strong, nonatomic) NSDictionary* contactTypes;
@property (strong, nonatomic) NSMutableDictionary* organizeContacts;
@property (nonatomic) NSInteger requestNumber;
@end

@implementation PostRequest
@synthesize dataType;
-(id)init
{
    self = [super init];
    
    self.requestNumber = 0;
    return self;
}


-(void) sendHTTPPostWithUrlString:(NSString*)urlString
{
//    NSLog(@"\nLOG: Sent Request for %@",[self convertToString:self.dataType]);

    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[_params dataUsingEncoding:NSUTF8StringEncoding]];
    // Convert your data and set your request's HTTPBody property
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    if (conn) {
        self.receivedData = [[NSMutableData alloc]init];
    }
    
    self.urlString = urlString;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    self.receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // Get the string out of the data received
    NSString *tempResponseString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];

//    NSLog(@"\nLOG: Got Data for %@",[self convertToString:self.dataType]);
    NSError *error;
    NSString* finalResponseString = tempResponseString;
    
    NSData* jsonData = [finalResponseString dataUsingEncoding:NSUTF8StringEncoding ];
    NSDictionary* jsonDict;
    
    if (jsonData != nil)
    {
        jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
    }
    
    if ([jsonDict objectForKey:@"line"])
    {
       // [[[UIAlertView alloc]initWithTitle:jsonDict[@"name"] message:[NSString stringWithFormat:@"%@",jsonDict] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
        
        //PHP Warning
        NSLog(@"%@",jsonDict);
    }


           
    id<PostRequestDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(postRequest:gotResult:forDataType:)])
    {
        [strongDelegate postRequest:self gotResult:jsonDict forDataType:self.dataType];
    }

      self.receivedData = nil;
    
}



#pragma mark - error

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
    }
    else
    {
//        NIMOLOGVALUE(@"Error %@",[error userInfo]);
        self.requestNumber++;
        [[NSNotificationCenter defaultCenter]postNotificationName: @"nitif_internet_error" object:nil];
//        NIMOLOG(@"RESENT REQUEST");
        
//        if (self.requestNumber > 4)
//        {
//            if(dataType==prLogin|| dataType == prGetCategories ||dataType == prContents)
//            {
//                [[[UIAlertView alloc]initWithTitle:@"התחברות לשרת נכשלה, אנא בדוק את חיבורך לרשת האינטרנט" message:nil delegate:[FACTORY getsplashVC] cancelButtonTitle:@"נסה שנית" otherButtonTitles:@"OK", nil] show];
//                
//                
//            }
//            else{
//                [[[UIAlertView alloc]initWithTitle:@"משיכת נתונים נכשלה, אנא בדוק את חיבורך לרשת האינטרנט" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                
//            }
//            
//            
//            [AppUtil removeActivityIndicatorFromView];
//        }
//        
         [self sendHTTPPostWithUrlString:self.urlString];

        
    }
    
    
}


@end
