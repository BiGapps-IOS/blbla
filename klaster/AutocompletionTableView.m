//
//  AutocompletionTableView.m
//
//  Created by Gushin Arseniy on 11.03.12.
//  Copyright (c) 2012 Arseniy Gushin. All rights reserved.
//

#import "AutocompletionTableView.h"
#import "TableViewCell.h"

@interface AutocompletionTableView () 
@property (nonatomic, strong) NSArray *suggestionOptions; // of selected NSStrings 
@property (nonatomic, strong) UITextField *textField; // will set automatically as user enters text
@property (nonatomic, strong) UIFont *cellLabelFont; // will copy style from assigned textfield
@property(nonatomic ,strong) TableViewCell *cell;
@end

@implementation AutocompletionTableView

@synthesize suggestionsDictionary = _suggestionsDictionary;
@synthesize suggestionOptions = _suggestionOptions;
@synthesize textField = _textField;
@synthesize cellLabelFont = _cellLabelFont;
@synthesize options = _options;

#pragma mark - Initialization
- (UITableView *)initWithTextField:(UITextField *)textField inViewController:(UIViewController *) parentViewController withOptions:(NSDictionary *)options
{
    //set the options first
    self.options = options;
    
    // frame must align to the textfield 
//    CGRect frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y+textField.frame.size.height, textField.frame.size.width, 120);
    
    // save the font info to reuse in cells
    self.cellLabelFont = textField.font;
    
    
//    self = [super initWithFrame:CGRectMake(0,0,textField.frame.size.width,textField.frame.size.height)
//             style:UITableViewStylePlain];
    self = [super init];
    
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor clearColor];
    // turn off standard correction
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // to get rid of "extra empty cell" on the bottom
    // when there's only one cell in the table
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textField.frame.size.width, 1)]; 
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
    self.hidden = YES;  
    [parentViewController.view addSubview:self];

    return self;
}

#pragma mark - Logic staff
- (BOOL) substringIsInDictionary:(NSString *)subString
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSRange range;
    
    if (_autoCompleteDelegate && [_autoCompleteDelegate respondsToSelector:@selector(autoCompletion:suggestionsFor:)]) {
        self.suggestionsDictionary = [_autoCompleteDelegate autoCompletion:self suggestionsFor:subString];
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.suggestionOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    _cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // This is added for a Search Bar - otherwise it will crash due to
    //'UITableView dataSource must return a cell from tableView:cellForRowAtIndexPath:'
    if (!_cell) {
        _cell = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil][0];
        
    }
    if ([self.options valueForKey:ACOUseSourceFont])
    {
        _cell.lbl.font = [self.options valueForKey:ACOUseSourceFont];
    } else
    {
        _cell.lbl.font = self.cellLabelFont;
    }
//    _cell.lbl.adjustsFontSizeToFitWidth = NO;
//    [_cell.lbl setTextAlignment:NSTextAlignmentRight];
    _cell.lbl.text = [self.suggestionOptions objectAtIndex:indexPath.row];
    _cell.backgroundColor = [UIColor clearColor];
   
    
    return _cell;
    

}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.textField setText:[self.suggestionOptions objectAtIndex:indexPath.row]];
    
    if (_autoCompleteDelegate && [_autoCompleteDelegate respondsToSelector:@selector(autoCompletion:didSelectAutoCompleteSuggestionWithIndex:)]) {
        [_autoCompleteDelegate autoCompletion:self didSelectAutoCompleteSuggestionWithIndex:indexPath.row];
    }
    
    [self hideOptionsView];
}

#pragma mark - UITextField delegate
- (void)textFieldValueChanged:(UITextField *)textField
{
    self.textField = textField;
    NSString *curString = textField.text;
    
    if (![curString length])
    {
        [self hideOptionsView];
        return;
    } else if ([self substringIsInDictionary:curString])
        {
            [self showOptionsView];
            [self reloadData];
        } else [self hideOptionsView];
}

#pragma mark - Options view control
- (void)showOptionsView
{
    self.hidden = NO;
}

- (void) hideOptionsView
{
    self.hidden = YES;
}

@end
