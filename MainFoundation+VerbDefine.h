//
//  MainFoundation+VerbDefine.h
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (VerbDefine)

- (SententialVerb*) makeVerbPhrase: (Character*) theCharacter withSubjectPhrase: (SubjectPhrase*) theSubjectPhrase withSentence: (Sentence*) theSentence withDefinition: (VerbDefine) myVerbDefinition withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext*) context;

@end
