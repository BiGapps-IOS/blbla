//
//  CHDataPuller.m
//  Cheaper
//
//  Created by נמרוד בר on 11/03/14.
//  Copyright (c) 2014 BiGapps. All rights reserved.
//

#import "DataPuller.h"
@interface DataPuller () <NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong , nonatomic) NSString* urlString;
@property (strong, nonatomic) NSString* jsonString;

@property ( nonatomic) NSInteger resendHTTPcounter;

@end

@implementation DataPuller

int errorCounter = 0;

-(void)sendHttpReqWithUrlString:(NSString*)urlString
{
    if (_resendHTTPcounter == 19)
    {
        errorCounter = 0;
    }
    
    self.reconnectionTimer = nil;
    self.urlString = urlString;
    // Create a NSURL with the URL string
    NSString* webStringURL = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:webStringURL];
    
    // Create a request with the url
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
    
    // Send off a async request for the data
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:req
                                                           delegate:self];
    // If connection was opened ok
    if (con)
    {
        self.receivedData = [[NSMutableData alloc] init];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"Error connecting to remote server"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
}

#pragma mark - NSURLConnectionDataDelegate

// Can be called mutiple times during a single request
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the received data to the mutable data property
    [self.receivedData appendData:data];
}

// Occurs when an error was raised
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Reset the data received
    if (self.receivedData != nil)
    {
                self.receivedData = nil;
    }

    
    // Inform the user of the error
    NSLog(@"Error !!! Connection Failed! Error: %@", error.description);
    
//    [AppUtil removeActivityIndicatorFromView];
    
    
    if(errorCounter == 0)
    {
        [[[UIAlertView alloc]initWithTitle:@"קיימת בעית חיבור" message:nil delegate:nil cancelButtonTitle:@"אישור" otherButtonTitles:nil] show];

        errorCounter++;
    }
    
    

    
    if (self.reconnectionTimer == nil)
    {
        self.reconnectionTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(resendRequest) userInfo:nil repeats:YES];
        [self.reconnectionTimer fire];
    }
    
   // [AppData sharedInstance].internetConnectionActive = NO;
}
-(void)resendRequest
{
    //shnapa
    
    if (_resendHTTPcounter < 20)
    {
        NSLog(@"RESEND");
        [self sendHttpReqWithUrlString:self.urlString];
        
        _resendHTTPcounter++;
    }
    

  

}
// Will be called when a request has completed
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   // [AppData sharedInstance].internetConnectionActive = YES;
    
    
    [self.reconnectionTimer invalidate];
    
    
   _resendHTTPcounter = 0;

    // Get the string out of the data received
    NSString *finalResponseString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    self.jsonString = [NSString stringWithString:finalResponseString];
    
    //LOG
  //  NSLog(@"FINAL RESPONSE STRING:\n%@", finalResponseString);
    
    NSError *error;
    
    NSData* jsonData = [finalResponseString dataUsingEncoding:NSUTF8StringEncoding ];
    NSDictionary* jsonDict;
    if (jsonData != nil)
    {
        jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    }
    
    // Make sure the parsing was ok
    if (jsonDict)
    {
        [self sendToDelegate:jsonDict];
    }
    
    if (self.reconnectionTimer != nil)
    {
        [self.reconnectionTimer invalidate];
        self.reconnectionTimer = nil;
      //  [AppData sharedInstance].internetConnectionActive = NO;
    }
    self.receivedData = nil;
}
-(void)sendToDelegate:(NSDictionary*)jsonDict
{
    id<DataPullerDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(DataPuller:hasRerievedDataForType:WithJson:fromString:)])
    {
        [strongDelegate DataPuller:self hasRerievedDataForType:self.pullMode WithJson:jsonDict fromString:self.jsonString];
    }
}

@end
