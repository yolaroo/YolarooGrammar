//
//  SententialAdjective+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SententialAdjective.h"

@interface SententialAdjective (Create)

+ (SententialAdjective*) createSententialAdjective: (NSString*) theString withAdjectiveClass: (AdjectiveClass*) theAdjectiveObject withContext: (NSManagedObjectContext* ) context;

+ (SententialAdjective *) createRandomColorForSentence:(NSManagedObjectContext *) context;

+ (SententialAdjective*) createEmptySententialAdjective: (NSManagedObjectContext* ) context;

+ (SententialAdjective*) emptySententialAdjectiveFetch:(NSManagedObjectContext*) newContext;


@end
