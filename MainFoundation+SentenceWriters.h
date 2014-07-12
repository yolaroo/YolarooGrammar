//
//  MainFoundation+SentenceWriters.h
//  YolarooGrammar
//
//  Created by MGM on 4/27/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SentenceWriters)

- (NSString*) sentenceForBasicStringUnwrap: (Sentence*) mySentence;
- (NSString*) sentenceForNameBiasStringUnwrap: (Sentence*) mySentence;
- (NSString*) sentenceForPronounBiasStringUnwrap: (Sentence*) mySentence;

- (NSString*) sentenceForSubjectTransformationToQuestion: (Sentence*) mySentence;
- (NSString*) sentenceForObjectTransformationToQuestion: (Sentence*) mySentence;
- (NSString*) sentenceForObjectTransformationToQuestionWithNameBias: (Sentence*) mySentence;

@end
