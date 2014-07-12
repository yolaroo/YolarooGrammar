//
//  MainFoundation+SubjectDefine.m
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SubjectDefine.h"
#import "MainFoundation+SentenceUtility.h"
#import "Word+Create.h"

@implementation MainFoundation (SubjectDefine)

#define DK 2
#define LOG if(DK == 1)

- (SubjectPhrase*) makeSubjectPhrase: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withDefinition: (SubjectDefine) mySubjectDefinition withContext: (NSManagedObjectContext*) context
{
    BOOL isSubjectplural = false;
    BOOL subjectHasPronoun = false;
    BOOL subjectHasPossesive = false;
    BOOL subjectHasAdjective = false;
    BOOL subjectIsDate = false;
    BOOL subjectIsLocation = false;
    BOOL subjectIsTime = false;
    BOOL subjectHasSuffix = false;
    BOOL subjectIsAdjective = false;
    BOOL subjectIsNumber = false;
    BOOL subjectNeedsPossessive = false;

    NSString* theSubject = @"";
    NSString* theSubjectDeterminer = @"";
    NSString* theSubjectAdjective = @"";
    NSString* myPronoun = @"";
    //NSString* theSubjectSuffix = @"";
    NSString* thePossesiveObject = @"";
    
    //
    // word tests
    //
    
    subjectIsAdjective = [self isAdjectiveTest:dictionary withType:@"object"];
    subjectIsNumber = [self isNumberTest:dictionary withType:@"object"];

    //
    // the word string
    //
    
    NSMutableString*tempString = [@"taco" mutableCopy];
    
    if (mySubjectDefinition == kSubjectIsEmpty) {
    }
    else if (mySubjectDefinition == kSubjectIsObject) {
        tempString = [[[dictionary objectForKey:@"subject"] metaType]mutableCopy];
    }
    else if (mySubjectDefinition == kSubjectIsSet) {
        if ([dictionary objectForKey:@"subject_type"]){
            tempString = [[self stringFromDictionaryWithArray:dictionary withKey:@"subject" withType:[dictionary objectForKey:@"subject_type"]]mutableCopy];
        }
        else {
            tempString = [[self stringFromDictionaryWithArray:dictionary withKey:@"subject" withType:@"metaType"]mutableCopy];
        }
    }
    else if (mySubjectDefinition == kSubjectIsString) {
        tempString = [[self stringFromDictionaryWithString:dictionary withKey:@"subject"]mutableCopy];
    }
    else {
        //error
    }
    
    if ([dictionary objectForKey:@"subject"] == theCharacter) {
        tempString = [theCharacter.name mutableCopy];
    }
    
    
    //
    //// equivalence test and need indirect to possesive determiner
    //
    
    if([theSentence.isAnthropomorphic boolValue] && ![tempString isEqualToString: theCharacter.name]) {
        subjectNeedsPossessive = true;
        LOG NSLog(@"%@",tempString);
    }
    
    
    //
    // word class
    //
    
    Word*theSubjectWord;
    theSubjectWord = [self wordObjectFromName:[tempString copy] withContext:context];
    
    if (theSubjectWord == nil){
        theSubjectWord = [Word wordWithNameFromNil:[tempString copy] withContext:context];
    }
    
    //
    // type
    //
    
    if([theSubjectWord.whatSyntacticType.name length]){
        if([theSubjectWord.whatSyntacticType.name isEqualToString:@"location"]) {
            subjectIsLocation = true;
        }
        else if([theSubjectWord.whatSyntacticType.name isEqualToString:@"time"]) {
            subjectIsTime = true;
        }
    }
    
    //
    // Is Date
    //
    
    if ([self isItDate:tempString]){
        subjectIsDate = true;
    }
    
    subjectIsDate = [self isDateTest:dictionary withType:@"subject"];

    //
    // plural
    //
    
    if ([dictionary objectForKey:@"subject"] == theCharacter || theCharacter.name){
        if ([theCharacter.isPlural boolValue]){
            isSubjectplural = true;
        }
    }
    else {
        if ([theSubjectWord.isPlural boolValue]){
            isSubjectplural = true;
        }
    }
    
    //
    // pronoun
    //
    
    if ([dictionary objectForKey:@"subject_pronoun"]) {
        subjectHasPronoun = true;
    }

    if ([dictionary objectForKey:@"subject"] == theCharacter.name || [dictionary objectForKey:@"subject"] == theCharacter){
        myPronoun = [self setPronounSubject:theCharacter];
    }
    else {
        if (isSubjectplural) {
            myPronoun = @"they";
        }
        else {
            myPronoun = @"it";
        }
    }

    //
    //write
    theSubject = tempString;
    //write
    //
    
    LOG NSLog(@"3 - subject pronoun - subject - %@",theSubject);
    
    //
    // determiner
    //
    
    if (subjectNeedsPossessive) {
        theSubjectDeterminer = [self setDeterminer:theCharacter withWord:theSubjectWord withType:@"possesive"];
        subjectHasPossesive = true;
    }
    else {
        theSubjectDeterminer = [self setDefaultDeterminer:theSubjectWord];
    }
    
    thePossesiveObject = [self setDeterminer:theCharacter withWord:theSubjectWord withType:@"possesive"];

    Determiner* subjectDeterminerObject = [Determiner createDeterminer:theSubjectDeterminer withContext:context];
    
    //
    // Adjective
    //
    
    AdjectiveClass*theSubjectAdjectiveClass = nil;
    if ([dictionary objectForKey:@"subject_adjective"]) {
        theSubjectAdjective = [dictionary objectForKey:@"subject_adjective"];
        subjectHasAdjective = true;
        theSubjectAdjectiveClass = [self adjectiveObjectFromName:[dictionary objectForKey:@"subject_adjective"] withContext:context];
    }
    
    SententialAdjective* subjectAdjectiveObject = [SententialAdjective createSententialAdjective:theSubjectAdjective withAdjectiveClass: theSubjectAdjectiveClass withContext:context];
    
    //
    // phrase
    //
    
    NSDictionary* subjectDictionary;
    
    if (theSubjectWord == nil){
        subjectDictionary = @{@"word":theSubject,
                              @"determiner":subjectDeterminerObject,
                              @"adjective":subjectAdjectiveObject,
                              @"pronoun":myPronoun,
                              @"possesive_object":thePossesiveObject,
                              };
    }
    else {
        subjectDictionary = @{@"word":theSubject,
                              @"determiner":subjectDeterminerObject,
                              @"adjective":subjectAdjectiveObject,
                              @"word_object":theSubjectWord,
                              @"pronoun":myPronoun,
                              @"possesive_object":thePossesiveObject,
                              };
    }
    
   
    SubjectPhrase*theSubjectPhrase = [SubjectPhrase createSubject:theSentence withDictionary:subjectDictionary withContext:context];
    
    //
    // properties
    //
    
    NSDictionary* subjectPropertyDictionary = @{@"isPlural":[NSNumber numberWithBool:isSubjectplural],
                                                @"hasPossesive":[NSNumber numberWithBool:subjectHasPossesive],
                                                @"hasAdjective":[NSNumber numberWithBool:subjectHasAdjective],
                                                @"hasPronoun":[NSNumber numberWithBool:subjectHasPronoun],
                                                @"subjectIsDate":[NSNumber numberWithBool:subjectIsDate],
                                                @"subjectIsLocation":[NSNumber numberWithBool:subjectIsLocation],
                                                @"subjectIsTime":[NSNumber numberWithBool:subjectIsTime],
                                                @"subjectHasSuffix":[NSNumber numberWithBool:subjectHasSuffix],
                                                };
    
    NounProperties* subjectNounProperties = [NounProperties createNounPropertiesForSubject:theSubjectPhrase withDictionary:subjectPropertyDictionary withContext:context];
    subjectNounProperties.name = tempString;
    
    theSubjectPhrase.whatProperties = subjectNounProperties;

    //
    // make string
    //
    
    NSString*completeSubjectPhraseString;
    if (subjectHasPronoun){
        completeSubjectPhraseString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@",myPronoun] withCaps: false];
    }
    else {
         completeSubjectPhraseString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@",theSubjectDeterminer,theSubjectAdjective,theSubject] withCaps: false];
    }
    
    theSubjectPhrase.theSubjectPhrase = completeSubjectPhraseString;
        
    return theSubjectPhrase;
}

@end
