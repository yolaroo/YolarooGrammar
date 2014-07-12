//
//  StoryReadingView.m
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StoryReadingView.h"
#import "MainFoundation+StoryReadingDataLoad.h"

#import "FlipView.h"
#import "AnimationDelegate.h"

#import <objc/message.h>

@class FlipView;
@class AnimationDelegate;

@interface StoryReadingView ()  <UIGestureRecognizerDelegate> {
    AnimationDelegate *myNewAnimationDelegate;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
////
//

@property (weak, nonatomic) IBOutlet UIImageView *myBG;

@property (weak, nonatomic) IBOutlet UIView *viewForExtraShadow;


@property (weak, nonatomic) IBOutlet UIView *myPanViewHolder;

@property (weak, nonatomic) IBOutlet UIView *myViewHolder;
@property (nonatomic, strong) FlipView *myNewFlipView;

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

@implementation StoryReadingView
@synthesize mainString=_mainString,theStoryStringArray=_theStoryStringArray,theTotalSentencesArray=_theTotalSentencesArray,titleString=_titleString,theStory=_theStory;

#define DK 2
#define LOG if(DK == 1)

#define BG_COLOR [UIColor whiteColor]
#define FONT_COLOR [UIColor darkGrayColor]
#define DARK_BG_COLOR [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f]
#define SHADOW_COLOR [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.6f]

#define UIViewAutoresizingFlexibleMargins   \
UIViewAutoresizingFlexibleBottomMargin    | \
UIViewAutoresizingFlexibleLeftMargin      | \
UIViewAutoresizingFlexibleRightMargin     | \
UIViewAutoresizingFlexibleTopMargin       | \
UIViewAutoresizingFlexibleWidth           | \
UIViewAutoresizingFlexibleHeight

#define isDeviceIPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

//
//
//////
#pragma mark - Redraw view object on rotate
//////
//
//

- (void) resetFlipView {
    [self.myNewFlipView removeFromSuperview];
    self.myNewFlipView = nil;
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.3];
}

- (void) moveToPageNumber: (NSInteger) pagenumber {
    NSLog(@"-- page count: %ld",(long)[self.mySentenceArray count]);

    if (pagenumber == 0) return;
//    NSInteger oldNumber = pagenumber;
    for (int i = 0; i < ([self.mySentenceArray count] - pagenumber); i++) {
        myNewAnimationDelegate.sequenceType = kSequenceControlled;
        myNewAnimationDelegate.animationLock = YES;
        [myNewAnimationDelegate setTransformValue:400 delegating:NO];
        [myNewAnimationDelegate endStateWithSpeed:400];
    }
//    self.pageNumber = oldNumber;
    NSLog(@"-- moved to page: %ld",(long)self.pageNumber);

}

- (void) reload {
    [self newFlipLoad];
    [self moveToPageNumber:self.pageNumber];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    LOG NSLog(@"-- %@",NSStringFromCGRect (self.myViewHolder.frame));
    [self resetFlipView];
}

//
//
//////
#pragma mark - load text view flip object
//////
//
//

- (void) newFlipLoad {
    
    myNewAnimationDelegate = [[AnimationDelegate alloc] initWithSequenceType:kSequenceControlled
                                                               directionType:kDirectionForward];
    myNewAnimationDelegate.controller = self;
    myNewAnimationDelegate.perspectiveDepth = 2000;
    
    self.myNewFlipView = [[FlipView alloc] initWithAnimationType:kAnimationFlipHorizontal
                                                           frame:CGRectMake(0, 0, self.myViewHolder.frame.size.width, self.myViewHolder.frame.size.height)];
    
    myNewAnimationDelegate.transformView = self.myNewFlipView;
    
    [self.myViewHolder addSubview:self.myNewFlipView];
    //self.myNewFlipView.fontAlignment = @"Center";
    //self.myNewFlipView.sublayerCornerRadius = 6.0f;
    //self.myNewFlipView.autoresizingMask = UIViewAutoresizingFlexibleMargins;

    if (isDeviceIPad){
        self.myNewFlipView.fontSize = 32; // 18 for ipad
        self.myNewFlipView.textOffset = CGPointMake(2.0, 135.0); //margin
    }
    else {
        self.myNewFlipView.fontSize = 22; // 18 for iphone
        self.myNewFlipView.textOffset = CGPointMake(2.0, 100.0); // 100 margin
    }
    
    self.myNewFlipView.textInset = CGPointMake(0.0, 0.0); //inset margin
    self.myNewFlipView.font = @"Helvetica";
    self.myNewFlipView.textTruncationMode = kCATruncationNone;
    
    for (NSString* STR in [self.mySentenceArray copy]) {
        [self.myNewFlipView printText:STR usingImage:nil backgroundColor:BG_COLOR textColor:FONT_COLOR];
    }
    
    if (isDeviceIPad){
        self.myNewFlipView.fontSize = 38; // 32 for ipad
        self.myNewFlipView.textOffset = CGPointMake(2.0, 120.0); // 50 margin
    }
    else {
        self.myNewFlipView.fontSize = 28; // 28 for iphone
        self.myNewFlipView.textOffset = CGPointMake(2.0, 55.0); // 55 margin
    }
    
    self.myNewFlipView.font = @"Georgia";
    [self.myNewFlipView printText:[self.titleString copy] usingImage:nil backgroundColor:DARK_BG_COLOR textColor:FONT_COLOR];
    self.myNewFlipView.currentString = [self.titleString copy];
    
    [self.myNewFlipView rearrangeLayers:kDirectionForward :0];
}

