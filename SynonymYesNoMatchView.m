//
//  SynonymYesNoMatchView.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymYesNoMatchView.h"

#import "MainFoundation+SynonymYesNoDataLoader.h"

@interface SynonymYesNoMatchView ()

@property (weak, nonatomic) IBOutlet UILabel *labelTop;

@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UIButton *button02;

//
////
//

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

//
////
//

@property (nonatomic) NSUInteger theTotalCount;
@property (nonatomic) BOOL canClickTwoButtons;
@property (nonatomic) BOOL canClickTopButton;

//
////
//

@property (strong,nonatomic) NSMutableString* synonymClassString;
@property (strong,nonatomic) NSMutableArray* theLastAnswerArray;

@property (strong,nonatomic) NSMutableString* theQuestion;
@property (strong,nonatomic) NSMutableString* theAnswerForYes;
@property (strong,nonatomic) NSMutableString* theAnswerForNo;

//
////
//

@end

@implementation SynonymYesNoMatchView

#define DK 2
#define LOG if(DK == 1)

//
//
////////
//
////////
//
//

- (IBAction)buttonPressChangeAdjective:(UIButton *)sender {
    [self adjectivePressAction];
}

- (void) adjectivePressAction {
    self.synonymClassString = [[self setAdjectiveGroupName:self.managedObjectContext] mutableCopy];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

//
////
//

- (IBAction)buttonPressTop:(UIButton *)sender {
    if (self.canClickTopButton) {
        [self topAction];
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

- (void) topAction {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

//
////
//

- (IBAction)buttonPressYes:(UIButton *)sender {
    if (self.canClickTwoButtons){
        [self setMyLabelAnswer:self.theAnswerForYes];
        [self foundationRunSpeech:@[self.theAnswerForYes]];

        [self buttonAction];
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

- (IBAction)buttonPressNo:(UIButton *)sender {
    if (self.canClickTwoButtons){
        [self setMyLabelAnswer:self.theAnswerForNo];
        [self foundationRunSpeech:@[self.theAnswerForNo]];

        [self buttonAction];
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

- (void) buttonAction {
    [self setMyButtonsClear];
    self.canClickTwoButtons = false;
    self.canClickTopButton = true;
}

//
//
////////
//
////////
//
//

- (void) getMyData {

    @try {
        if ([self.synonymClassString length] == 0){
            self.synonymClassString = [[self setAdjectiveGroupName:self.managedObjectContext] mutableCopy];
            LOG NSLog(@"--(string) %@ --",self.synonymClassString);
        }
        
        NSArray*myArrayAnswer = [self myDataLoaderForSynonyms:self.synonymClassString withContext:self.managedObjectContext];
        
        self.theQuestion = [[myArrayAnswer firstObject] mutableCopy];
        self.theAnswerForYes = [[myArrayAnswer objectAtIndex:1] mutableCopy];
        self.theAnswerForNo = [[myArrayAnswer lastObject] mutableCopy];
        
        [self setMyButtonsDefault];
        [self setMyLabelQuestion];
    }
    @catch (NSException *exception) {
        NSLog(@"-- (SyV) %@ --",exception);
    }
    @finally {
        
    }
    // question
    // yes
    // no
}

//
//
////////
//
////////
//
//

- (void) setMyLabelQuestion {
    self.labelTop.text = self.theQuestion;
}

- (void) setMyLabelAnswer: (NSString*)myAnswer {
    self.labelTop.text = myAnswer;
}

- (void) setMyButtonsClear {
    [self.button01 setTitle:@"" forState:UIControlStateNormal];
    [self.button02 setTitle:@"" forState:UIControlStateNormal];
}

- (void) setMyButtonsDefault {
    [self.button01 setTitle:@"Yes" forState:UIControlStateNormal];
    [self.button02 setTitle:@"No" forState:UIControlStateNormal];
}

//
//
////////
//
////////
//
//

- (void) loadViewNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(resetDataNotifier:)
     name:@"needsToUpdate"
     object:nil];
}

- (void) resetDataNotifier:(NSNotification *)notification {
    [self performSelector:@selector(completeReset) withObject:nil afterDelay:0.1];
}

- (void) resetAction {
    self.canClickTwoButtons = true;
    self.canClickTopButton = false;
    [self getMyData];
}

- (void) completeReset {
    [self resetAction];
    [self autoUpdate];
    self.canClickTwoButtons = true;
}

- (void) autoUpdate {
    self.theTotalCount ++;
    if (self.theTotalCount >= 10){
        self.theTotalCount = 0;
        LOG NSLog(@"updated");
        //[self setTheSemanticDictionaryData];
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
////////
// test run
////////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:1.0];
    [self loadViewNotification];
    self.theLastAnswerArray = [NSMutableArray arrayWithCapacity:8];
    self.canClickTwoButtons = true;
    self.canClickTopButton = false;
    [self viewStyleForLoad];
    // test run in viewDidLoad
    //[self performSelector:@selector(timeRunGameForTest) withObject:nil afterDelay:2.0];
    // test run in viewDidLoad

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}


@end
