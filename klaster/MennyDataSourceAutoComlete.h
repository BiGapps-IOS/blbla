//
//  MennyDataSourceAutoComlete.h
//  klaster
//
//  Created by Menny Alterscu on 12/11/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// if YES - suggestions will be picked for display case-sensitive
// if NO - case will be ignored
#define ACOCaseSensitive @"ACOCaseSensitive"

// if "nil" each cell will copy the font of the source UITextField
// if not "nil" given UIFont will be used
#define ACOUseSourceFont @"ACOUseSourceFont"

// if YES substrings in cells will be highlighted with bold as user types in
// *** FOR FUTURE USE ***
#define ACOHighlightSubstrWithBold @"ACOHighlightSubstrWithBold"

// if YES - suggestions view will be on top of the source UITextField
// if NO - it will be on the bottom
// *** FOR FUTURE USE ***
#define ACOShowSuggestionsOnTop @"ACOShowSuggestionsOnTop"

@class MennyDataSourceAutoComlete;

/**
 @protocol Delegate methods for AutocompletionTableView
 */
@protocol MennyDataSourceAutoComlete <NSObject>

@required
/**
 @method Ask delegate for the suggestions for the provided string - maybe need to ask DB, service, etc.
 @param string the "to-search" term
 @return an array of suggestions built dynamically
 */
- (NSArray*) autoCompletion:(MennyDataSourceAutoComlete*) completer suggestionsFor:(NSString*) string;

/**
 @method Invoked when user clicked an auto-complete suggestion UITableViewCell.
 @param index the index that was cicked
 */
- (void) autoCompletion:(MennyDataSourceAutoComlete*) completer didSelectAutoCompleteSuggestionWithIndex:(NSInteger) index;



@end

@interface MennyDataSourceAutoComlete : NSObject

-(MennyDataSourceAutoComlete*)initWithNewWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withOptions:(NSDictionary *)options;
// Dictionary of NSStrings of your auto-completion terms
@property (nonatomic, strong) NSArray *suggestionsDictionary;

// Delegate for AutocompletionTableView
@property (nonatomic, strong) id<MennyDataSourceAutoComlete> MautoCompleteDelegate;
// Dictionary of auto-completion options (check constants above)
@property (nonatomic, strong) NSDictionary *options;


-(NSMutableArray*)initlizeWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withOptions:(NSDictionary *)options;



@property (nonatomic, strong) NSMutableArray* prdections;
@property (nonatomic, strong) NSMutableArray *suggestionOptions; // of selected NSStrings
@property (nonatomic, strong) UITextField *textField; // will set automatically as user enters text
@property (nonatomic) BOOL isMenny;




@end
