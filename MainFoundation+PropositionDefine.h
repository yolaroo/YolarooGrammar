//
//  MainFoundation+PropositionDefine.h
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (PropositionDefine)

- (PrepositionalPhrase*) makePrepositionalPhrase: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext*) context;

@end
