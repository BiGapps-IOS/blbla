//
//  MennyDataSourceAutoComlete.m
//  klaster
//
//  Created by Menny Alterscu on 12/11/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import "MennyDataSourceAutoComlete.h"

@implementation MennyDataSourceAutoComlete

static MennyDataSourceAutoComlete* pagesInstance;


#pragma mark - Initialization
-(MennyDataSourceAutoComlete*)initWithNewWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withOptions:(NSDictionary *)options
{
    if (!self)
        self = [[MennyDataSourceAutoComlete alloc]init];

    //self.additives = [NSMutableDictionary dictionary];;
    self.prdections = [[NSMutableArray alloc]init];
    
    self.prdections =[self initlizeWithTextField:textField inViewController:parentViewController withOptions:options];
    
    
    return self;
}


-(NSMutableArray*)initlizeWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withOptions:(NSDictionary *)options
{
    //set the options first
    self.options = options;
    
    NSMutableArray *myPresitction = [[NSMutableArray alloc]init];
    // turn off standard correction
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // [parentViewController.view addSubview:self];
    
    return myPresitction;
}


#pragma mark - Logic staff
- (BOOL) substringIsInDictionary:(NSString *)subString
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSRange range;

    if (_MautoCompleteDelegate && [_MautoCompleteDelegate respondsToSelector:@selector(autoCompletion:suggestionsFor:)]) {
        self.suggestionsDictionary = [_MautoCompleteDelegate autoCompletion:self suggestionsFor:subString];
    }

    for (NSString *tmpString in self.suggestionsDictionary)
    {
        range = ([[self.options valueForKey:ACOCaseSensitive] isEqualToNumber:[NSNumber numberWithInt:1]]) ? [tmpString rangeOfString:subString] : [tmpString rangeOfString:subString options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) [tmpArray addObject:tmpString];
    }
    if ([tmpArray count]>0)
    {
        self.suggestionOptions = tmpArray;
        
        return YES;
    }
    return NO;
}



#pragma mark - UITextField delegate
- (void)textFieldValueChanged:(UITextField *)textField
{
    self.textField = textField;
    NSString *curString = textField.text;
    
    if (![curString length])
    {
       
        return;
    } else if ([self substringIsInDictionary:curString])
    {
        if(_isMenny)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GETPREDICT" object:self.suggestionOptions];

       
    }
}



@end
