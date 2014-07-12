//
//  StartScreen.m
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "StartScreen.h"
#import <AVFoundation/AVFoundation.h>
#import "GrammarDelegate.h"

@interface StartScreen ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@end

@implementation StartScreen

#define DK 2
#define LOG if(DK == 1)

//
//
////////
//
////////
//
//

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewStyleForLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;

    [self.navigationController popViewControllerAnimated:NO];

    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.screenIsPortraitOnly = false;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

//
//
//////
//
//////
//
//

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}
#define SHADOW_ALPHA 0.2f
#define SHADOW_COLOR [[UIColor colorWithRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0f alpha:SHADOW_ALPHA] CGColor]

-(void)viewShadow: (UIView*)shadowObject {
    [[shadowObject layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[shadowObject layer] setBorderWidth:0.8f];
    CGFloat radius = shadowObject.frame.size.width / 50;
    
    [[shadowObject layer] setCornerRadius:radius];
    shadowObject.layer.shadowOpacity = 1;
    shadowObject.layer.shadowRadius = 3;
    shadowObject.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    shadowObject.layer.shadowColor = SHADOW_COLOR;
}

/*
 #pragma mark - Types Master Load
 
 - (void) blockTest {
 NSLog(@"- Block Start -");
 
 //
 NSDate *(^today)(void);
 today = ^(void){
 return [NSDate date];
 };
 NSLog(@"%@", today());
 //
 
 [self myFunction:@"thestringpasssed" andCompletionHandler:^(NSString* myString) {
 NSLog(@"Beta");
 }];
 
 [self newFunction:^(void){
 NSLog(@"second");
 }];
 
 }
 
 - (void) newFunction: (void (^)(void)) completionHandler {
 NSLog(@"first");
 for (int i = 0;i < 100;i++){
 NSLog(@"-- %d --",i);
 }
 completionHandler();
 };
 
 - (void) myFunction:(NSString*)string andCompletionHandler : (void (^)(NSString* myString)) completionHandler{
 NSLog(@"0");
 NSString* myString = string;
 completionHandler(myString);
 };
 
 #define NUMBER_OF_BYES 10000
 
 - (void) runAtEnd {
 [self nameFunction:^(void){
 NSLog(@"-Matt");
 }];
 }
 
 - (void) nameFunction: (void (^)(void)) completionHandler {
 for (int i = 0;i < NUMBER_OF_BYES;i++){
 NSLog(@"Caio \n");
 }
 completionHandler();
 };
 

 
 */

@end
