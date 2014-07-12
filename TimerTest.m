//
//  TimerTest.m
//  YolarooGrammar
//
//  Created by MGM on 5/7/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "TimerTest.h"

#import "SemanticTypeMatchView.h"

@implementation TimerTest

#define COUNT_MAX 10000

- (void) setTheStartTime
{
    self.startTime = [NSDate date];
    self.timeSinceLast = 0;
}

- (void) setTheEndTime
{
    self.endTime = [NSDate date];
}

//
////
//

- (void) timeSinceStart
{
    NSDate* timeNow = [NSDate date];
    double myTime = [timeNow timeIntervalSinceDate: self.startTime];
    NSLog(@"-- (TSS) %f --",myTime);
    double myQuickTime = [timeNow timeIntervalSinceDate: self.timeSinceLast];
    NSLog(@"-- (TSL) %f --",myQuickTime);
    self.timeSinceLast = timeNow;
}

- (void) completionTime
{
    self.finalCompletionTime = [self.startTime timeIntervalSinceDate: self.endTime];
    NSLog(@"timertest: %f",self.finalCompletionTime);
}

//
////
//

- (void) resetValues
{
    self.endTime = 0;
    self.startTime = 0;
    self.timeSinceLast = 0;
    self.finalCompletionTime = 0;
}

//
//// test case
//

- (void) actionTest {
    
    self.startTime = [NSDate date];
    
    NSInteger count = 0;
    while (count < COUNT_MAX) {
        NSLog(@"%ld",(long)count);
        count++;
    }
    
    self.EndTime = [NSDate date];
    self.FinalCompletionTime = [self.startTime timeIntervalSinceDate: self.endTime];
    
}

/*
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
*/

// test run in view did load
//[self performSelector:@selector(timeRunGameForTest) withObject:nil afterDelay:2.0];
// test run in view did load


//
//
////////
// test code for main foundation
////////
//
//

/*
- (void) timeRunGame
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:.001
                                                    target:self
                                                  selector:@selector(runTest)
                                                  userInfo:nil
                                                   repeats:YES];
    
}

- (void) testMethods{
    //[self resetAction];
    //[self autoUpdate];
}

#define LIMIT 500
- (void) runTest {
    if (self.myTimerTest.myCounter == 0){
        [self.myTimerTest setTheStartTime];
    }
    [self testMethods];
    self.myTimerTest.myCounter ++;
    if (self.myTimerTest.myCounter > LIMIT){
        NSLog(@"finish");
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.myTimerTest.myCounter = 0;
        [self.myTimerTest setTheEndTime];
        [self.myTimerTest completionTime];
        self.myTimerTest.startTime = nil;
        self.myTimerTest.endTime = nil;
    }
}
*/

@end
