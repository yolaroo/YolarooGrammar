//
//  SwipeClass.m
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SwipeClass.h"

@implementation SwipeClass


- (void) swipeLoadSingle: (UIView*)myView
{
    UISwipeGestureRecognizer *oneFingerSwipeRight =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [myView addGestureRecognizer:oneFingerSwipeRight];
    
    UISwipeGestureRecognizer *oneFingerSwipeLeft =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [myView addGestureRecognizer:oneFingerSwipeLeft];
}

- (void) swipeLoadDouble: (UIView*)myView
{
    UISwipeGestureRecognizer *twoFingerSwipeRight =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerSwiperight:)];
    [twoFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    twoFingerSwipeRight.numberOfTouchesRequired = 2;
    [myView addGestureRecognizer:twoFingerSwipeRight];
    
    UISwipeGestureRecognizer *twoFingerSwipeLeft =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerSwipeLeft:)];
    [twoFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    twoFingerSwipeLeft.numberOfTouchesRequired = 2;
    [myView addGestureRecognizer:twoFingerSwipeLeft];
}

- (void)oneFingerSwipeRight:(UISwipeGestureRecognizer *)recognizer{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"swipeRight"
     object:self];
}
- (void)oneFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"swipeLeft"
     object:self];
}
- (void)twoFingerSwiperight:(UISwipeGestureRecognizer *)recognizer{
}
- (void)twoFingerSwipeLeft:(UISwipeGestureRecognizer *)recognizer{
}


/*
 
 // implementation for view

 - (void) swipeLoad {
 [self foundationSwipeSingleLoad:self.view];
 [self loadSwipeNotification];
 }
 
 - (void)swipeRightNotifier:(NSNotification *)notification {
 [self previousAction];
 }
 
 - (void)swipeLeftNotifier:(NSNotification *)notification {
 [self nextAction];
 }
 
 - (void) nextAction {
 LOG NSLog(@"next swipe");
 self.pageCount = self.pageCount +1;
 LOG NSLog(@"-- NAPC %ld --",(long)self.pageCount);
 
 if (self.pageCount > PAGE_MAX)self.pageCount = 0;
 [self reloadUI];
 }
 
 - (void) previousAction {
 LOG NSLog(@"previsous swipe");
 self.pageCount --;
 LOG NSLog(@"-- PAPC %ld --",(long)self.pageCount);
 
 if (self.pageCount <= 0)self.pageCount = 0;
 [self reloadUI];
 }

 */


@end
