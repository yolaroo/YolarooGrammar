//
//  StoryQuestionMatchView.m
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StoryQuestionMatchView.h"

@interface StoryQuestionMatchView ()

@property (weak, nonatomic) IBOutlet UILabel *labelTop;
@property (weak, nonatomic) IBOutlet UILabel *labelBottom;

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

@property (nonatomic) BOOL canClickBottomButtons;
@property (nonatomic) BOOL canClickTopButton;

//
////
//

@property (strong,nonatomic) NSMutableString* theAnswer;
@property (strong,nonatomic) NSMutableString* theTextForAnswer;
@property (strong,nonatomic) NSMutableString* theQuestion;
@property (strong,nonatomic) NSMutableString* theLastQuestion;

//
////
//

@property (nonatomic) NSInteger theCase;

@end

@implementation StoryQuestionMatchView

#define DK 2
#define LOG if(DK == 1)

#define SENTENCE_MAX 4

//
//
////////
//  Defaults
////////
//
//

- (void) loadPreferences {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* myDefaultValue = [defaults objectForKey:@"defaultSliderValue"];
    NSInteger myDBChoice = [myDefaultValue integerValue];
    
    LOG NSLog(@"-- (db) %@ --",myDefaultValue);
    LOG NSLog(@"-- (dbchoice) %@--",[defaults objectForKey:@"defaultSliderValue"]);
    
    if (!myDBChoice) {
        [defaults setInteger:self.theCase forKey:@"defaultSliderValue"];
        [defaults synchronize];
    }
    else {
        if (myDBChoice > SENTENCE_MAX){
            LOG NSLog(@"slider default error");
            myDBChoice = 0;
            [defaults setInteger:myDBChoice forKey:@"defaultSliderValue"];
            [defaults synchronize];
        }
        if  (myDBChoice < 0) {
            LOG NSLog(@"slider default error");
            myDBChoice = 0;
            [defaults setInteger:myDBChoice forKey:@"defaultSliderValue"];
            [defaults synchronize];
        }
        self.theCase = (long)myDBChoice;
    }
}

//
//
////////
// buttons
////////
//
//

- (IBAction)topButtonPress:(UIButton *)sender {
    if (self.canClickTopButton){
        LOG NSLog(@"click top update");
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"needsToUpdate"
         object:self];
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

#pragma mark - Button Press

- (IBAction)buttonPress:(UIButton *)sender {
    if (self.canClickBottomButtons){
        UIButton*myButton = (UIButton*) sender;

        [self foundationRunSpeech:@[myButton.currentTitle]];

        [self checkButtonPress:myButton];
    }
}

- (void) checkButtonPress:(UIButton*)myButton {
    NSString*string  = myButton.currentTitle;
    if ([self.theAnswer isEqualToString:string]){
        self.canClickTopButton = true;
        self.canClickBottomButtons = false;
        self.labelBottom.text = self.theTextForAnswer;
        [self clearButtons];
    }
    else {
        myButton.alpha = 0.4f;
    }
}

- (void) clearButtons {
    for (UIButton* btn in self.myButtonCollection){
        [btn setTitle:@"" forState:UIControlStateNormal];
    }
}

//
//
////////
//
////////
//
//

#pragma mark - Data for View

- (NSInteger) setTheQuestionsForRandomInt {
    NSInteger randomInt;
    switch (self.theCase) {
        case 0:
            randomInt = arc4random() % 4;
            self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            while ([self.theQuestion isEqualToString:self.theLastQuestion]) {
                randomInt = arc4random() % 4;
                self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            }
            break;
        case 1:
            randomInt = 0;
            self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            break;
        case 2:
            randomInt = 1;
            self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            break;
        case 3:
            randomInt = 2;
            self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            break;
        case 4:
            randomInt = 3;
            self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            break;
        default:
            randomInt = 0;
            self.theQuestion = [[[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt] mutableCopy];
            break;
    }
    return randomInt;
}

- (void) dataLoad {

    // readingArray
    // questionArray
    // answerArray
    
    NSInteger randomInt = [self setTheQuestionsForRandomInt];
    
    self.theAnswer = [[[self.theDataArray lastObject] objectAtIndex:randomInt]mutableCopy];
    self.theTextForAnswer = [[[self.theDataArray firstObject] objectAtIndex:randomInt]mutableCopy];
    self.theLastQuestion = [[self.theDataArray objectAtIndex:1] objectAtIndex:randomInt];
    
    NSArray*myRandomAnswerArray = [self shuffleArray:[self.theDataArray lastObject]];
    NSArray* ArrayFromSet = [self removeDuplicateObjects:myRandomAnswerArray ];
    NSArray* myButtonArray = @[self.button01,self.button02,self.button03,self.button04];
    
    for (int i = 0; i < [ArrayFromSet count]; i++) {
        UIButton*myButton = [myButtonArray objectAtIndex:i];
        [myButton setTitle:[ArrayFromSet objectAtIndex:i] forState:UIControlStateNormal];
    }
    
    self.button01.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.button02.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.button03.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    self.button04.titleLabel.adjustsFontSizeToFitWidth = TRUE;
    
    self.labelTop.text = [NSString stringWithFormat:@"%@?",self.theQuestion];
    self.labelBottom.text = @"";
}

#pragma mark - View

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
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:0.1];
}


- (void) resetAction {
    [self loadDataToUI];
    self.canClickBottomButtons = true;
    self.canClickTopButton = false;
}

- (void) resetUI {
    for (UIButton* btn in self.myButtonCollection){
        btn.alpha = 1.0f;
    }
}

- (void) loadDataToUI {
    [self resetUI];
    [self dataLoad];
}

//
//
////////
//
////////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    [self loadPreferences];
    [self loadViewNotification];
    self.canClickBottomButtons = true;
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:0.3];
    [self viewStyleForLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
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
