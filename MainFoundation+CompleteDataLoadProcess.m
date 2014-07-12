//
//  MainFoundation+CompleteDataLoadProcess.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+CompleteDataLoadProcess.h"

#import "MainFoundation+AddWordDataToCoreData.h"
#import "MainFoundation+VerbDataLoad.h"
#import "MainFoundation+AdjectiveDataLoad.h"
#import "MainFoundation+AddExtraDataToWordList.h"
#import "MainFoundation+SynonymDataLoad.h"

#import "Determiner+Create.h"
#import "SententialAdjective+Create.h"
#import "Word+Create.h"

#import "MainFoundation+GrammarDataLoad.h"

@implementation MainFoundation (CompleteDataLoadProcess)

- (void) completeDataLoadForCoreData:(NSManagedObjectContext*)context
{    
    [self grammarDataLoaderIntoNSManagedObjectContext:context];
    [self loadMyWordsIntoNSManagedObjectContext:context];

    [self verbDataLoaderIntoNSManagedObjectContext:context];
    [self adjectiveDataLoaderIntoNSManagedObjectContext:context];

    [self newAddExtraWordData:context];
    
    [self synonymDataLoaderIntoNSManagedObjectContext:context];
    
    [self smallSetOfSententialObjects:context];
    
    [self saveData:context];
    
    NSLog(@"Main Loaded");

}

- (void) smallSetOfSententialObjects :(NSManagedObjectContext*)context
{
    [Determiner createEmptyDeterminer:context];
    [SententialAdjective createEmptySententialAdjective:context];
    [Word wordCreateThatIsEmpty:context];

}


@end
