//
//  MainFoundation+SentenceWriters.m
//  YolarooGrammar
//
//  Created by MGM on 4/27/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SentenceWriters.h"

#import "MainFoundation+SentenceUnpackToWrite.h"
#import "MainFoundation+QuestionUnpackForTransformation.h"

#import "MainFoundation+SentenceUnpackFormTwoToWrite.h"

@implementation MainFoundation (SentenceWriters)

#define DK 2
#define LOG if(DK == 1)

//
// Normal Sentence
//

- (NSString*) sentenceForBasicStringUnwrap: (Sentence*) mySentence
{
    NSString*subject = [self subjectPhraseUnpack:mySentence];
    NSString*verb = [self verbPhraseUnpack:mySentence];
    NSString*object = [self finalObjectUnpack:mySentence];
    NSString*preposition = [self prepositionPhraseUnpack:mySentence];
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@",subject,verb,object,preposition] withCaps: true];
    
    return myString;
}

- (NSString*) sentenceForNameBiasStringUnwrap: (Sentence*) mySentence
{
    NSString*subject = [self subjectPhraseWithNameBiasUnpack:mySentence];
    NSString*verb = [self verbPhraseUnpack:mySentence];
    NSString*object = [self finalObjectUnpack:mySentence];
    NSString*preposition = [self prepositionPhraseUnpack:mySentence];
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@",subject,verb,object,preposition] withCaps: true];
    
    return myString;
}

- (NSString*) sentenceForPronounBiasStringUnwrap: (Sentence*) mySentence
{
    NSString*subject = [self subjectPhraseWithPronounBiasUnpack:mySentence];
    NSString*verb = [self verbPhraseUnpack:mySentence];
    NSString*object = [self finalObjectUnpack:mySentence];
    NSString*preposition = [self prepositionPhraseUnpack:mySentence];
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@",subject,verb,object,preposition] withCaps: true];
    
    return myString;
}

//
// Subject Generative Transformation
//

- (NSString*) sentenceForSubjectTransformationToQuestion: (Sentence*) mySentence
{
    NSString*subject = [self subjectTransformationQuestionUnpack:mySentence];
    NSString*verb = [self verbPhraseUnpack:mySentence];
    NSString*object = [self finalObjectUnpack:mySentence];
    NSString*preposition = [self prepositionPhraseUnpack:mySentence];
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@",subject,verb,object,preposition] withCaps: true];
    
    return myString;
}

//
// Object Generative Transformation
//

- (NSString*) sentenceForObjectTransformationToQuestion: (Sentence*) mySentence
{
    NSString*subject = [self subjectPhraseUnpack:mySentence];
    NSString*verb = [self verbPhraseUnpack:mySentence];
    NSString*verbSimple = [self verbPhraseSimpleUnpack:mySentence];
    NSString*object = [self objectTransformationQuestionUnpack:mySentence];
    NSString*preposition = [self prepositionTransformationQuestionUnpack:mySentence];
    
    LOG NSLog(@"-- (subject) %@ --",subject);
    LOG NSLog(@"-- (object) %@ --",object);

    NSString* myString;
    
    if ([mySentence.hasCopula boolValue]) {
        if([mySentence.hasObject boolValue]) {
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@",preposition,object,verb,subject] withCaps: true];
        }
        else{
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",preposition,verb,subject] withCaps: true];
        }
    }
    else {
        if([mySentence.hasObject boolValue]) {
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ does %@ %@",preposition,object,subject,verbSimple] withCaps: true];
        }
        else{
            NSLog(@"no object");
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",preposition,verb,subject] withCaps: true];
        }
    }
    return myString;
}

//
// Object Generative Transformation with name bias
//

- (NSString*) sentenceForObjectTransformationToQuestionWithNameBias: (Sentence*) mySentence
{
    NSString*subject = [self subjectPhraseWithNameBiasUnpack:mySentence];
    NSString*verb = [self verbPhraseUnpack:mySentence];
    NSString*verbSimple = [self verbPhraseSimpleUnpack:mySentence];
    NSString*object = [self objectTransformationQuestionUnpack:mySentence];
    NSString*preposition = [self prepositionTransformationQuestionUnpack:mySentence];
    
    LOG NSLog(@"-- (subject) %@ --",subject);
    LOG NSLog(@"-- (object) %@ --",object);
    
    NSString* myString;
    
    if ([mySentence.hasCopula boolValue]) {
        if([mySentence.hasObject boolValue]) {
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@",preposition,object,verb,subject] withCaps: true];
        }
        else{
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",preposition,verb,subject] withCaps: true];
        }
    }
    else {
        if([mySentence.hasObject boolValue]) {
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ does %@ %@",preposition,object,subject,verbSimple] withCaps: true];
        }
        else{
           LOG NSLog(@"no object");
            myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",preposition,verb,subject] withCaps: true];
        }
    }
    return myString;
}

@end
