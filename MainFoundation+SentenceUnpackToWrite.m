//
//  MainFoundation+SentenceUnpackToWrite.m
//  YolarooGrammar
//
//  Created by MGM on 4/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SentenceUnpackToWrite.h"

@implementation MainFoundation (SentenceUnpackToWrite)

#define DK 2
#define LOG if(DK == 1)


//
// subject
//

- (NSString*) subjectPhraseUnpack: (Sentence*) mySentence
{
    NSArray* mySubjectArray = [mySentence.whatSubject allObjects];
    SubjectPhrase* mySubject = [mySubjectArray firstObject];
    
    NSArray*AdjectiveArray = [mySubject.whatAdjective allObjects];
    SententialAdjective* myAdjective = [AdjectiveArray firstObject];
    
    NSString*theDeterminer;
    if ([mySubject.whatDeterminer.theDeterminer length]){
        theDeterminer = mySubject.whatDeterminer.theDeterminer;
    }
    else {
        theDeterminer = @"";
    }
    
    NSString*theAdjective;
    if ([myAdjective.theAdjective length]) {
        theAdjective = myAdjective.theAdjective;
    }
    else {
        theAdjective = @"";
    }
    
    NSString*theWord;
    if ([mySubject.theWord length]){
        theWord = mySubject.theWord;
    }
    else {
        theWord = @"";
    }
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",theDeterminer,theAdjective,theWord] withCaps: false];
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    return [myString copy];
}

//
// verb
//

- (NSString*) verbPhraseUnpack: (Sentence*)mySentence
{
    NSArray*verbArray = [mySentence.whatSententialVerb allObjects];
    SententialVerb* myVerb = [verbArray firstObject];
    NSString* myString =  myVerb.theVerb;

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

- (NSString*) finalObjectUnpack:(Sentence*) mySentence
{
    NSArray* myObjectArray = [mySentence.whatObject allObjects];
    NSMutableString*object =[NSMutableString stringWithFormat:@""];
    bool firstObject = false;
    for (ObjectPhrase* myObject in myObjectArray) {
        if (!firstObject) {
            [object appendString:[[self objectPhraseMXOUnpack:myObject]copy]];
            firstObject = true;
        }
        else {
            [object appendString:@" and "];
            [object appendString:[[self objectPhraseMXOUnpack:myObject]copy]];
        }
    }
    return [object copy];
}

- (NSString*) objectPhraseMXOUnpack: (ObjectPhrase*) myObject
{

    NSArray*AdjectiveArray = [myObject.whatAdjective allObjects];
    SententialAdjective* myAdjective = [AdjectiveArray firstObject];
    
    NSString*theInfinitive;
    if ([myObject.theInfinitive length]){
        theInfinitive = myObject.theInfinitive;
    }
    else {
        theInfinitive = @"";
    }
    
    NSString*theDeterminer;
    if ([myObject.whatDeterminer.theDeterminer length]){
        LOG NSLog(@"--Info: %@ --",myObject.whatDeterminer.theDeterminer);
        theDeterminer = myObject.whatDeterminer.theDeterminer;
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
    if ([myObject.theWord length]){
        LOG NSLog(@"--Info: %@ --",myObject.theWord);
        theWord = myObject.theWord;
    }
    else {
        theWord = @"";
    }
    
    NSString*theSuffix = @"";
  /*
    if ([myObject.whatProperties.hasSuffix boolValue]) {
        if ([theWord hasSuffix:@"y"]) {
            theWord = [theWord substringToIndex:[theWord length] - 1];
            theWord = [NSString stringWithFormat:@"%@ie",theWord];
        }
        theSuffix = @"s";
    }
    else {
        theSuffix = @"";
    }
    */
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@%@",theInfinitive,theDeterminer,theAdjective,theWord,theSuffix] withCaps: false];
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    return [myString copy];
}

- (NSString*) objectPhraseUnpack: (Sentence*) mySentence
{
    NSArray* myObjectArray = [mySentence.whatObject allObjects];
    ObjectPhrase* myObject = [myObjectArray firstObject];
    
    NSArray*AdjectiveArray = [myObject.whatAdjective allObjects];
    SententialAdjective* myAdjective = [AdjectiveArray firstObject];
    
    NSString*theInfinitive;
    if ([myObject.theInfinitive length]){
        theInfinitive = myObject.theInfinitive;
    }
    else {
        theInfinitive = @"";
    }
    
    NSString*theDeterminer;
    if ([myObject.whatDeterminer.theDeterminer length]){
        LOG NSLog(@"--Info: %@ --",myObject.whatDeterminer.theDeterminer);
        theDeterminer = myObject.whatDeterminer.theDeterminer;
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
    if ([myObject.theWord length]){
        LOG NSLog(@"--Info: %@ --",myObject.theWord);
        theWord = myObject.theWord;
    }
    else {
        theWord = @"";
    }

    NSString*theSuffix = @"";
    /*
    if ([myObject.whatProperties.hasSuffix boolValue]) {
        if ([theWord hasSuffix:@"y"]) {
            theWord = [theWord substringToIndex:[theWord length] - 1];
            theWord = [NSString stringWithFormat:@"%@ie",theWord];
        }
        theSuffix = @"s";
    }
    else {
        theSuffix = @"";
    }
    */
    
    NSString* myString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@%@",theInfinitive,theDeterminer,theAdjective,theWord,theSuffix] withCaps: false];
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    
    return [myString copy];
}

//
// preposition
//

- (NSString*) prepositionPhraseUnpack: (Sentence*) mySentence
{
    NSArray*myPrepositionArray = [mySentence.whatPreposition allObjects];
    PrepositionalPhrase*myPreposition = [myPrepositionArray firstObject];
    NSString*myString = myPreposition.thePrepositionPhrase;
    
    if ([myString length]) {
    }
    else {
        myString = @"";
    }
    return myString;
}



@end
