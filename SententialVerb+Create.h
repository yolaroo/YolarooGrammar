//
//  Verb+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SententialVerb.h"

@interface SententialVerb (Create)

+ (SententialVerb*) createSententialVerbForSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext* ) context;

@end
