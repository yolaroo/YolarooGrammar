//
//  MainFoundation+QuestionUnpackFirstOrder.m
//  YolarooGrammar
//
//  Created by MGM on 4/27/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+QuestionUnpackForTransformation.h"

@implementation MainFoundation (QuestionUnpackForTransformation)

#define DK 2
#define LOG if(DK == 1)

//
// verb
//

- (NSString*) verbPhraseSimpleUnpack: (Sentence*)mySentence
{
    NSArray*verbArray = [mySentence.whatSententialVerb allObjects];
    SententialVerb* myVerb = [verbArray firstObject];
   
    NSString* myString =  myVerb.whatVerbWord.simple;
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    return myString;
}


//
// object
//

- (NSString*) objectTransformationQuestionUnpack: (Sentence*) mySentence
{
    NSArray* myObjectArray = [mySentence.whatObject allObjects];
    ObjectPhrase* myObject = [myObjectArray firstObject];
    
    NSString* theQuestionForm;
    
    if ([myObject.whatProperties.isDate boolValue]) {
        theQuestionForm = @"When";
    }
    else if ([myObject.whatProperties.isLocation boolValue]) {
        theQuestionForm = @"Where";
    }
    else if ([myObject.whatProperties.isTime boolValue]) {
        theQuestionForm = @"When";
    }
    else {
        theQuestionForm = @"What";
    }
    return theQuestionForm;
}

//
// preposition
//

- (NSString*) prepositionTransformationQuestionUnpack: (Sentence*) mySentence
{
    NSArray* myPrepositionArray = [mySentence.whatPreposition allObjects];
    PrepositionalPhrase* myPreposition = [myPrepositionArray firstObject];
    
    NSString* theQuestionForm;
    
    if ([myPreposition.whatProperties.isDate boolValue]) {
        theQuestionForm = @"When";
    }
    else if ([myPreposition.whatProperties.isLocation boolValue]) {
        theQuestionForm = @"Where";
    }
    else if ([myPreposition.whatProperties.isTime boolValue]) {
        theQuestionForm = @"When";
    }
    else {
        theQuestionForm = @"";
    }
    return theQuestionForm;
}

//
// subject
//

- (NSString*) subjectTransformationQuestionUnpack: (Sentence*) mySentence
{
    NSArray* mySubjectArray = [mySentence.whatSubject allObjects];
    SubjectPhrase* mySubject = [mySubjectArray firstObject];
    
    NSArray*AdjectiveArray = [mySubject.whatAdjective allObjects];
    SententialAdjective* myAdjective = [AdjectiveArray firstObject];
    
    NSString*theDeterminer;
    if ([mySubject.whatDeterminer.theDeterminer length]){
        LOG NSLog(@"--Info: %@ --",mySubject.whatDeterminer.theDeterminer);
        theDeterminer = mySubject.whatDeterminer.theDeterminer;
    }
    else {
        theDeterminer = @"";
    }
    
    NSString*theAdjective;
    if ([myAdjective.theAdjective length]) {
        LOG NSLog(@"--Info: %@ --",myAdjective.theAdjective);
        theAdjective = myAdjective.theAdjective;
    }
    else {
        theAdjective = @"";
    }
    
    NSString*theWord;
    if ([mySubject.theWord length]){
        LOG NSLog(@"--Info: %@ --",mySubject.theWord);
        theWord = mySubject.theWord;
    }
    else {
        theWord = @"";
    }
    
    NSString* myString;
    if ([mySubject.whatProperties.hasPossesive boolValue]){
        myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"Whose %@ %@",theAdjective,theWord] withCaps: false];
    }
    else {
        myString = @"Who";
    }
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    return [myString copy];
}


@end
