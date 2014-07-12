//
//  MainFoundation+SentenceCreation.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SentenceCreation.h"

#import "MainFoundation+PropositionDefine.h"
#import "MainFoundation+SubjectDefine.h"
#import "MainFoundation+VerbDefine.h"

#import "MainFoundation+ObjectDefine.h"
#import "MainFoundation+MultiObjectDefine.h"

#import "MainFoundation+SentenceUtility.h"

#import "MainFoundation+CharacterCreate.h"
#import "MainFoundation+CharacterSearch.h"

#import "PrepositionalPhrase+Create.h"
#import "SubjectPhrase+Create.h"
#import "ObjectPhrase+Create.h"
#import "SententialVerb+Create.h"

#import "Sentence+Create.h"

@implementation MainFoundation (SentenceCreation)

#define DK 2
#define LOG if(DK == 1)

- (Sentence*) writeSentence: (Character*) theCharacter withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext*) context
{
    BOOL hasAdjectiveForObject = false;
    BOOL hasSecondObject = false;
    BOOL hasPreposition = false;
    BOOL isCopula = false;
    BOOL isDirectIdentity = true;
    BOOL hasObject = false;
    BOOL hasMultipleObjects = false;
    BOOL hasCharacterSubject = false;
    BOOL isSingleSentenceUnpack = false;
    
    NSInteger objectCount = 0;
    NSInteger singleObjectUnpackIndex = 0;
    NSString* sentenceTense = @"present";
    NSString* sentenceModal = @"thirdPerson";
    NSString* sentenceAspect = @"simple";
    NSString* sentencePragmaticType = @"fact";
    NSString* theCharacterName = @"";

    Sentence* theSentence = [Sentence createSentenceWithUUID:[self buildUUID] withContext:context];
    theSentence.sentenceTense = sentenceTense;
    theSentence.sentenceModal = sentenceModal;
    theSentence.sentenceAspect = sentenceAspect;
    theSentence.pragmaticType = sentencePragmaticType;
    
    //
    // character info
    //
    
    theCharacterName = [self getCharacterName:theCharacter];
    theSentence.characterName = theCharacterName;
    theSentence.isAnthropomorphic = [NSNumber numberWithBool: true];
    theSentence.characterGender = theCharacter.whatGender.name;
    
    //
    // subject define
    //
    
    SubjectDefine mySubjectDefinition;
    
    if ([[dictionary objectForKey:@"subject"] isKindOfClass:[NSSet class]]) {
        mySubjectDefinition = kSubjectIsSet;
    }
    else if ([[dictionary objectForKey:@"subject"] isKindOfClass:[NSString class]]) {
        mySubjectDefinition = kSubjectIsString;
    }
    else if ([[dictionary objectForKey:@"subject"] isKindOfClass:[NSManagedObject class]]) {
        mySubjectDefinition = kSubjectIsObject;
    }
    else {
        mySubjectDefinition = kSubjectIsEmpty;
    }

    //
    // non-identity set
    //
    
    isDirectIdentity = [self isDirectIdentityTest:mySubjectDefinition withDictionary:dictionary];
    theSentence.isDirectIdentity = [NSNumber numberWithBool:isDirectIdentity];
    
    //
    // ischaracter
    //
    
    if (mySubjectDefinition == kSubjectIsObject) {
        if ([[self objectType:[dictionary objectForKey:@"subject"]] isEqualToString:@"character"]){
            hasCharacterSubject = true;
        }
    }
    else if (mySubjectDefinition == kSubjectIsString) {
        if ([[dictionary objectForKey:@"subject"] isEqualToString:theCharacterName]) {
            hasCharacterSubject = true;
        }
    }

    //
    // object define
    //
    
    ObjectDefine myObjectDefinition;
    
    if ([[dictionary objectForKey:@"object"] isKindOfClass:[NSSet class]]) {
        hasObject = true;
        objectCount = [[[dictionary objectForKey:@"object"]allObjects] count];
        if (objectCount > 1) {
            hasMultipleObjects = true;
            myObjectDefinition = kObjectIsMXO;
        }
        else {
            myObjectDefinition = kObjectIsSet;
        }
    }
    else if ([[dictionary objectForKey:@"object"] isKindOfClass:[NSString class]]) {
        myObjectDefinition = kObjectIsString;
        if ([[dictionary objectForKey:@"object"] isEqualToString:@"EMPTY"]){
        }
        else {
            hasObject = true;
        }
    }
    else if ([[dictionary objectForKey:@"object"] isKindOfClass:[NSManagedObject class]]) {
        myObjectDefinition = kObjectIsObject;
        hasObject = true;
    }
    else {
        myObjectDefinition = kObjectIsEmpty;
    }
    theSentence.hasObject = [NSNumber numberWithBool:hasObject];
    theSentence.objectsCount = [NSNumber numberWithInteger:objectCount];
    theSentence.hasMultipleObjects = [NSNumber numberWithBool:hasMultipleObjects];

    //
    // verb define
    //
    
    VerbDefine myVerbDefinition;

    if ([[dictionary objectForKey:@"verb"] isKindOfClass:[NSSet class]]) {
        myVerbDefinition = kVerbIsSet;
    }
    else if ([[dictionary objectForKey:@"verb"] isKindOfClass:[NSString class]]) {
        myVerbDefinition = kVerbIsString;
    }
    else if ([[dictionary objectForKey:@"verb"] isKindOfClass:[NSManagedObject class]]) {
        myVerbDefinition = kVerbIsObject;
    }
    else {
        myVerbDefinition = kVerbIsEmpty;
    }
    
    //
    // sentence unpack check
    //
    
    if (myObjectDefinition == kObjectIsMXO) {
        if ([dictionary objectForKey:@"sentence_single_unpack"]){
            isSingleSentenceUnpack = true;
            singleObjectUnpackIndex = [[dictionary objectForKey:@"sentence_single_unpack"] integerValue];
            if (singleObjectUnpackIndex > objectCount) {
                singleObjectUnpackIndex = 0;
            }
            theSentence.hasSingleObjectUnpack = [NSNumber numberWithBool:isSingleSentenceUnpack];
            theSentence.singleObjectUnpackIndex = [NSNumber numberWithInteger:singleObjectUnpackIndex];
        }
    }
    
//
//
/////
//
/////
//
//
    
//
////
// subject
////
//
    
    SubjectPhrase* theSubjectPhrase = [self makeSubjectPhrase:theCharacter withSentence:theSentence withDictionary:dictionary withDefinition:mySubjectDefinition withContext:context];
    
    theSubjectPhrase.isCharacter = [NSNumber numberWithBool:hasCharacterSubject];

//
////
// verb
////
//
    
    SententialVerb* theVerbPhrase = [self makeVerbPhrase:theCharacter withSubjectPhrase:theSubjectPhrase withSentence:theSentence withDefinition:myVerbDefinition withDictionary:dictionary withContext:context];
    
    if([theVerbPhrase.isCopula boolValue]) {
        isCopula = true;
        theSentence.hasCopula = [NSNumber numberWithBool:isCopula];
    }

//
////
// object
////
//

    NSMutableArray* theObjectPhraseArray = [[NSMutableArray alloc] init];
    
    if (hasObject) {
        if (myObjectDefinition == kObjectIsString) {
            theSentence.hasObject = [NSNumber numberWithBool:TRUE];
            [theObjectPhraseArray addObject: [self makeObjectPhrase:theCharacter withSentence:theSentence withDictionary:dictionary  withDefinition:myObjectDefinition withContext:context]];
        }
        else if (myObjectDefinition == kObjectIsSet) {
            [theObjectPhraseArray addObject: [self makeObjectPhrase:theCharacter withSentence:theSentence withDictionary:dictionary withDefinition:myObjectDefinition withContext:context]];
        }
        else if (myObjectDefinition == kObjectIsMXO) {
            NSArray*theIntialObjectArray = [[dictionary objectForKey:@"object"]allObjects];

            if (isSingleSentenceUnpack) { // one at a time
                    [theObjectPhraseArray addObject:[self makeObjectPhraseMXO:theCharacter withSentence:theSentence withDictionary:dictionary withObjectNumber: singleObjectUnpackIndex withObjectArray: theIntialObjectArray withContext:context]];
            }
            else {
                for (int i = 0; i < objectCount; i++) { // bunched objects
                    [theObjectPhraseArray addObject:[self makeObjectPhraseMXO:theCharacter withSentence:theSentence withDictionary:dictionary withObjectNumber:i withObjectArray: theIntialObjectArray withContext:context]];
                }
            }
        }
        else if (myObjectDefinition == kObjectIsObject){
            [theObjectPhraseArray addObject: [self makeObjectPhrase:theCharacter withSentence:theSentence withDictionary:dictionary  withDefinition:myObjectDefinition withContext:context]];
        }
    }
    
//
////
//second object
////
//

    if ([dictionary objectForKey:@"second_object"]) {
        hasSecondObject = true;
        if ([dictionary objectForKey:@"second_object_pronoun"]) {
        }
        if ([dictionary objectForKey:@"subject_determiner"]) {
        }
    }
    
//
////
//preposition
////
//

    PrepositionalPhrase*thePrepositionalPhrase;
    if ([dictionary objectForKey:@"preposition"]) {
        hasPreposition = true;
        theSentence.hasPreposition = [NSNumber numberWithBool:TRUE];
        thePrepositionalPhrase = [self makePrepositionalPhrase:theCharacter withSentence:theSentence withDictionary:dictionary withContext:context];
    }
    else {
        thePrepositionalPhrase = [PrepositionalPhrase createEmptyPrepositionalPhrase:context];
    }
    
//
////
// write
////
//

    NSMutableDictionary* writeDictionary = [[NSMutableDictionary alloc]init];

    NSSet* subjectSet = [NSSet setWithObjects:theSubjectPhrase, nil];
    theSentence.whatSubject = subjectSet;
    if([theSubjectPhrase.theSubjectPhrase length]) {
        [writeDictionary setObject: theSubjectPhrase.theSubjectPhrase forKey:@"subject"];
    }
    
    NSSet* verbSet = [NSSet setWithObjects:theVerbPhrase, nil];
    theSentence.whatSententialVerb = verbSet;
    if([theVerbPhrase.theVerbPhrase length]) {
        [writeDictionary setObject: theVerbPhrase.theVerbPhrase forKey:@"verb"];
    }
    
    if (hasObject) {
        NSSet* objectSet = [NSSet setWithArray:theObjectPhraseArray];
        theSentence.whatObject = objectSet;
        if([theObjectPhraseArray count]) {
            [writeDictionary setObject: theObjectPhraseArray forKey:@"object"];
        }
    }
    
    if (hasSecondObject) {
        
    }
    
    if (hasAdjectiveForObject) {
        
    }
    
    if (hasPreposition) {
        NSSet* prepositionSet = [NSSet setWithObjects:thePrepositionalPhrase, nil];
        theSentence.whatPreposition = prepositionSet;
        if([thePrepositionalPhrase.thePrepositionPhrase length]) {
            [writeDictionary setObject: thePrepositionalPhrase.thePrepositionPhrase forKey:@"preposition"];
        }
    }
    
    theSentence.theSentence = [self writeTheSentence:[writeDictionary copy]];
    
    [self saveData:context];
    
    return theSentence;
}

