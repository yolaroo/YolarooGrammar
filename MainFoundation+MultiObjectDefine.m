//
//  MainFoundation+MultiObjectDefine.m
//  YolarooGrammar
//
//  Created by MGM on 5/2/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+MultiObjectDefine.h"

#import "MainFoundation+SentenceUtility.h"
#import "Word+Create.h"

@implementation MainFoundation (MultiObjectDefine)

#define DK 2
#define LOG if(DK == 1)

- (ObjectPhrase*) makeObjectPhraseMXO: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withObjectNumber: (NSInteger) theObjectCount withObjectArray: (NSArray*) theInitialObjectArray  withContext: (NSManagedObjectContext*) context
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
    // Redefintion of object
    //
    ObjectDefine myObjectDefinition;
    
    if ([[theInitialObjectArray objectAtIndex:theObjectCount] isKindOfClass:[NSSet class]]) {
        myObjectDefinition = kObjectIsSet;
    }
    else if ([[theInitialObjectArray objectAtIndex:theObjectCount] isKindOfClass:[NSString class]]) {
        myObjectDefinition = kObjectIsString;
    }
    else if ([[theInitialObjectArray objectAtIndex:theObjectCount] isKindOfClass:[NSManagedObject class]]) {
        myObjectDefinition = kObjectIsObject;
    }
    else {
        myObjectDefinition = kObjectIsEmpty;
    }
    
    //
    // word tests
    //
    
    objectIsAdjective = [self isAdjectiveTest:dictionary withType:@"object"];
    objectIsNumber = [self isNumberTest:dictionary withType:@"object"];
    
    //
    // the word string
    //
    NSMutableString*tempString = [@"taco" mutableCopy];
    if (myObjectDefinition == kObjectIsEmpty) {
    }
    else if  (myObjectDefinition == kObjectIsSet) {
        //error
    }
    else if (myObjectDefinition == kObjectIsString) {
        tempString = [[theInitialObjectArray objectAtIndex:theObjectCount] mutableCopy];
    }
    else if (myObjectDefinition == kObjectIsObject) {
        if  ([dictionary objectForKey:@"object_type"]) {
            tempString = [[self stringForMultiObjectWithArray:theInitialObjectArray withObjectNumber:theObjectCount withType:[dictionary objectForKey:@"object_type"]] mutableCopy];
        }
        else {
            tempString = [[[theInitialObjectArray objectAtIndex:theObjectCount] name]mutableCopy];
        }
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
            if ([[[[dictionary objectForKey:@"object_infinitive"] allObjects]objectAtIndex:theObjectCount] respondsToSelector:@selector(infinitive)]){
                theObjectInfinitive = [ [[[dictionary objectForKey:@"object_infinitive"] allObjects]objectAtIndex:theObjectCount] infinitive];
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
    // determiner
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
        if (!objectIsAdjective){
            theObjectDeterminer = [self setDefaultDeterminer:theObjectWord];
        }
    }
    
    thePossesiveObject = [self setDeterminer:theCharacter withWord:theObjectWord withType:@"possesive"];
    LOG NSLog(@"-- %@ --",thePossesiveObject);
    
    LOG NSLog(@"4x - Object Infinitive and Determiner");
    
    Determiner* objectDeterminerObject = [Determiner createDeterminer:theObjectDeterminer withContext:context];
    
    //
    // Adjective
    //
    
    AdjectiveClass*theObjectAdjectiveClass = nil;
    if ([dictionary objectForKey:@"object_adjective"]) {
        theObjectAdjective = [dictionary objectForKey:@"object_adjective"];
        objectHasAdjective = true;
        theObjectAdjectiveClass = [self adjectiveObjectFromName:[dictionary objectForKey:@"object_adjective"] withContext:context];
    }
    
    LOG NSLog(@"-- 4.5x - Object Adjective %@ --",theObjectAdjective);
    
    SententialAdjective* objectAdjectiveObject = [SententialAdjective createSententialAdjective:theObjectAdjective withAdjectiveClass:theObjectAdjectiveClass withContext:context];
    
    LOG (objectDeterminerObject == nil) ? NSLog(@"nil det") : NSLog(@"yes det");
    LOG (objectAdjectiveObject == nil) ? NSLog(@"nil adj") : NSLog(@"yes adj");
    
    LOG NSLog(@"5x - Object PRE-Dictionary");
    NSDictionary* objectDictionary;
    if (theObjectWord == nil && objectAdjectiveObject == nil) {
        LOG NSLog(@"-- EMPTY dictionary: no object and no adjective-- ");
        objectDictionary = @{ @"word":theObject,
                              @"isNumber":[NSNumber numberWithBool:objectIsNumber],
                              };
    }
    else if (theObjectWord == nil && objectAdjectiveObject != nil) {
        LOG NSLog(@"-- dictionary: adjective --");
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
        LOG NSLog(@"-- dictionary: full object --");
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
    
    LOG NSLog(@"5xy - Object POST-Dictionary");
    
    //
    // make object phrase
    //
    
    ObjectPhrase* theObjectPhrase = [ObjectPhrase createObject:theSentence withDictionary:objectDictionary withContext:context ];
    
    LOG NSLog(@"6x - Object phrase");
    
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
    
    LOG NSLog(@"7x - Object properties");
    
    NounProperties* objectNounProperties = [NounProperties createNounPropertiesForObject:theObjectPhrase withDictionary:objectPropertyDictionary withContext:context];
    objectNounProperties.name = tempString;
    LOG NSLog(@"8x - Object noun properties");
    
    theObjectPhrase.whatProperties = objectNounProperties;
    
    NSString*completeObjectPhraseString = [self sentenceSpaceFixer:[NSString stringWithFormat:@"%@ %@ %@ %@%@",theObjectInfinitive,theObjectDeterminer,theObjectAdjective,theObject,theObjectSuffix] withCaps: false];
    theObjectPhrase.theObjectPhrase = completeObjectPhraseString;
    
    LOG NSLog(@"9x - Object make string");
    LOG NSLog(@"Object Phrase - %@",completeObjectPhraseString);
    
    return theObjectPhrase;
}

@end
