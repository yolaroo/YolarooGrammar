//
//  MainFoundation+StoryReadingDataLoad.m
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+StoryReadingDataLoad.h"

#import "MainFoundation+StoryQuestionUtilities.h"
#import "MainFoundation+SentenceWriters.h"


@implementation MainFoundation (StoryReadingDataLoad)

#define DK 2
#define LOG if(DK == 1)

- (NSInteger) sentenceMax: (NSArray*) sentenceArray {
    if (![sentenceArray count]) return 0;
    if ([sentenceArray count] < 3) return 2;
    return [sentenceArray count];
}

//
//// main title load to view
//

- (NSString*) titleString: (Story*)myStory
{
    Character* myCharacter = [[myStory.whatCharacter allObjects]firstObject];
    NSString* name = myCharacter.name;
    NSString* disposition = ((Disposition*)[[myCharacter.whatDisposition allObjects]firstObject]).name;
    NSString* specie = myCharacter.whatSpecie.name;
    NSString* titleName = [NSString stringWithFormat:@"This is\n the story of\n%@\nthe %@\n%@",name,disposition,specie];
    return titleName;
}

//
//// main story array load to view
//

- (Story*) myStoryLoader: (NSInteger)myIndex withContext:(NSManagedObjectContext*)context
{
    NSArray* storyArray = [[self storyList:context]mutableCopy];
    if (![self myArrayIndexIsOk:myIndex withArray:storyArray]) return nil;
    return[storyArray objectAtIndex:myIndex];
}

- (NSInteger) myStoryIndexMax: (NSManagedObjectContext*)context
{
    return [[self storyList:context] count];
}

//
//// main sentence load to View
//

- (NSArray*) storySentencesDataLoad:(Story*)myStory withContext:(NSManagedObjectContext*)context
{
    NSArray* sentenceArray = [self sentenceOrder:[myStory.whatSentences allObjects]];
    return sentenceArray;
}

//
//// main per page string load to View
//

- (NSArray*) loadSentencesToString: (NSArray*) sentenceArray
{
    if (![sentenceArray count])return @[];
    
    NSMutableArray* stringArray = [[NSMutableArray alloc]init];
    NSInteger myCase = 0;
    for (Sentence* STN in sentenceArray){
        myCase = arc4random() % 4;
        switch (myCase) {
            case 0:
                [stringArray addObject:[self sentenceForBasicStringUnwrap:STN]];
                break;
            case 1:
                if ([self oneInTwo]){
                    if ([STN.isDirectIdentity boolValue]){
                        [stringArray addObject:[self sentenceForPronounBiasStringUnwrap:STN]];
                    }
                    else {
                        [stringArray addObject:[self sentenceForBasicStringUnwrap:STN]];
                    }
                }
                else {
                    [stringArray addObject:[self sentenceForNameBiasStringUnwrap:STN]];
                }
                break;
            case 2:
                if ([STN.isDirectIdentity boolValue]){
                    [stringArray addObject:[self sentenceForPronounBiasStringUnwrap:STN]];
                }
                else {
                    [stringArray addObject:[self sentenceForBasicStringUnwrap:STN]];
                }
                break;
            case 3:
                if ([STN.isDirectIdentity boolValue]){
                    [stringArray addObject:[self sentenceForPronounBiasStringUnwrap:STN]];
                }
                else {
                    [stringArray addObject:[self sentenceForBasicStringUnwrap:STN]];
                }
                break;
            default:
                [stringArray addObject:[self sentenceForBasicStringUnwrap:STN]];
                break;
        }
    }
    return [stringArray copy];
}


@end
