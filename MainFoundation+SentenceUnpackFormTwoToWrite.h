//
//  MainFoundation+SentenceUnpackFormTwoToWrite.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SentenceUnpackFormTwoToWrite)

- (NSString*) subjectPhraseWithNameBiasUnpack: (Sentence*) mySentence;
- (NSString*) subjectPhraseWithPronounBiasUnpack: (Sentence*) mySentence;


@end
