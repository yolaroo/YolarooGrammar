//
//  MainFoundation+PropositionDefine.m
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+PropositionDefine.h"

#import "MainFoundation+SentenceUtility.h"
#import "Word+Create.h"

@implementation MainFoundation (PropositionDefine)

#define DK 2
#define LOG if(DK == 1)

- (PrepositionalPhrase*) makePrepositionalPhrase: (Character*) theCharacter withSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext*) context
{
    PrepositionalPhrase* thePrepositionPhrase = nil;
    
    BOOL isPrepositionplural = false;
    BOOL prepositionHasPronoun = false;
    BOOL prepositionHasPossesive = false;
    BOOL prepositionHasAdjective = false;
    BOOL prepositionIsDate = false;
    BOOL prepositionIsLocation = false;
    BOOL prepositionIsTime = false;
    BOOL prepositionHasSuffix = false;
    
    NSString* thePreposition = @"";
    NSString* thePrepositionWord = @"";
    NSString* thePrepositionDeterminer = @"";
    NSString* thePrepositionAdjective = @"";
    NSString* thePrepositionInfinitive = @"";
    //NSString* thePrepositionSuffix = @"";
    NSString* thePossesiveObject = @"";

    LOG NSLog(@"Preposition - %@",[dictionary objectForKey:@"preposition_object"]);
    
    //
    // the word string
    //
    
    NSMutableString*tempString = [@"taco" mutableCopy];
    if ([[dictionary objectForKey:@"preposition_object"] isKindOfClass:[NSString class]]) {
        tempString = [[self stringFromDictionaryWithString:dictionary withKey:@"preposition_object"] mutableCopy];
    }
    else if ([[dictionary objectForKey:@"preposition_object"] isKindOfClass:[NSSet class]]) {
        if ([dictionary objectForKey:@"preposition_type"]){
        tempString = [[self stringFromDictionaryWithArray:dictionary withKey:@"preposition_object" withType:[dictionary objectForKey:@"preposition_type"]]mutableCopy];
        }
        else {
            tempString = [[self stringFromDictionaryWithArray:dictionary withKey:@"preposition_object" withType:@"name"]mutableCopy];
        }
    }
    else {
        LOG NSLog(@"preposition error");
    }
    
    //
    // word class
    //

    Word*thePrepositionWordObject;
    thePrepositionWordObject = [self wordObjectFromName:[tempString copy] withContext:context];
    if (thePrepositionWordObject == nil){
        NSLog(@"OBJECT WORD CREATED");
        thePrepositionWordObject = [Word wordWithNameFromNil:[tempString copy] withContext:context];
    }
    
    //
    // type
    //
    
    if([thePrepositionWordObject.whatSyntacticType.name length]){
        if([thePrepositionWordObject.whatSyntacticType.name isEqualToString:@"location"]) {
            prepositionIsLocation = true;
        }
        else if([thePrepositionWordObject.whatSyntacticType.name isEqualToString:@"time"]) {
            prepositionIsTime = true;
        }
    }
    
    //
    // Is Date
    //
    
    if ([self isItDate:tempString]){
        prepositionIsDate = true;
    }
    
    //
    // plural
    //
    
    thePreposition = [dictionary objectForKey:@"preposition"];
    theSentence.hasPreposition = [NSNumber numberWithBool:true];
    if ([thePrepositionWordObject.isPlural boolValue]) {
        isPrepositionplural = true;
    }
    
    //
    // pronoun and determiner
    //
    
    if ([dictionary objectForKey:@"preposition_pronoun"]) {
        thePrepositionWord = [self setPronounObject:thePrepositionWordObject];
        prepositionHasPronoun = true;
    }
    else {
        thePrepositionWord = [tempString copy];
        
        if ([dictionary objectForKey:@"preposition_determiner"]) {
            thePrepositionDeterminer = [self setDeterminer:theCharacter withWord:thePrepositionWordObject withType:[dictionary objectForKey:@"preposition_determiner"]];
            if ([[dictionary objectForKey:@"preposition_determiner"] isEqualToString:@"possesive"]) prepositionHasPossesive = true;
        }
        else {
            thePrepositionDeterminer = [self setDefaultDeterminer:thePrepositionWordObject];
        }
    }
    
    thePossesiveObject = [self setDeterminer:theCharacter withWord:thePrepositionWordObject withType:@"possesive"];
    LOG NSLog(@"-- (prep) %@ --",thePossesiveObject);

    Determiner* prepositionDeterminerObject = [Determiner createDeterminer:thePrepositionDeterminer withContext:context];
    
    //
    // Adjective
    //
    
    AdjectiveClass*thePropositionAdjectiveClass = nil;
    if ([dictionary objectForKey:@"preposition_adjective"]) {
        thePrepositionAdjective = [dictionary objectForKey:@"preposition_adjective"];
        LOG NSLog(@"-- The prep adj : %@",thePrepositionAdjective);
        prepositionHasAdjective = true;
        thePropositionAdjectiveClass = [self adjectiveObjectFromName:[dictionary objectForKey:@"preposition_adjective"] withContext:context];
        LOG NSLog(@"-- The prep obj : %@",thePropositionAdjectiveClass.basic);
    }
    
    LOG NSLog(@"-- 4.5x - Object Adjective %@ --",thePrepositionAdjective);
    
    SententialAdjective* prepositionAdjectiveObject = [SententialAdjective createSententialAdjective:thePrepositionAdjective withAdjectiveClass: thePropositionAdjectiveClass withContext:context];

    NSDictionary* prepositionDictionary;
    
    if (thePrepositionWordObject == nil) {
        prepositionDictionary = @{   @"preposition":thePreposition,
                                     @"word":thePrepositionWord,
                                     @"determiner":prepositionDeterminerObject,
                                     @"adjective":prepositionAdjectiveObject,
                                     @"word_infinitive":thePrepositionInfinitive,
                                     @"possesive_object":thePossesiveObject,
                                     };
    }
    else {
        prepositionDictionary = @{   @"preposition":thePreposition,
                                     @"word":thePrepositionWord,
                                     @"determiner":prepositionDeterminerObject,
                                     @"adjective":prepositionAdjectiveObject,
                                     @"word_object":thePrepositionWordObject,
                                     @"word_infinitive":thePrepositionInfinitive,
                                     @"possesive_object":thePossesiveObject,
                                     };

    }
    
    thePrepositionPhrase = [PrepositionalPhrase createPrepositionalPhrase:theSentence withDictionary:prepositionDictionary withContext:context];
    
    NSDictionary* prepositionPropertyDictionary = @{ @"isPlural":[NSNumber numberWithBool:isPrepositionplural],
                                                     @"hasPossesive":[NSNumber numberWithBool:prepositionHasPossesive],
                                                     @"hasAdjective":[NSNumber numberWithBool:prepositionHasAdjective],
                                                     @"hasPronoun":[NSNumber numberWithBool:prepositionHasPronoun],
                                                     @"prepositionIsDate":[NSNumber numberWithBool:prepositionIsDate],
                                                     @"prepositionIsLocation":[NSNumber numberWithBool:prepositionIsLocation],
                                                     @"prepositionIsTime":[NSNumber numberWithBool:prepositionIsTime],
                                                     @"prepositionHasSuffix":[NSNumber numberWithBool:prepositionHasSuffix],
                                                     };
    
    NounProperties* prepositionNounProperties = [NounProperties createNounPropertiesForPreposition:thePrepositionPhrase withDictionary:prepositionPropertyDictionary withContext:context];
    prepositionNounProperties.name = tempString;

    thePrepositionPhrase.whatProperties = prepositionNounProperties;
    
    NSString* completePrepositionPhraseString = [self sentenceSpaceFixer:[NSString stringWithFormat:@" %@ %@ %@ %@",thePreposition,thePrepositionDeterminer,thePrepositionAdjective,thePrepositionWord] withCaps: false];
    thePrepositionPhrase.thePrepositionPhrase = completePrepositionPhraseString;
    
    LOG NSLog(@"-- (PP) %@",thePrepositionPhrase.thePrepositionPhrase);
    
    LOG NSLog(@"Preposition Phrase - %@",completePrepositionPhraseString);
    
    return thePrepositionPhrase;
}

@end
