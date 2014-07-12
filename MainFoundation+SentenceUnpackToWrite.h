//
//  MainFoundation+SentenceUnpackToWrite.h
//  YolarooGrammar
//
//  Created by MGM on 4/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SentenceUnpackToWrite)


- (NSString*) subjectPhraseUnpack: (Sentence*) mySentence;
- (NSString*) verbPhraseUnpack: (Sentence*)mySentence;

- (NSString*) prepositionPhraseUnpack: (Sentence*) mySentence;


- (NSString*) finalObjectUnpack:(Sentence*) mySentence;


@end

