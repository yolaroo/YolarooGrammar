//
//  MainFoundation+ObjectDefine.h
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (ObjectDefine)

- (ObjectPhrase*) makeObjectPhrase: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withDefinition: (ObjectDefine) myObjectDefinition withContext: (NSManagedObjectContext*) context;

@end