//
//
//////
#pragma mark - load pan for page change
//////
//
//

- (IBAction) panGesturePress:(UIPanGestureRecognizer *)sender {
    UIPanGestureRecognizer * recognizer = (UIPanGestureRecognizer *)sender;
    CGPoint velocity;
    CGPoint lastGestureVelocity;
    velocity = [recognizer velocityInView:self.myPanViewHolder];
    if(velocity.x*lastGestureVelocity.x + velocity.y*lastGestureVelocity.y > 0) {
        LOG NSLog(@"reverse");
        self.isNext = false;
    }
    else {
        LOG NSLog(@"forward");
        self.isNext = true;
    }
    lastGestureVelocity = velocity;
    
    LOG NSLog(@"v: %f",velocity.x);

    switch (recognizer.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateBegan: {
            if (CGRectContainsPoint(self.myPanViewHolder.frame, [recognizer locationInView:self.view])) {
                if (myNewAnimationDelegate.animationState == 0) {
                    [NSObject cancelPreviousPerformRequestsWithTarget:self];
                    myNewAnimationDelegate.sequenceType = kSequenceControlled;
                    myNewAnimationDelegate.animationLock = YES;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (myNewAnimationDelegate.animationLock) {
                switch (self.myNewFlipView.animationType) {
                    case kAnimationFlipVertical: { // NOT USED
                        float value = [recognizer translationInView:self.view].y;
                        [myNewAnimationDelegate setTransformValue:value delegating:NO];
                    }
                        break;
                    case kAnimationFlipHorizontal: {
                        float value = [recognizer translationInView:self.view].x;
                        [myNewAnimationDelegate setTransformValue:value delegating:NO];
                    }
                        break;
                    default:break;
                }
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateEnded: {
            if (myNewAnimationDelegate.animationLock) {
                float value = sqrtf(fabsf([recognizer velocityInView:self.view].x))/10.0f;
                [myNewAnimationDelegate endStateWithSpeed:value];
            }
        }
            break;
        default:
            break;
    }
    
}

//
//
//////
#pragma mark - notification
//////
//
//

- (void) loadViewNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(layChangeNotifier:)
     name:@"layerChange"
     object:nil];
}

- (void)layChangeNotifier:(NSNotification *)notification {
    if (self.isNext){
        self.pageNumber++;
        [self foundationStopSpeech];
         LOG NSLog(@"-- next: %ld",(long)self.pageNumber);
    }
    else {
        self.pageNumber--;
        [self foundationStopSpeech];
         LOG NSLog(@"-- previous: %ld",(long)self.pageNumber);
    }
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
        _pageNumber = [_mySentenceArray count];
    }
    else if (_pageNumber > [_mySentenceArray count]){
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
    LOG NSLog(@" MCSN - %@",self.myNewFlipView.currentString);
    LOG NSLog(@"-- PN %ld --",(long)self.pageNumber);
    [self foundationRunSpeech:@[self.myNewFlipView.currentString]];
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
    [self loadUI];
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

- (void) loadUI {
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

    self.mySentenceArray = [@[NSString01,NSString02,NSString03,NSString04,NSString05,NSString06,NSString07] mutableCopy];
    
    [self newFlipLoad];
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
    [self loadUI];
    self.pageNumber = 0;
    self.storyNumber = 0;
    [self loadViewNotification];
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
    
    if (isDeviceIPad) {
        self.myBG.image = [self loadBGImage:@"ipadwood"];
    }
    else {
        self.myBG.image = [self loadBGImage:@"iphonewood"];
    }
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