//
//// write
//

- (NSString*) writeTheSentence: (NSDictionary*)writeDictionary{
    
    NSMutableString* theCompleteSentence = [NSMutableString stringWithFormat:@" "];
    if ([writeDictionary objectForKey:@"subject"]) {
        [theCompleteSentence appendString:[writeDictionary objectForKey:@"subject"]];
    }
    
    if ([writeDictionary objectForKey:@"verb"]) {
        [theCompleteSentence appendString:@" "];
        [theCompleteSentence appendString:[writeDictionary objectForKey:@"verb"]];
    }
    
    if ([writeDictionary objectForKey:@"object"]) {
        BOOL objectWriteFirstRun = FALSE;
        for (ObjectPhrase* obp in [writeDictionary objectForKey:@"object"]) {
            if (!objectWriteFirstRun) {
                objectWriteFirstRun = true;
                [theCompleteSentence appendString:@" "];
                [theCompleteSentence appendString:obp.theObjectPhrase];
            }
            else {
                [theCompleteSentence appendString:@" and "];
                [theCompleteSentence appendString:obp.theObjectPhrase];
            }
        }
    }
    
    if ([writeDictionary objectForKey:@"preposition"]) {
        [theCompleteSentence appendString:@" "];
        [theCompleteSentence appendString:[writeDictionary objectForKey:@"preposition"]];
    }
    return [self sentenceSpaceFixer: [theCompleteSentence copy] withCaps: true];
}

