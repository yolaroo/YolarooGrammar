//
//  AntonymMatchView.m
//  YolarooGrammar
//
//  Created by MGM on 5/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AntonymMatchView.h"

#import "MainFoundation+AntonymMatchDataLoader.h"

@interface AntonymMatchView ()

@property (weak, nonatomic) IBOutlet UILabel *labelTop;
@property (weak, nonatomic) IBOutlet UILabel *labelBottom;

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
@property (nonatomic) BOOL canClickBottomButtons;
@property (nonatomic) BOOL canClickTopButton;

@property (nonatomic) BOOL canAutoPlayAudio;

//
////
//

@property (strong,nonatomic) NSMutableString* synonymClassString;
@property (strong,nonatomic) NSMutableArray* theLastAnswerArray;

@property (strong,nonatomic) NSMutableString* theAnswer;
@property (strong,nonatomic) NSMutableString* theQuestion;
@property (strong,nonatomic) NSMutableString* theAnswerForCorrect;
@property (strong,nonatomic) NSMutableString* theAnswerForFalse;

@property (strong,nonatomic) NSMutableString* responseForYesForSynonym;
@property (strong,nonatomic) NSMutableString* responseForNoForSynonym;
@property (strong,nonatomic) NSMutableString* responseForYesForAntonym;
@property (strong,nonatomic) NSMutableString* responseForNoForAntonym;

@property (strong,nonatomic) NSMutableString* responseForYes;
@property (strong,nonatomic) NSMutableString* responseForNo;

//
////
//

@end

@implementation AntonymMatchView

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
        self.canAutoPlayAudio = false;
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
    UIButton*myButton = (UIButton*) sender;
    if (self.canClickBottomButtons){
        [self buttonAction:myButton];
    }
    else {
        [self foundationRunSpeech:@[self.labelBottom.text]];
    }
}

- (IBAction)buttonPressNo:(UIButton *)sender {
    UIButton*myButton = (UIButton*) sender;
    if (self.canClickBottomButtons){
        [self buttonAction:myButton];
    }
    else {
        [self foundationRunSpeech:@[self.labelBottom.text]];
    }
}

- (void) buttonAction: (UIButton*) myButton {
    if ([myButton.currentTitle isEqualToString:self.theAnswer]){
        [self setMyButtonsClear];
        if ([self.theAnswer isEqualToString:@"Yes"]){
            [self setLabelForResponse:YES];
        }
        else {
            [self setLabelForResponse:NO];
        }
        self.canClickBottomButtons = false;
        self.canClickTopButton = true;
    }
    else {
        [myButton setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)setLabelForResponse: (BOOL)isYes {
    if (isYes){
        self.labelBottom.text =  [self.responseForYes copy];
        [self foundationRunSpeech:@[[self.responseForYes copy]]];
    }
    else {
        self.labelBottom.text =  [self.responseForNo copy];
        [self foundationRunSpeech:@[[self.responseForNo copy]]];
    }
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
        LOG NSLog(@"-- Data load start --");
        NSArray*myArray = [self myDataLoaderForAntonym: self.managedObjectContext];
        LOG NSLog(@"-- data load mid --");
        
        self.theQuestion = [myArray firstObject];
        self.theAnswerForCorrect = [myArray objectAtIndex:1];
        self.theAnswerForFalse = [myArray lastObject];
        
        self.responseForYesForSynonym = [myArray objectAtIndex:2];
        self.responseForNoForSynonym = [myArray objectAtIndex:3];
        self.responseForYesForAntonym = [myArray objectAtIndex:4];
        self.responseForNoForAntonym = [myArray objectAtIndex:5];
        
    }
    @catch (NSException *exception) {
        NSLog(@"-- (AnV) %@ --",exception);
    }
    @finally {
        LOG NSLog(@"-- data load end --");
    }

    // question
    // correct
    // yesSyn
    // noSyn
    // yes Ant
    // no Ant
    // false
}

//
//
////////
//
////////
//
//

- (void) setMyLabelQuestionCorrect {
    self.labelTop.text = self.theQuestion;
    self.labelBottom.text = self.theAnswerForCorrect;
    self.responseForYes = self.responseForYesForSynonym;
    self.responseForNo = self.responseForNoForSynonym;

    self.theAnswer = [@"Yes" mutableCopy];
}

- (void) setMyLabelQuestionFalse {
    self.labelTop.text = self.theQuestion;
    self.labelBottom.text = self.theAnswerForFalse;
    self.responseForYes = self.responseForYesForAntonym;
    self.responseForNo = self.responseForNoForAntonym;

    self.theAnswer = [@"No" mutableCopy];
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
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(audioFinished)
     name:@"soundIsFinished"
     object:nil];
}

- (void) audioFinished{
    if (!self.canAutoPlayAudio && self.canClickBottomButtons){
        self.canAutoPlayAudio = true;
        [self foundationRunSpeech:@[self.labelBottom.text]];
    }
}


- (void) resetDataNotifier:(NSNotification *)notification {
    [self performSelector:@selector(completeReset) withObject:nil afterDelay:0.1];
}

- (void) resetAction {
    self.canClickBottomButtons = true;
    self.canClickTopButton = false;
    self.canAutoPlayAudio = true;
    [self getMyData];
    [self setMyButtonsDefault];
    if ([self oneInTwo]){
        [self setMyLabelQuestionCorrect];
    }
    else {
        [self setMyLabelQuestionFalse];
    }
}

- (void) completeReset {
    [self resetAction];
    [self autoUpdate];
    self.canClickBottomButtons = true;
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
    self.canClickBottomButtons = true;
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
