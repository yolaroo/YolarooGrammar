//
//  MainFoundation+StoryQuestionUtilities.m
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+StoryQuestionUtilities.h"

#import "MainFoundation+StorySearch.h"

@implementation MainFoundation (StoryQuestionUtilities)

//
//// fetch
//

- (NSArray*) storyList: (NSManagedObjectContext*)context
{
    NSArray*myStoryArray;
    @try {
        myStoryArray = [[self completeStoryList:context]copy];
    }
    @catch (NSException *exception) {
        NSLog(@"(exception) %@)",exception);
    }
    return myStoryArray;
}

//
//// sentence order
//

- (NSArray*) sentenceOrder: (NSArray*)sentenceArrayInput
{
    NSMutableArray* sentenceArrayOutput = [[NSMutableArray alloc]initWithCapacity:[sentenceArrayInput count]];
    for (int i = 0; i < [sentenceArrayInput count]; i++) {
        for (int j = 0; j < [sentenceArrayInput count]; j++) {
            Sentence *mySentence = [sentenceArrayInput objectAtIndex:j];
            if ([mySentence.displayOrder integerValue] == i) {
                [sentenceArrayOutput addObject:mySentence];
            }
        }
    }
    return [sentenceArrayOutput copy];
}

@end
