//
//  MainFoundation+StoryQuestionsDataloader.m
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+StoryQuestionsDataloader.h"

#import "MainFoundation+SentenceController.h"
#import "MainFoundation+SentenceWriters.h"

#import "MainFoundation+DeleteAllWordRecords.h"

#import "MainFoundation+StoryQuestionUtilities.h"

@implementation MainFoundation (StoryQuestionsDataloader)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
#pragma mark - story page limiter
////////
//
//

- (void) resetStoryAction:(NSManagedObjectContext*)context
{
    [self deleteStoryList:self.managedObjectContext];
    [self storyCountCheck:self.managedObjectContext];
}

//
//
////////
#pragma mark - story page limiter
////////
//
//

- (NSInteger)theStoryMax: (NSManagedObjectContext*)context
{
    NSArray* storyArray = [[self storyList:context]mutableCopy];
    Story* myStory = [storyArray firstObject];
    NSArray* sentenceArray = [myStory.whatSentences allObjects];
    return [sentenceArray count];
}

- (void) storyCountCheck: (NSManagedObjectContext*)context {
    NSMutableArray* storyArray = [[self storyList:context]mutableCopy];
    NSInteger storyCount = [storyArray count];
    while (storyCount < 4) {
        [self makeNewStory:context];
        storyArray = [[self storyList:context]mutableCopy];
        storyCount = [storyArray count];
        LOG NSLog(@"-- (Story Count) %ld--", (long)storyCount);
    }
}

- (void) makeNewStory: (NSManagedObjectContext*)context
{
    [self myStoryBuilder:context];
    [self saveData:context];
}

- (void) storyCountCheckOnLoad:(NSManagedObjectContext*)context
{
    [self storyCountCheck:self.managedObjectContext];
}

//
//
////////
#pragma mark - Main Data Loader
////////
//
//

- (NSArray*) myMainStoryLoader: (NSInteger)myCount withContext: (NSManagedObjectContext*)context
{
    [self storyCountCheck:context];
    
    NSArray* storyArray = [self storyList:context];
    
    if ([storyArray count] < 4){
        NSLog(@"error myMainStoryLoader");
        return nil;
    }

    Story* theStory01 = [storyArray firstObject];
    Story* theStory02 = [storyArray objectAtIndex:1];
    Story* theStory03 = [storyArray objectAtIndex:2];
    Story* theStory04 = [storyArray objectAtIndex:3];

    NSArray*storySentences01 = [self sentenceOrder:[theStory01.whatSentences allObjects]];
    NSArray*storySentences02 = [self sentenceOrder:[theStory02.whatSentences allObjects]];
    NSArray*storySentences03 = [self sentenceOrder:[theStory03.whatSentences allObjects]];
    NSArray*storySentences04 = [self sentenceOrder:[theStory04.whatSentences allObjects]];
    
    if ([storySentences01 count] < myCount) {
        myCount = 0;
    }
    
    Sentence *mySentence01 = [storySentences01 objectAtIndex:myCount];
    Sentence *mySentence02 = [storySentences02 objectAtIndex:myCount];
    Sentence *mySentence03 = [storySentences03 objectAtIndex:myCount];
    Sentence *mySentence04 = [storySentences04 objectAtIndex:myCount];
    
    NSString* myReading01 = [self sentenceForNameBiasStringUnwrap:mySentence01];
    NSString* myReading02 = [self sentenceForNameBiasStringUnwrap:mySentence02];
    NSString* myReading03 = [self sentenceForNameBiasStringUnwrap:mySentence03];
    NSString* myReading04 = [self sentenceForNameBiasStringUnwrap:mySentence04];

    NSString* myQuestion01 = [self sentenceForObjectTransformationToQuestionWithNameBias:mySentence01];
    NSString* myQuestion02 = [self sentenceForObjectTransformationToQuestionWithNameBias:mySentence02];
    NSString* myQuestion03 = [self sentenceForObjectTransformationToQuestionWithNameBias:mySentence03];
    NSString* myQuestion04 = [self sentenceForObjectTransformationToQuestionWithNameBias:mySentence04];
    
    NSString* myAnswer01 = [self sentenceForPronounBiasStringUnwrap:mySentence01];
    NSString* myAnswer02 = [self sentenceForPronounBiasStringUnwrap:mySentence02];
    NSString* myAnswer03 = [self sentenceForPronounBiasStringUnwrap:mySentence03];
    NSString* myAnswer04 = [self sentenceForPronounBiasStringUnwrap:mySentence04];

    NSArray*readingArray = @[myReading01,myReading02,myReading03,myReading04];
    NSArray*questionArray = @[myQuestion01,myQuestion02,myQuestion03,myQuestion04];
    NSArray*answerArray = @[myAnswer01,myAnswer02,myAnswer03,myAnswer04];
    
    // readingArray
    // questionArray
    // answerArray
    
    return @[readingArray,questionArray,answerArray];
}

@end
