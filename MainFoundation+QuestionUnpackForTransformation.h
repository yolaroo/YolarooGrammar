//
//  MainFoundation+QuestionUnpackFirstOrder.h
//  YolarooGrammar
//
//  Created by MGM on 4/27/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (QuestionUnpackForTransformation)

- (NSString*) subjectTransformationQuestionUnpack: (Sentence*) mySentence;

- (NSString*) objectTransformationQuestionUnpack: (Sentence*) mySentence;

- (NSString*) prepositionTransformationQuestionUnpack: (Sentence*) mySentence;

- (NSString*) verbPhraseSimpleUnpack: (Sentence*)mySentence;

@end
