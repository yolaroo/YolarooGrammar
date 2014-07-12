//
//  MainFoundation+SubjectDefine.h
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SubjectDefine)

- (SubjectPhrase*) makeSubjectPhrase: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withDefinition: (SubjectDefine) mySubjectDefinition withContext: (NSManagedObjectContext*) context;

@end
