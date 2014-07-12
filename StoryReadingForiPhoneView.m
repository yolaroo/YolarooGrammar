//
//  StoryReadingForiPhoneView.m
//  YolarooGrammar
//
//  Created by MGM on 6/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StoryReadingForiPhoneView.h"

#import "MainFoundation+StoryReadingDataLoad.h"

#import <objc/message.h>

@interface StoryReadingForiPhoneView ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
////
//

@property (weak, nonatomic) IBOutlet UIImageView *myBG;

@property (weak, nonatomic) IBOutlet UIView *viewForExtraShadow;

@property (weak, nonatomic) IBOutlet UIView *myViewHolder;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;


//
////
//

@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) BOOL isNext;
@property (nonatomic, strong) NSMutableArray *mySentenceArray;

//
////
//

@property (nonatomic) NSInteger storyNumber;
@property (nonatomic, strong) NSMutableString* titleString;
@property (nonatomic, strong) Story* theStory;
@property (nonatomic, strong) NSMutableArray* theTotalSentencesArray;

@property (nonatomic, strong) NSMutableArray* theStoryStringArray;
@property (nonatomic, strong) NSMutableString* mainString;

//
////
//

@property (nonatomic) BOOL canNotResetStory;

//
////
//

@end

@implementation StoryReadingForiPhoneView

#define DK 2
#define LOG if(DK == 1)

#define BG_COLOR [UIColor whiteColor]
#define FONT_COLOR [UIColor darkGrayColor]
#define DARK_BG_COLOR [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f]
#define SHADOW_COLOR [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.6f]


//
//
//////
#pragma mark - load view
//////
//
//

- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self previousAction];
}


- (IBAction)swipeLeft:(UISwipeGestureRecognizer *)sender {
    [self nextAction];
}

- (void) nextAction {
    self.pageNumber++;
    [self loadUI];
    [self foundationStopSpeech];

}

- (void) previousAction {
    self.pageNumber--;
    [self loadUI];
    [self foundationStopSpeech];
}

//
//
//////
#pragma mark - load view
//////
//
//

- (void) loadUI {
    self.myLabel.text = [self.mySentenceArray objectAtIndex:self.pageNumber];
}

//
//
//////
#pragma mark - View Setters for flip
//////
//
//

- (NSInteger) pageNumber {
    if (_pageNumber < 0){
        _pageNumber = [_mySentenceArray count]-1;
    }
    else if (_pageNumber >= [_mySentenceArray count]){
        _pageNumber = 0;
    }
    return _pageNumber;
}

- (NSMutableArray*) mySentenceArray {
    if (!_mySentenceArray) {
        _mySentenceArray = [[NSMutableArray alloc]init];
    }
    return _mySentenceArray;
}

//
//
//////
#pragma mark - audio
//////
//
//

- (IBAction)touchForSound:(UITapGestureRecognizer *)sender {
    [self foundationRunSpeech:@[self.myLabel.text]];
}

//
//
//////
#pragma mark - button actions for new story
//////
//
//

- (IBAction)myButtonPress:(UIButton *)sender {
    if (!self.canNotResetStory){
        [self buttonAction];
    }
}

- (void) buttonAction {
    self.canNotResetStory = true;
    [self storyNumberCeckerAndMaxCheck];
    [self loadANewStory];
    [self performSelector:@selector(allowNewStory) withObject:nil afterDelay:0.3];
}

- (void) allowNewStory {
    self.canNotResetStory = false;
}

- (void) loadANewStory {
    [self loadDataPerStory];
    [self loadDataForUI];
    self.pageNumber = 0;
}

- (void) storyNumberCeckerAndMaxCheck {
    self.storyNumber++;
    if (self.storyNumber >= [self myStoryIndexMax:self.managedObjectContext]) {
        self.storyNumber = 0;
    }
}

//
//
//////
#pragma mark - data loaders for reading arrays
//////
//
//

#define SENTENCE_COUNT 18

