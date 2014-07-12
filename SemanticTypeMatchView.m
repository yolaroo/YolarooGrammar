//
//  SemanticTypeMatchView.m
//  YolarooGrammar
//
//  Created by MGM on 5/5/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SemanticTypeMatchView.h"

#import "MainFoundation+SemanticTypeDataLoader.h"


@interface SemanticTypeMatchView ()

@property (weak, nonatomic) IBOutlet UILabel *labelTop;

@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (weak, nonatomic) IBOutlet UIButton *button03;
@property (weak, nonatomic) IBOutlet UIButton *button04;

//
////
//

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
////
//

@property (strong,nonatomic) NSMutableArray* theLastAnswerArray;
@property (strong,nonatomic) NSMutableString* theAnswer;
@property (nonatomic) NSUInteger theTotalCount;

@property (nonatomic) BOOL canClickBottomButtons;
@property (nonatomic) BOOL canClickTopButton;

@property (nonatomic) BOOL canAutoPlayAudio;


//
////
//

@property (strong,nonatomic) NSDictionary* theDictionaryData;

//
////
//

@end

@implementation SemanticTypeMatchView

@synthesize theAnswer=_theAnswer,theDictionaryData=_theDictionaryData;

#define DK 2
#define LOG if(DK == 1)

#define RESET_DELAY 0.3

//
//
////////
//
////////
//
//

#pragma mark - Reload Button Press

- (IBAction)reloadButtonPress:(UIButton *)sender {
    @try {
        [self setTheSemanticDictionaryData];
        self.theTotalCount = 0;
        [self resetAction];
    }
    @catch (NSException *exception) {
        NSLog(@"-- (TM) %@ --",exception);
    }
}

//
////
//

- (IBAction)topButtonPress:(UIButton *)sender {
    if (self.canClickTopButton) {
        self.canClickTopButton = false;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"needsToUpdate"
         object:self];
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

//
////
//

#pragma mark - Bottom Button Press

- (IBAction)buttonPress:(UIButton *)sender {
    if (self.canClickBottomButtons){
        UIButton*myButton = (UIButton*) sender;
        [self checkButtonPress:myButton];
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

- (void) checkButtonPress:(UIButton*)myButton {
    NSString*string  = myButton.currentTitle;
    [self foundationRunSpeech:@[string]];

    if ([self.theAnswer isEqualToString:string]){
        
        self.canClickBottomButtons = false;
        self.canClickTopButton = true;
        
        [self viewChangeToCorrectSentence];
        [self clearButton:self.myButtonCollection];

    }
    else {
        myButton.alpha = 0.4f;
    }
}

- (void) viewChangeToCorrectSentence
{
    NSString* theSentence = self.labelTop.text;
    NSString* theNewSentence = [theSentence stringByReplacingOccurrencesOfString:@"_____" withString:self.theAnswer];
    
    [UIView transitionWithView:self.labelTop
                      duration:.6
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{
                        self.labelTop.text = theNewSentence;

                    }
                    completion:NULL];
    
}

//
//
////////
//
////////
//
//

- (void) setTheSemanticDictionaryData {
    self.theDictionaryData = [self myDataForSemanticType:self.managedObjectContext];
}

//
//
////////
//
////////
//
//

#pragma mark - View

- (void) buttonViewSet: (NSArray*)myButtonData {
    NSArray*shuffledButton = [self shuffleArray:myButtonData];
    NSArray*myButtons = @[self.button01,self.button02,self.button03,self.button04];
    for (int i = 0; i < [myButtons count]; i++) {
        [[myButtons objectAtIndex:i] setTitle:[shuffledButton objectAtIndex:i ] forState:UIControlStateNormal];
    }
}

- (void) loadTopView: (NSArray*)myStringFromArray {
    [UIView animateWithDuration:.6 delay:0.0 options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.labelTop.alpha = 1;
                         self.labelTop.text = [myStringFromArray firstObject];
                     }
                     completion:nil];
}

- (void) resetAction {
    [self loadDataToUI];
}

- (void) resetUI {
    self.canClickBottomButtons = true;
    self.canClickTopButton = false;
    self.canAutoPlayAudio = false;

    for (UIButton* btn in self.myButtonCollection){
        btn.alpha = 1.0f;
        if ([btn.currentTitle isEqualToString:@"-"]){
            btn.hidden = YES;
        }
        else {
            btn.hidden = NO;
        }
    }
}

- (void) loadDataToUI {
    [self resetUI];
    
    @try {
        if (self.theDictionaryData == nil) {
            [self setTheSemanticDictionaryData];
        }
        
        NSArray* answer;
        answer = [self simpleSentenceLoadForSemanticType:self.theDictionaryData withContext: self.managedObjectContext];
        self.theAnswer = [NSMutableString stringWithString:[[answer lastObject] firstObject]];
        
        while ([self.theLastAnswerArray containsObject:[answer firstObject]]){
            answer = [self simpleSentenceLoadForSemanticType:self.theDictionaryData withContext: self.managedObjectContext];
            self.theAnswer = [NSMutableString stringWithString:[[[answer lastObject] firstObject]copy]];
            LOG NSLog(@"- duplicate answer %@ -",[answer firstObject]);
        }
        
        if ([self.theLastAnswerArray count] >= 8) {
            [self.theLastAnswerArray removeObjectAtIndex:0];
        }
        [self.theLastAnswerArray addObject:[answer firstObject]];
        
        LOG NSLog(@"- %lu -",(unsigned long)[self.theLastAnswerArray count]);
        LOG NSLog(@"- answer %@ -",[answer firstObject]);
        
        [self buttonViewSet:[[answer lastObject]copy]];
        [self transitionView];
        
        [self performSelector:@selector(loadTopView:) withObject:[answer copy] afterDelay:RESET_DELAY];
    }
    @catch (NSException *exception) {
        NSLog(@"-- (TM) %@ --",exception);
    }
    //[self loadTopView: [answer copy]];
}

- (void) transitionView {
    [UIView animateWithDuration:.6 delay:0.0 options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.labelTop.alpha = .01;
                     }
                     completion:nil];
}

//
//
////////
//
////////
//
//

#pragma mark - Notification

- (void) loadViewNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(resetDataNotifier:)
     name:@"needsToUpdate"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(audioFinished)
     name:@"soundIsFinished"
     object:nil];
    
}

- (void) audioFinished{
    if (!self.canAutoPlayAudio && !self.canClickBottomButtons){
        self.canAutoPlayAudio = true;
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

- (void)resetDataNotifier:(NSNotification *)notification {
    [self performSelector:@selector(completeReset) withObject:nil afterDelay:RESET_DELAY];
}

- (void) completeReset {
    [self resetAction];
    [self autoUpdate];
}

- (void) autoUpdate {
    self.theTotalCount ++;
    if (self.theTotalCount >= 10){
        self.theTotalCount = 0;
        LOG NSLog(@"updated");
        [self setTheSemanticDictionaryData];
    }
}

//
//
/////////////
// test run
/////////////
//
//

- (void) simpleTestMethods
{
    [self resetAction];
    [self autoUpdate];
}

//
//
////////////
// test run
////////////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:0.3];
    [self loadViewNotification];
    self.theLastAnswerArray = [NSMutableArray arrayWithCapacity:8];
    [self viewStyleForLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    // test run in viewDidLoad
    //[self performSelector:@selector(timeRunGameForTest) withObject:nil afterDelay:2.0];
    // test run in viewDidLoad
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
