//
//  StorySelectionViewViewController.m
//  YolarooGrammar
//
//  Created by MGM on 5/18/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StorySelectionViewController.h"

#import "MainFoundation+StoryQuestionsDataloader.h"
#import <objc/message.h>

@interface StorySelectionViewController ()
{
    NSInteger clickcount;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UISlider *mySliderView;
@property (weak, nonatomic) IBOutlet UILabel *mySliderLabel;

@property (nonatomic) NSInteger theCase;

@end

@implementation StorySelectionViewController

#define DK 2
#define LOG if(DK == 1)

#define SLIDER_MAX 4

//
//
////////
#pragma mark - Reset
////////
//
//

- (IBAction)resetPress:(UIButton *)sender {
    clickcount++;
    if (clickcount > 5){
        [self myAlert:@"reloading"];
        self.myActivityIndicator = [self activityIndicatorAction];
        [self performSelector:@selector(resetPress) withObject:nil afterDelay:.3];
    }
    else if (clickcount == 5) {
        [self myAlert:@"last warning"];
    }
    else if (clickcount < 5){
        [self myAlert:@"will delete all stories"];
    }
}

- (void) resetPress {
    NSLog(@"-- Reset Pressed --");
    @try {
        [self resetStoryAction:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"SSV %@",exception);
    }
    @finally {
        [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:.3];
    }
}

//
//
////////
#pragma mark - Slider Press
////////
//
//

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
    
    self.mySliderLabel.text =[[NSNumber numberWithInteger: (NSInteger)ceil(mySlider.value)] stringValue];
    [self savePreferences];
    
    LOG NSLog(@"slider pressed");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

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
        if (myDBChoice > SLIDER_MAX){
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
        self.mySliderView.value = self.theCase;
        self.mySliderLabel.text =[[NSNumber numberWithInteger: self.theCase] stringValue];
    }
}

- (void) savePreferences {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.theCase forKey:@"defaultSliderValue"];
    [defaults synchronize];
}

//
//
////////
//  LOAD
////////
//
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self portraitLock];

    [self viewStyleForLoad];
    [self loadPreferences];
    [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:8];
    
    self.myActivityIndicator = [self activityIndicatorAction];
    [self performSelector:@selector(storyLoadDelay) withObject:nil afterDelay:0.3];
    
//    bool mybool = [self myArrayIndexIsOk:0 withArray:@[]];
//    mybool ? NSLog(@"true"): NSLog(@"false");
    
//    NSArray* speechArray = @[@"outside",@"stella cookie",@"wally you are handsome",@"lucy loves disco"];
//    [self foundationRunSpeech:speechArray];
    
}

-(void) storyLoadDelay{
    @try {
        [self storyCountCheckOnLoad:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"story not loading");
    }
    @finally {
        [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:.3];
    }
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }    
}

//
////
//

-(void)viewDidAppear:(BOOL)animated{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortrait );
    }
}

@end