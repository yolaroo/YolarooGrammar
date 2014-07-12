//
//  ComparisonMatchView.m
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "ComparisonMatchView.h"

#import "MainFoundation+WordComparisonDataLoader.h"

@interface ComparisonMatchView ()

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

@property (strong,nonatomic) NSMutableArray* adjectiveArray;
@property (nonatomic) NSUInteger adjectiveArrayCount;
@property (nonatomic) BOOL isConstantAdjectiveData;

//
////
//

@property (strong,nonatomic) NSMutableArray* comparisonData;
@property (strong,nonatomic) NSMutableArray* theLastAnswerArray;
@property (strong,nonatomic) NSMutableString* theQuestion;
@property (strong,nonatomic) NSMutableString* theAnswerFor01;
@property (strong,nonatomic) NSMutableString* theAnswerFor02;


@property (nonatomic) NSUInteger theTotalCount;
@property (nonatomic) BOOL canClickTwoButtons;
@property (nonatomic) BOOL canClickTopButton;

//
////
//

@property (strong,nonatomic) NSDictionary* theDictionaryData;

//
////
//

@end

@implementation ComparisonMatchView

#define DK 2
#define LOG if(DK == 1)

//
//
////////
//
////////
//
//

- (IBAction)buttonPressRandomAdjective:(UIButton *)sender {
    @try {
        [self setToRandomAdjective];
    }
    @catch (NSException *exception) {
        NSLog(@"-- (CV) %@ --",exception);
    }
}

- (void) setToRandomAdjective {
    self.isConstantAdjectiveData = false;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

- (IBAction)buttonPressChangeAdjective:(UIButton *)sender {
    @try {
        [self setSpecificData];
    }
    @catch (NSException *exception) {
        NSLog(@"-- (CV) %@ --",exception);
    }
    
}

- (void) setSpecificData {
    self.isConstantAdjectiveData = true;
    self.adjectiveArrayCount ++;
    [self setAdjectiveArray];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

- (void) setAdjectiveArray {
    NSArray* array = [self setAdjectiveGroup:self.managedObjectContext];
    if (self.adjectiveArrayCount <= [array count]) {
        NSArray*temp = @[[array objectAtIndex:self.adjectiveArrayCount]];
        self.adjectiveArray = [temp mutableCopy];
    }
    else {
        self.adjectiveArrayCount = 0;
        NSArray*temp = @[[array objectAtIndex:self.adjectiveArrayCount]];
        self.adjectiveArray = [temp mutableCopy];
    }
    AdjectiveClass*mine = [self.adjectiveArray firstObject];
    LOG NSLog(@"--(adj click) %@--",mine.basic);
}

//
//
////////
//
////////
//
//

- (IBAction)buttonPressUnknown:(UIButton *)sender {
    [self unknownAction];
}

- (void) unknownAction {
    [self myButtonAnswer:@"DID_NOT_KNOW" withFullString: @" - "];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

//
//
////////
//
////////
//
//

- (IBAction)buttonPressTop:(UIButton *)sender {
    if (self.canClickTopButton){
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"needsToUpdate"
         object:self];
        self.canClickTopButton = false;
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

//
////
//

- (IBAction)buttonPress01:(UIButton *)sender {
    if (self.canClickTwoButtons){
        [self myButtonAnswer:self.button01.currentTitle withFullString:self.theAnswerFor01];
        [self setMyLabelAnswer:self.theAnswerFor01];
        [self foundationRunSpeech:@[self.theAnswerFor01]];

        [self.button01 setTitle:@"" forState:UIControlStateNormal];
        [self.button02 setTitle:@"" forState:UIControlStateNormal];
        self.canClickTwoButtons = false;
        self.canClickTopButton = true;
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

- (IBAction)buttonPress02:(UIButton *)sender {
    if (self.canClickTwoButtons){
        [self myButtonAnswer:self.button02.currentTitle withFullString:self.theAnswerFor02];
        [self setMyLabelAnswer:self.theAnswerFor02];
        [self foundationRunSpeech:@[self.theAnswerFor02]];

        [self.button01 setTitle:@"" forState:UIControlStateNormal];
        [self.button02 setTitle:@"" forState:UIControlStateNormal];
        self.canClickTwoButtons = false;
        self.canClickTopButton = true;
    }
    else {
        [self foundationRunSpeech:@[self.labelTop.text]];
    }
}

//
////
//

- (void) myButtonAnswer: (NSString*) myAnswer withFullString: (NSString*) fullString {
    [self setMyComparisonDataClass:self.comparisonData withWinnerString:myAnswer withSentenceString: fullString withContext:self.managedObjectContext];
    

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
        NSArray* myData;
        if (self.isConstantAdjectiveData){
            if (![self.adjectiveArray count]) {
                LOG NSLog(@"non");
                [self setAdjectiveArray];
            }
            LOG NSLog(@"should load here");
            myData = [self myDataLoaderForComparisons:self.adjectiveArray withContext:self.managedObjectContext];
        }
        else {
            myData = [self myDataLoaderForComparisons:@[] withContext:self.managedObjectContext];
        }
        
        self.theAnswerFor01 = [myData firstObject];
        self.theAnswerFor02 = [myData lastObject];
        self.theQuestion = [myData objectAtIndex:2];
        
        [self setMyButtons: [myData objectAtIndex:1]];
        [self setMyLabelQuestion];
        
        self.comparisonData = [myData objectAtIndex:3];
        
    }
    @catch (NSException *exception) {
        NSLog(@"-- (CV) %@ --",exception);
    }
    
    // first answer - first object
    // second answer - last object
    // button - 01
    // label (question) - 02
    // comparison - 03
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

- (void) setMyButtons:(NSArray*)answer  {
    [self.button01 setTitle:[answer firstObject] forState:UIControlStateNormal];
    [self.button02 setTitle:[answer lastObject] forState:UIControlStateNormal];
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
    [self performSelector:@selector(completeReset) withObject:nil afterDelay:0.03];
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
