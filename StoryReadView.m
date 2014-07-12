//
//  StoryReadView.m
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StoryReadView.h"

@interface StoryReadView ()

@property (weak, nonatomic) IBOutlet UIButton *buttonSentence01;
@property (weak, nonatomic) IBOutlet UIButton *buttonSentence02;
@property (weak, nonatomic) IBOutlet UIButton *buttonSentence03;
@property (weak, nonatomic) IBOutlet UIButton *buttonSentence04;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@end

@implementation StoryReadView

#define DK 2
#define LOG if(DK == 1)

//
#pragma mark - button press
//

- (IBAction)storyButtonPress:(UIButton *)sender {
    UIButton*myButton = (UIButton*)sender;
    [self foundationRunSpeech:@[myButton.currentTitle]];
}

//
////
//

- (void) viewStringSet
{
    LOG NSLog(@"-- string view reset --");
    [self loadPreferences];
    [self.buttonSentence01 setTitle:self.textForLabel01 forState:UIControlStateNormal];
    [self.buttonSentence02 setTitle:self.textForLabel02 forState:UIControlStateNormal];
    [self.buttonSentence03 setTitle:self.textForLabel03 forState:UIControlStateNormal];
    [self.buttonSentence04 setTitle:self.textForLabel04 forState:UIControlStateNormal];

}

//
////
//

- (void) loadPreferences {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* myDefaultValue = [defaults objectForKey:@"defaultSliderValue"];
    NSInteger myDBChoice = [myDefaultValue integerValue];
    
    LOG NSLog(@"-- (db) %@ --",myDefaultValue);
    LOG NSLog(@"-- (dbchoice) %@--",[defaults objectForKey:@"defaultSliderValue"]);
    
    if (!myDBChoice) {
        [defaults setInteger:0 forKey:@"defaultSliderValue"];
        [defaults synchronize];
    }
    else {
        [self setLabelAlpha: myDBChoice];
    }
}

- (void) setLabelAlpha: (NSInteger)number {
    
    switch (number) {
        case 0:
            self.buttonSentence01.alpha = 1;
            self.buttonSentence02.alpha = 1;
            self.buttonSentence03.alpha = 1;
            self.buttonSentence04.alpha = 1;
            break;
        case 1:
            self.buttonSentence02.alpha = 0.2;
            self.buttonSentence03.alpha = 0.2;
            self.buttonSentence04.alpha = 0.2;
            break;
        case 2:
            self.buttonSentence01.alpha = 0.2;
            self.buttonSentence03.alpha = 0.2;
            self.buttonSentence04.alpha = 0.2;
            break;
        case 3:
            self.buttonSentence01.alpha = 0.2;
            self.buttonSentence02.alpha = 0.2;
            self.buttonSentence04.alpha = 0.2;
            break;
        case 4:
            self.buttonSentence01.alpha = 0.2;
            self.buttonSentence02.alpha = 0.2;
            self.buttonSentence03.alpha = 0.2;
            break;
        default:
            self.buttonSentence01.alpha = 1;
            self.buttonSentence02.alpha = 1;
            self.buttonSentence03.alpha = 1;
            self.buttonSentence04.alpha = 1;
            break;
    }
}

//
////
//

#pragma mark - Life Cycle

- (void) viewDidLoad {
    [super viewDidLoad];
    [self viewStringSet];
    [self viewStyleForLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection) {
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        BTN.titleLabel. numberOfLines = 2;
        BTN.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;

        [self buttonShadow:BTN];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
