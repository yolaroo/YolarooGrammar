//
//  MainFoundation+SentenceCreation.h
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SentenceCreation)

- (Sentence*) writeSentence: (Character*) theCharacter withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext*) context;

@end
