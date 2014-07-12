//
//  MainFoundation+MultiObjectDefine.h
//  YolarooGrammar
//
//  Created by MGM on 5/2/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (MultiObjectDefine)

- (ObjectPhrase*) makeObjectPhraseMXO: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withObjectNumber: (NSInteger) theObjectCount withObjectArray: (NSArray*)theInitialObjectArray  withContext: (NSManagedObjectContext*) context;

@end
