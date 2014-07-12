//
//  TimerTest.h
//  YolarooGrammar
//
//  Created by MGM on 5/7/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerTest : NSObject

@property (nonatomic,strong) NSDate* startTime;
@property (nonatomic,strong) NSDate* endTime;
@property (nonatomic,strong) NSDate* timeSinceLast;

@property (nonatomic) double finalCompletionTime;
@property (nonatomic) NSUInteger myCounter;
@property (nonatomic) NSTimer * myTimer;

- (void) completionTime;

- (void) setTheStartTime;
- (void) setTheEndTime;
- (void) resetValues;
- (void) timeSinceStart;


@end
