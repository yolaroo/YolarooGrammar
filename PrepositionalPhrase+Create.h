//
//  PrepositionalPhrase+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "PrepositionalPhrase.h"

@interface PrepositionalPhrase (Create)

+ (PrepositionalPhrase*) createPrepositionalPhrase: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext* ) context;

+ (PrepositionalPhrase*) createEmptyPrepositionalPhrase: (NSManagedObjectContext* ) context;


@end
