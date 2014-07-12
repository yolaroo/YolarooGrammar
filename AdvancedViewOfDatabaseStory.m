//
//  AdvancedViewOfDatabaseStory.m
//  YolarooGrammar
//
//  Created by MGM on 4/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdvancedViewOfDatabaseStory.h"

#import "MainFoundation+SentenceController.h"
#import "MainFoundation+StorySearch.h"
#import "MainFoundation+Notifications.h"


#import "MainFoundation+SentenceWriters.h"

@interface AdvancedViewOfDatabaseStory ()
{
    NSInteger heightCount;
    NSInteger clickCount;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *expandedCellMutableArray;
@property (nonatomic)BOOL hasTappedCell;

@property (nonatomic) BOOL buttonSwitch;
@end

@implementation AdvancedViewOfDatabaseStory

@synthesize buttonSwitch=_buttonSwitch, expandedCellMutableArray=_expandedCellMutableArray;

#define DK 2
#define LOG if(DK == 1)

#define isDeviceIPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad
#define isDeviceIPhone UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

#define LINE_COUNT 30
#define HEIGHT_COUNT_TO_SIZE_IPHONE (LINE_COUNT-1)*20
#define HEIGHT_COUNT_TO_SIZE_IPAD (LINE_COUNT-1)*20*1.33

#define LARGE_HEIGHT_COUNT_TO_SIZE_IPHONE (LINE_COUNT-1)*20*1.5
#define LARGE_HEIGHT_COUNT_TO_SIZE_IPAD (LINE_COUNT-1)*20*1.65

#define IPHONE_FONT [UIFont systemFontOfSize:18.0]
#define IPAD_FONT [UIFont systemFontOfSize:24.0]
#define IPHONE_LARGE_FONT [UIFont systemFontOfSize:24.0]
#define IPAD_LARGE_FONT [UIFont systemFontOfSize:30.0]

#define CLICK_LIMIT 5

-(NSMutableArray*) expandedCellMutableArray {
    if (_expandedCellMutableArray != nil) {
        return _expandedCellMutableArray;
    }
    _expandedCellMutableArray = [[NSMutableArray alloc]init];
    return _expandedCellMutableArray;
}

//
////
//

- (IBAction)myButtonPress:(UIButton *)sender {
    //self.buttonSwitch = !self.buttonSwitch;
    [self clickCheck];
    [self updateUI];
}

- (void) clickCheck {
    clickCount ++;
    if (clickCount > CLICK_LIMIT) {
        clickCount = 0;
    }
}

//
//
////////
//
////////
//
//

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedRecordsArray count] ? [self.fetchedRecordsArray count] : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell = [self setMyCell:cell cellForRowAtIndexPath:indexPath];
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    return cell;
}

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Story * theStory = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
    if (theStory) {
        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;
        
        NSArray*SentenceFetch = [theStory.whatSentences allObjects];
        
        NSMutableArray* sentenceArray = [[NSMutableArray alloc]init];
        NSMutableString* theString = [[NSMutableString alloc]init];
        [theString appendString: ((Character*)[[theStory.whatCharacter allObjects] firstObject]).name];
        [theString appendString: @" \n"];
        [theString appendString: @" \n"];

        for (int i = 0; i < [SentenceFetch count]; i++) {
            for (int j = 0; j < [SentenceFetch count]; j++) {
                Sentence *mySentence = [SentenceFetch objectAtIndex:j];
                if ([mySentence.displayOrder integerValue] == i){
                    LOG NSLog(@" - Display Order - %@",mySentence.displayOrder);
                    
                    NSString*myString;
                    if (clickCount == 0) {
                        LOG NSLog(@"0-");
                        myString = [self sentenceForBasicStringUnwrap:mySentence];
                    }
                    else if(clickCount == 1){
                        LOG NSLog(@"1-");
                        myString = [self sentenceForNameBiasStringUnwrap:mySentence];
                    }
                    else if(clickCount == 2){
                        LOG NSLog(@"2-");
                        myString = [self sentenceForPronounBiasStringUnwrap:mySentence];
                    }
                    else if (clickCount == 3){
                        LOG NSLog(@"3-");
                        myString = [self sentenceForSubjectTransformationToQuestion:mySentence];
                    }
                    else if (clickCount == 4){
                        LOG NSLog(@"4-");
                        myString = [self sentenceForObjectTransformationToQuestion:mySentence];
                    }
                    else if (clickCount == 5){
                        LOG NSLog(@"5-");
                        myString = [self sentenceForObjectTransformationToQuestionWithNameBias:mySentence];
                    }
                    else {
                        LOG NSLog(@"6-");
                        myString = [self sentenceForBasicStringUnwrap:mySentence];
                    }
                    
                    [sentenceArray addObject:[myString copy]];
                }
            }
        }
        
        for (NSString* str in [sentenceArray copy]){
            [theString appendString:str];
            [theString appendString:@"\n"];
        }
        
        if (![self.expandedCellMutableArray containsObject:indexPath]){
            isDeviceIPad ? (cell.textLabel.font = IPAD_FONT) : (cell.textLabel.font = IPHONE_FONT);
        }
        else {
            isDeviceIPad ? (cell.textLabel.font = IPAD_LARGE_FONT) : (cell.textLabel.font = IPHONE_LARGE_FONT);
        }
        
        cell.textLabel.text = [theString copy];
        cell.textLabel.numberOfLines = [sentenceArray count]+4;
        
        return cell;
    }
    else {
        return nil;
    }
}

//
////
//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isDeviceIPad) {
        if ([self.expandedCellMutableArray containsObject:indexPath]) {
            return (HEIGHT_COUNT_TO_SIZE_IPAD <= 44)?44:LARGE_HEIGHT_COUNT_TO_SIZE_IPAD ;
        }
        else {
            return (HEIGHT_COUNT_TO_SIZE_IPAD <= 44)?44:HEIGHT_COUNT_TO_SIZE_IPAD ;
        }
    }
    else {
        if ([self.expandedCellMutableArray containsObject:indexPath]) {
            return (HEIGHT_COUNT_TO_SIZE_IPHONE <= 44)?44:LARGE_HEIGHT_COUNT_TO_SIZE_IPHONE ;
        }
        else {
            return (HEIGHT_COUNT_TO_SIZE_IPHONE <= 44)?44:HEIGHT_COUNT_TO_SIZE_IPHONE ;
        }
    }
}

//
//
////////
//
////////
//
//

#pragma mark - Table Action forSeque

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.hasTappedCell){
        self.hasTappedCell = !self.hasTappedCell;
        if (![self.expandedCellMutableArray containsObject:indexPath]){
            [self.expandedCellMutableArray addObject:indexPath];
        }
    }
    else {
        self.hasTappedCell = !self.hasTappedCell;
        if ([self.expandedCellMutableArray containsObject:indexPath]){
            [self.expandedCellMutableArray removeObject:indexPath];
        }
    }
    [self.tableView reloadData];
}

//
//
////////
//
////////
//
//

#pragma mark - DataLoad

- (NSArray*) myArraySetter {
    @try {
        NSArray*mine = [[self completeStoryList:self.managedObjectContext]copy];
        LOG NSLog(@"-- Count -- %lu",(unsigned long)[mine count]);
        return mine;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark - Update UI

- (void) updateUI
{
    LOG NSLog(@"UI updated");
    self.fetchedRecordsArray = [[self myArraySetter] copy];
    [self.tableView reloadData];
}

//
//
//////////
//
//////////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.buttonSwitch = false;
    [self loadNotifications];
    clickCount = 0;
    [self viewStyleForLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3f];
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
}

@end
