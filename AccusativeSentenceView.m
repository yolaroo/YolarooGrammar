//
//  AccusativeSentenceView.m
//  YolarooGrammar
//
//  Created by MGM on 5/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AccusativeSentenceView.h"
#import "MainFoundation+AccusativeDataLoader.h"

@interface AccusativeSentenceView ()

@property (weak, nonatomic) IBOutlet UILabel *labelTop;
@property (weak, nonatomic) IBOutlet UILabel *labelBottom;

@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (weak, nonatomic) IBOutlet UIButton *button03;
@property (weak, nonatomic) IBOutlet UIButton *button04;

@property (weak, nonatomic) IBOutlet UISlider *mySliderView;
@property (weak, nonatomic) IBOutlet UILabel *mySliderNumber;

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

@property (strong,nonatomic) NSMutableString* theReformatedAnswer;
@property (strong,nonatomic) NSMutableString* theAnswer;
@property (nonatomic) NSUInteger theCase;
@property (nonatomic) NSUInteger theTotalCount;

@end

@implementation AccusativeSentenceView

@synthesize theAnswer=_theAnswer;

#define DK 2
#define LOG if(DK == 1)

#define SLIDER_MAX 3.0f
#define RESET_DELAY 0.3

//
//
////////
//
////////
//
//

#pragma mark - Button Press

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

- (IBAction)buttonPress:(UIButton *)sender {
    if (self.canClickBottomButtons){
        UIButton*myButton = (UIButton*) sender;
        [self checkButtonPress:myButton];
    }
    else {
        [self foundationRunSpeech:@[self.theReformatedAnswer]];
    }
}

- (void) checkButtonPress:(UIButton*)myButton {
    NSString*string  = myButton.currentTitle;
    if ([self.theAnswer isEqualToString:string]){
        
        self.canClickBottomButtons = false;
        self.canClickTopButton = true;
        
        self.labelBottom.text = self.theReformatedAnswer;
        [self foundationRunSpeech:@[self.theReformatedAnswer]];

        [self clearButton:self.myButtonCollection];

    }
    else {
        myButton.alpha = 0.4f;
        [self foundationRunSpeech:@[string]];
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

- (NSDictionary*) dataLoad {
    //delta
    return [self theDataSetFromCaseForAccusative:self.theCase withContext:self.managedObjectContext];
}

- (NSArray*) buttonDataLoad {
    //delta
    NSArray*myFirstButtons = [self buttonViewFromCaseForAccusative:self.theCase];
    return myFirstButtons;
}

//
//
////////
//
////////
//
//

#pragma mark - Slider Press

- (IBAction)sliderPress:(UISlider *)sender {
    UISlider*mySlider = (UISlider*)sender;
    [self mySliderAction:mySlider];
}

- (void) mySliderAction: (UISlider*)mySlider
{
    mySlider.maximumValue = SLIDER_MAX;
    mySlider.continuous = NO;
    mySlider.value = (NSInteger)ceil(mySlider.value);
    self.theCase = (NSInteger)ceil(mySlider.value);
    self.theTotalCount = 0;
    [self clearButton:self.myButtonCollection];

    self.mySliderNumber.text =[[NSNumber numberWithInteger: (NSInteger)ceil(mySlider.value)] stringValue];
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

#pragma mark - View

- (void) buttonViewSet {
    NSArray*myButtons = @[self.button01,self.button02,self.button03,self.button04];
    for (int i = 0; i < [myButtons count]; i++) {
        [[myButtons objectAtIndex:i] setTitle:[[self buttonDataLoad]objectAtIndex:i ] forState:UIControlStateNormal];
    }
}

- (void) loadView: (NSArray*)myString {
    self.labelTop.text = [myString firstObject];
    self.labelBottom.text = [myString objectAtIndex:1];

}

- (void) resetAction {
    [self loadDataToUI];
    [self autoUpdate];
}

- (void) resetUI {
    [self buttonViewSet];
    self.canClickBottomButtons = true;
    self.canClickTopButton = false;
    
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
    @try {
        [self resetUI];
        //delta
        NSArray* answer = [[self dataTransformationForAccusative:[self dataLoad]]copy];
        [self loadView: answer];
        self.theAnswer = [NSMutableString stringWithString:[answer lastObject]];
        self.theReformatedAnswer = [NSMutableString stringWithString:[answer objectAtIndex:2]];
    }
    @catch (NSException *exception) {
        NSLog(@"ACV %@",exception);
    }
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
}

- (void)resetDataNotifier:(NSNotification *)notification {
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:RESET_DELAY];
}

- (void) autoUpdate {
    self.theTotalCount ++;
    if (self.theTotalCount >= 30){
        self.theTotalCount = 0;
        self.theCase++;
        if (self.theCase >=SLIDER_MAX){
            self.theCase = 0;
        }
        self.mySliderView.maximumValue = SLIDER_MAX;
        self.mySliderView.value = self.theCase;
        self.mySliderNumber.text = [[NSNumber numberWithInteger:self.theCase]stringValue];
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
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:RESET_DELAY];
    [self loadViewNotification];
    [self viewStyleForLoad];
    // test run in viewDidLoad
    //[self performSelector:@selector(timeRunGameForTest) withObject:nil afterDelay:2.0];
    // test run in viewDidLoad
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    //[self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3];
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
