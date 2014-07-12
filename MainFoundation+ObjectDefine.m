//
//  MainFoundation+ObjectDefine.m
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+ObjectDefine.h"
#import "MainFoundation+SentenceUtility.h"
#import "Word+Create.h"
#import "Determiner+Create.h"

@implementation MainFoundation (ObjectDefine)

#define DK 2
#define LOG if(DK == 1)

- (ObjectPhrase*) makeObjectPhrase: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withDefinition: (ObjectDefine) myObjectDefinition withContext: (NSManagedObjectContext*) context
{
    BOOL isObjectplural = false;
    BOOL objectHasPronoun = false;
    BOOL objectHasPossesive = false;
    BOOL objectIsAdjective = false;
    BOOL objectHasAdjective = false;
    BOOL objectIsNumber = false;
    BOOL objectIsGeneralization = false;
    BOOL objectIsDate = false;
    BOOL objectIsLocation = false;
    BOOL objectIsTime = false;
    BOOL objectHasSuffix = false;

    NSString* theObject = @"";
    NSString* theObjectInfinitive = @"";
    NSString* theObjectDeterminer = @"";
    NSString* theObjectAdjective = @"";
    NSString* theObjectSuffix = @"";
    NSString* thePossesiveObject = @"";
    
    //
    // word tests
    //
    
    objectIsAdjective = [self isAdjectiveTest:dictionary withType:@"object"];
    objectIsNumber = [self isNumberTest:dictionary withType:@"object"];
    
    //
    // string
    //

    NSMutableString*tempString = [@"taco" mutableCopy];
    if (myObjectDefinition == kObjectIsEmpty) {
    }
    else if (myObjectDefinition == kObjectIsSet) {
        if([dictionary objectForKey:@"object_type"]){
            tempString = [[self stringFromDictionaryWithArray:dictionary withKey:@"object" withType:[dictionary objectForKey:@"object_type"]]mutableCopy];
        }
        else {
            tempString = [[self stringFromDictionaryWithArray:dictionary withKey:@"object" withType:@"name"]mutableCopy];
        }
    }
    else if (myObjectDefinition == kObjectIsString) {
        tempString = [[dictionary objectForKey:@"object"]mutableCopy];
    }
    else if (myObjectDefinition == kObjectIsObject) {
        tempString = [[[dictionary objectForKey:@"object"] name]mutableCopy];
    }
    else {
        //error
    }
    
    //
    // word tests
    //
    
    objectIsNumber = [self canConvertToNumber:tempString];

    //
    // word object
    //
    
    Word*theObjectWord;
    if ([tempString length] && !objectIsNumber){
        theObjectWord = [self wordObjectFromName:[tempString copy] withContext:context];
    }
    else {
        theObjectWord = [Word emptyWordFetch:context];
    }
    
    if ([theObjectWord.english isEqualToString:@"number"]) {
        theObjectWord.isNumber = [NSNumber numberWithBool:TRUE];
        objectIsNumber = true;
    }

    if (objectIsAdjective){
        AdjectiveClass*theAdjectiveClass;
        theAdjectiveClass = [self adjectiveObjectFromName:[tempString copy] withContext:context];
        if (theAdjectiveClass == nil) {
            theObjectWord = [Word wordWithNameFromNil:[tempString copy] withContext:context];
        }
        else {
            objectIsAdjective = true;
        }
    }
    
    //
    // type
    //
    
    if([theObjectWord.whatSyntacticType.name length]){
        if([theObjectWord.whatSyntacticType.name isEqualToString:@"location"]) {
            objectIsLocation = true;
        }
        else if([theObjectWord.whatSyntacticType.name isEqualToString:@"time"]) {
            objectIsTime = true;
        }
    }
    
    //
    // Is Date
    //
    
    objectIsDate = [self isDateTest:dictionary withType:@"object"];
    
    if ([self isItDate:tempString]){
        objectIsDate = true;
    }
    
    //
    // plural
    //
    
    if ([theObjectWord.isPlural boolValue]){
        isObjectplural = true;
    }
    
    //
    // pronoun
    //
    
    if ([dictionary objectForKey:@"object_pronoun"]) {
        theObject = [self setPronounObject: theObjectWord];
        objectHasPronoun = true;
    }
    else {
        theObject = [tempString copy];
    }
    
    //
    // infinitive
    //

    if ([dictionary objectForKey:@"object_infinitive"]){
        if ([[dictionary objectForKey:@"object_infinitive"] isKindOfClass:[NSSet class]]) {
            if ([[[[dictionary objectForKey:@"object_infinitive"] allObjects]firstObject] respondsToSelector:@selector(infinitive)]){
                theObjectInfinitive = [ [[[dictionary objectForKey:@"object_infinitive"] allObjects]firstObject] infinitive];
            }
        }
        else if ([[dictionary objectForKey:@"object_infinitive"] isKindOfClass:[NSString class]]) {
            theObjectInfinitive  = [dictionary objectForKey:@"object_infinitive"];
        }
        else if ([[dictionary objectForKey:@"object_infinitive"] isKindOfClass:[NSManagedObject class]]) {
            if ([[dictionary objectForKey:@"object_infinitive"] respondsToSelector:@selector(infinitive)]){
                theObjectInfinitive = [[dictionary objectForKey:@"object_infinitive"] infinitive];
            }
        }
        else {
            NSLog(@"infinitive error");
        }
    }
    
    //
    // determiner string
    //
    
    if ([dictionary objectForKey:@"object_determiner"]) {
        theObjectDeterminer = [self setDeterminer:theCharacter withWord:theObjectWord withType:[dictionary objectForKey:@"object_determiner"]];
        if ([[dictionary objectForKey:@"object_determiner"] isEqualToString:@"possesive"]) objectHasPossesive = true;
        if ([[dictionary objectForKey:@"object_determiner"] isEqualToString:@"generalization"]) objectIsGeneralization = true;
        if (objectIsGeneralization && ![theObjectWord.isPlural boolValue] && ![theObjectWord.isUncountable boolValue]) {
            objectHasSuffix = true;
            theObject = [self sentenceSuffixCheck:theObject];
        }
    }
    else {
        if (!objectIsAdjective && ![theObjectWord.isNumber boolValue] && !objectIsNumber && !objectIsTime && !objectIsDate && !objectIsAdjective){
            theObjectDeterminer = [self setDefaultDeterminer:theObjectWord];
        }
    }
    
    //
    //// set possesive object
    //
    
    thePossesiveObject = [self setDeterminer:theCharacter withWord:theObjectWord withType:@"possesive"];
    
    //
    //// determiner object
    //
    
    Determiner* objectDeterminerObject;
    if ([theObject length]){
        objectDeterminerObject = [Determiner createDeterminer:theObjectDeterminer withContext:context];
    }
    else {
        objectDeterminerObject = [Determiner emptyDeterminerFetch: context];
    }
    
    //
    // Adjective
    //

    AdjectiveClass*theObjectAdjectiveClass = nil;
    if ([dictionary objectForKey:@"object_adjective"]) {
        theObjectAdjective = [dictionary objectForKey:@"object_adjective"];
        objectHasAdjective = true;
        theObjectAdjectiveClass = [self adjectiveObjectFromName:[dictionary objectForKey:@"object_adjective"] withContext:context];
    }
    
    SententialAdjective* objectAdjectiveObject;
    if (objectHasAdjective) {
        objectAdjectiveObject = [SententialAdjective createSententialAdjective:theObjectAdjective withAdjectiveClass:theObjectAdjectiveClass withContext:context];
    }
    else {
        objectAdjectiveObject = [SententialAdjective emptySententialAdjectiveFetch:context];
    }
    
    //
    // property define
    //
    
    NSDictionary* objectDictionary;
    if (theObjectWord == nil && objectAdjectiveObject == nil) {
        objectDictionary = @{ @"word":theObject,
                              @"isNumber":[NSNumber numberWithBool:objectIsNumber],
                            };
    }
    else if (theObjectWord == nil && objectAdjectiveObject != nil) {
        objectDictionary = @{   @"word":theObject,
                                @"determiner":objectDeterminerObject,
                                @"adjective":objectAdjectiveObject,
                                @"word_infinitive":theObjectInfinitive,
                                @"isAnAdjective":[NSNumber numberWithBool:objectIsAdjective],
                                @"possesive_object":thePossesiveObject,
                                @"isNumber":[NSNumber numberWithBool:objectIsNumber],
                                };
    }
    else {
        objectDictionary = @{ @"word":theObject,
                              @"determiner":objectDeterminerObject,
                              @"adjective":objectAdjectiveObject,
                              @"word_object":theObjectWord,
                              @"word_infinitive":theObjectInfinitive,
                              @"isAnAdjective":[NSNumber numberWithBool:objectIsAdjective],
                              @"possesive_object":thePossesiveObject,
                              @"isNumber":[NSNumber numberWithBool:objectIsNumber],
                              };
    }
    
    //
    // make object phrase
    //
    
    ObjectPhrase* theObjectPhrase = [ObjectPhrase createObject:theSentence withDictionary:objectDictionary withContext:context ];
    
    NSDictionary* objectPropertyDictionary = @{ @"isPlural":[NSNumber numberWithBool:isObjectplural],
                                                @"hasPossesive": [NSNumber numberWithBool:objectHasPossesive],
                                                @"hasAdjective":[NSNumber numberWithBool:objectHasAdjective],
                                                @"hasPronoun":[NSNumber numberWithBool:objectHasPronoun],
                                                @"isGeneralization":[NSNumber numberWithBool:objectIsGeneralization],
                                                @"objectIsDate":[NSNumber numberWithBool:objectIsDate],
                                                @"objectIsLocation":[NSNumber numberWithBool:objectIsLocation],
                                                @"objectIsTime":[NSNumber numberWithBool:objectIsTime],
                                                @"objectHasSuffix":[NSNumber numberWithBool:objectHasSuffix],
                                                };
    
    NounProperties* objectNounProperties = [NounProperties createNounPropertiesForObject:theObjectPhrase withDictionary:objectPropertyDictionary withContext:context];
    objectNounProperties.name = tempString;
    
    theObjectPhrase.whatProperties = objectNounProperties;
    
    //
    //// write string
    //
    
    NSString*completeObjectPhraseString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@%@",theObjectInfinitive,theObjectDeterminer,theObjectAdjective,theObject,theObjectSuffix] withCaps: false];
    theObjectPhrase.theObjectPhrase = completeObjectPhraseString;
    
    return theObjectPhrase;
}



@end