- (void) loadDataForUI {
    LOG NSLog(@"(array) %@",self.theTotalSentencesArray);
    
    if ([self.theTotalSentencesArray count] < SENTENCE_COUNT) return;
    
    LOG NSLog(@"count %lu",(unsigned long)[self.theTotalSentencesArray count]);
    
    NSString* NSString01 = [NSString stringWithFormat:@"%@.\n%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:0],[self.theTotalSentencesArray objectAtIndex:1],[self.theTotalSentencesArray objectAtIndex:2]];
    
    NSString* NSString02 = [NSString stringWithFormat:@"%@.\n%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:3],[self.theTotalSentencesArray objectAtIndex:4],[self.theTotalSentencesArray objectAtIndex:5]];
    
    NSString* NSString03 = [NSString stringWithFormat:@"%@.\n%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:6],[self.theTotalSentencesArray objectAtIndex:7],[self.theTotalSentencesArray objectAtIndex:8]];
    
    NSString* NSString04 = [NSString stringWithFormat:@"%@.\n%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:9],[self.theTotalSentencesArray objectAtIndex:10],[self.theTotalSentencesArray objectAtIndex:11]];
    
    NSString* NSString05 = [NSString stringWithFormat:@"%@.\n%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:12],[self.theTotalSentencesArray objectAtIndex:13],[self.theTotalSentencesArray objectAtIndex:14]];
    
    NSString* NSString06 = [NSString stringWithFormat:@"%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:15],[self.theTotalSentencesArray objectAtIndex:16]];
    
    NSString* NSString07 = [NSString stringWithFormat:@"%@.\n%@.",[self.theTotalSentencesArray objectAtIndex:17],[self.theTotalSentencesArray objectAtIndex:18]];
    
    self.mySentenceArray = [@[self.titleString,NSString01,NSString02,NSString03,NSString04,NSString05,NSString06,NSString07] mutableCopy];
    
    [self loadUI];
}

//
//
//////
#pragma mark - main data loader
//////
//
//

- (void) loadDataPerStory {
    @try {
        self.theStory = [self myStoryLoader:self.storyNumber withContext:self.managedObjectContext];
        
        self.titleString =[[self titleString:self.theStory]mutableCopy];
        LOG NSLog(@"(title) %@",self.titleString);
        
        //MAX
        self.theTotalSentencesArray = [[self loadSentencesToString:[self storySentencesDataLoad:self.theStory withContext:self.managedObjectContext]] mutableCopy];
    }
    @catch (NSException *exception) {
        NSLog(@"SRV %@",exception);
    }
}

//
//
//////
#pragma mark - First Load
//////
//
//

- (void) firstLoad {
    [self loadDataPerStory];
    [self loadDataForUI];
    self.pageNumber = 0;
    self.storyNumber = 0;

    self.canNotResetStory = false;
}

//
//
//////
#pragma mark - Life Cycle
//////
//
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewStyleForLoad];
    [self performSelector:@selector(firstLoad) withObject:nil afterDelay:0.3];
    [self portraitLock];
    
    self.myBG.image = [self loadBGImage:@"iphonewood"];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//
//
//////
#pragma mark - Style
//////
//
//

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
    [self viewExtraShadow: self.viewForExtraShadow];
}

-(void)viewExtraShadow: (UIView*)shadowObject
{
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 7;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    shadowObject.layer.shadowColor = SHADOW_COLOR.CGColor;
}

//
//
//////
#pragma mark - Setters
//////
//
//

- (NSMutableString*) mainString {
    if (!_mainString) {
        _mainString = [[NSMutableString alloc]init];
    }
    return _mainString;
}

- (NSMutableString*) titleString {
    if (!_titleString) {
        _titleString = [[NSMutableString alloc]init];
    }
    return _titleString;
}

- (NSMutableArray*) theStoryStringArray {
    if (!_theStoryStringArray) {
        _theStoryStringArray = [[NSMutableArray alloc]init];
    }
    return _theStoryStringArray;
}

- (NSMutableArray*) theTotalSentencesArray{
    if (!_theTotalSentencesArray) {
        _theTotalSentencesArray = [[NSMutableArray alloc]init];
    }
    return _theTotalSentencesArray;
}

- (Story*) theStory {
    if (!_theStory) {
        _theStory = [[Story alloc]init];
    }
    return _theStory;
}

//
#pragma mark - force orientation
//

-(void)viewDidAppear:(BOOL)animated{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait );
    }
}


@end
