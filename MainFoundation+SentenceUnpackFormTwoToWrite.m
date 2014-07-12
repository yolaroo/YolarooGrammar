//
//  MainFoundation+SentenceUnpackFormTwoToWrite.m
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SentenceUnpackFormTwoToWrite.h"

@implementation MainFoundation (SentenceUnpackFormTwoToWrite)

#define DK 2
#define LOG if(DK == 1)

- (NSString*) subjectPhraseWithNameBiasUnpack: (Sentence*) mySentence
{
    //bool isPossesive;
    
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
    
    NSArray* wordObjectArray = [mySubject.whatWord allObjects];
    Word* theWordObject = [wordObjectArray firstObject];
    NSString* theWordObjectString;
    if ([theWordObject.english length]) {
        theWordObjectString = theWordObject.english;
    }
    else {
        theWordObjectString = @"";
    }
    
    NSString*theCharacterName;
    if ([mySentence.characterName length]) {
        theCharacterName = mySentence.characterName;
    }
    else {
        theCharacterName = @"It";
    }
    LOG NSLog(@"0.1(DI): - (-det %@)",theDeterminer);

    if (mySubject.whatProperties.hasPossesive && [mySubject.whatDeterminer.theDeterminer length] && ![mySubject.whatDeterminer.theDeterminer isEqualToString:@" "]) {
        LOG NSLog(@"0.2(DI): - (-det %@) %@",theDeterminer,theWord);
        theDeterminer = [NSString stringWithFormat:@"%@'s",theCharacterName];
    }
    
    NSString* myString;
    if ([mySentence.isDirectIdentity boolValue]){
        myString= [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@",theCharacterName] withCaps: false];
    }
    else {
        myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",theDeterminer,theAdjective,theWord] withCaps: false];
    }
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    if ([mySubject.whatProperties.hasPossesive boolValue]){
        LOG NSLog(@"yes poss");
    }
    else {
        LOG NSLog(@"no poss");
    }
    
    return [myString copy];
}

- (NSString*) subjectPhraseWithPronounBiasUnpack: (Sentence*) mySentence
{

    NSArray* mySubjectArray = [mySentence.whatSubject allObjects];
    SubjectPhrase* mySubject = [mySubjectArray firstObject];
    NSString* myPronoun;
    
    if ([mySentence.isDirectIdentity boolValue]){

        if ([mySentence.characterGender isEqualToString:@"male"] || [mySentence.characterGender isEqualToString:@"boy"] ) {
            myPronoun = @"he";
        }
        else if ([mySentence.characterGender isEqualToString:@"female"] || [mySentence.characterGender isEqualToString:@"girl"]) {
            myPronoun = @"she";
        }
        else {
            myPronoun = @"it";
        }
    }
    else {
        myPronoun = mySubject.thePronoun;
    }
    
    NSString* myString;
    if ([mySubject.thePronoun length]){
        myString= [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@",myPronoun] withCaps: false];
    }
    else {
        NSLog(@"error ^^");
    }
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    return [myString copy];
}

@end