- (BOOL) isDirectIdentityTest:(SubjectDefine)value withDictionary: (NSDictionary*)dictionary
{
    if ([dictionary objectForKey:@"sentential_relationship"]){
        if ([[dictionary objectForKey:@"sentential_relationship"] isEqualToString:@"nonDirectIdentity"]){
            return false;
        }
    }
    else if (value == kSubjectIsSet){
        if ([[[[dictionary objectForKey:@"subject"] allObjects]firstObject] respondsToSelector:@selector(isDirectIdentity)]) {
            return [[ [[[dictionary objectForKey:@"subject"] allObjects]firstObject] isDirectIdentity] boolValue];
        }
    }
    else if (value == kSubjectIsObject) {
        return [[[dictionary objectForKey:@"subject"] isDirectIdentity] boolValue];
    }
    else{
        return false;
    }
    LOG NSLog(@"direct identity test error");
    LOG NSLog(@"-- %@",[dictionary objectForKey:@"subject"]);

    //goal
    //disposition
    //job
    return false;
}

//
//// name
//

- (NSString*) getCharacterName: (Character*)theCharacter {
    if ([theCharacter.name length] && [theCharacter.name isKindOfClass:[NSString class]]) {
        return theCharacter.name;
    }
    else {
        return @"The person";
    }
}


@end
