//
//  MainFoundation+AccusativeDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+AccusativeDataLoader.h"

#import "MainFoundation+WordSearch.h"

#import "VerbWord+Create.h"
#import "MainFoundation+SentenceUtility.h"

#import "MainFoundation+GrammarUtilities.h"
#import "MainFoundation+VerbSearch.h"

@implementation MainFoundation (AccusativeDataLoader)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
// composition
////////
//
//

- (NSDictionary*) sentenceForAccusativeExercise: (NSInteger)number withContext: (NSManagedObjectContext*) context
{
    NSDictionary* sentence00;
    NSDictionary* sentence01;
    NSDictionary* sentence02;
    NSDictionary* sentence03;
    
    sentence00 = @{@"subject":@"farm animals",
                   @"verb":[self mySimpleVerbList],
                   @"object":@"farm animals"};
    
    sentence01 = @{@"subject":@"species",
                   @"verb":[self mySimpleVerbList],
                   @"object":@"species"};
    
    sentence02 = @{@"subject":@"farm animals",
                   @"verb":[self mySimpleVerbList],
                   @"object":[self myCommonPeople]};
    
    if ([self oneInThree]){
        sentence03 = @{@"subject":@"species",
                       @"verb":[self mySimpleVerbList],
                       @"object":[self myCommonPeople],
                       @"second_object":[self myCommonPeople]};
    }
    else {
        if ([self oneInTwo]){
            sentence03 = @{@"subject":@"species",
                           @"verb":[self mySimpleVerbList],
                           @"object":[self myCommonPeople]};
        }
        else {
            sentence03 = @{@"subject":@"species",
                           @"verb":[self mySimpleVerbList],
                           @"object":@"species"};
        }
    }
    
    NSArray*myDictionaryArray = @[sentence00,sentence01,sentence02,sentence03];
    if (number  >  [myDictionaryArray count] || number < 0 ) {
        number = 0;
    }
    return [self accusativeSentenceResult:[myDictionaryArray objectAtIndex:number] withContext:context];
}


//
//
////////
// view maker
////////
//
//

- (NSArray*) buttonViewFromCaseForAccusative:(NSInteger)myNumber
{
    switch (myNumber) {
        case 0:
            return @[@"it",@"them",@"-",@"-"];
            break;
        case 1:
            return @[@"it",@"them",@"-",@"-"];
            break;
        case 2:
            return @[@"him",@"her",@"-",@"-"];
            break;
        case 3:
            return @[@"it",@"them",@"him",@"her"];
            break;
        default:
            return @[@"it",@"them",@"her",@"him"];
            break;
    }
}

- (NSDictionary*) theDataSetFromCaseForAccusative:(NSInteger)myNumber withContext: (NSManagedObjectContext*) context
{
    switch (myNumber) {
        case 0:
            return [self sentenceForAccusativeExercise:0 withContext: context];
            break;
        case 1:
            return [self sentenceForAccusativeExercise:1 withContext: context];
            break;
        case 2:
            return [self sentenceForAccusativeExercise:2 withContext: context];
            break;
        case 3:
            return [self sentenceForAccusativeExercise:3 withContext: context];
            break;
        default:
            return [self sentenceForAccusativeExercise:0 withContext: context];
            break;
    }
}

//
//
////////
// string writer
////////
//
//

- (NSArray*) dataTransformationForAccusative: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    NSMutableString*myBottomString = [NSMutableString stringWithFormat:@" "];
    if ([dictionary objectForKey:@"determiner"]){
        [myTopString appendString:[dictionary objectForKey:@"determiner"]];
        [myBottomString appendString:[dictionary objectForKey:@"determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"subject"]];
        [myBottomString appendString: @" "];
        [myBottomString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"verb"]];
        [myBottomString appendString: @" "];
        [myBottomString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"objectDeterminer"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"objectDeterminer"]];
    }
    if ([dictionary objectForKey:@"object"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"object"]];
        
        [myBottomString appendString: @" ______ "];
    }
    if ([dictionary objectForKey:@"second_determiner"]){
        [myTopString appendString: @" and "];
        [myTopString appendString:[dictionary objectForKey:@"objectDeterminer"]];
    }
    if ([dictionary objectForKey:@"second_object"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"second_object"]];
    }
    return @[[self sentenceSpaceFixer:[myTopString copy] withCaps:true],[self sentenceSpaceFixer:[myBottomString copy] withCaps:true],[self myReformedAnswer:[self sentenceSpaceFixer:[myBottomString copy] withCaps:true] withNewPart:[dictionary objectForKey:@"thePronoun"]],[dictionary objectForKey:@"thePronoun"]];
}

//
//
////////
// grammar
////////
//
//

- (NSDictionary*) accusativeSentenceResult: (NSDictionary*)dictionary withContext: (NSManagedObjectContext*) context
{
    //
    //subject 01
    //
    
    Word*theWordSubject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"subject"] withContext:context]] firstObject];
    
    NSMutableString* mySubject = [NSMutableString stringWithFormat:@""];
    mySubject = [theWordSubject.english mutableCopy];
    
    //
    //plural and suffix
    //
    
    bool subjectIsPlural = false;
    subjectIsPlural= [self thePluralCheck:dictionary withWord:theWordSubject];
    if ([self canBePluralized:theWordSubject withCase:subjectIsPlural]){
        mySubject = [[self suffixCheck:theWordSubject.english]mutableCopy];
    }
    
    //
    //determiner
    //
    
    NSString* theDeterminer;
    theDeterminer = [self setMyDeterminer:theWordSubject];
    
    //
    //verb
    //
    
    NSString*theVerb;

    VerbWord*theVerbWord = [[self verbClassFromName:[dictionary objectForKey:@"verb"] withContext:context] firstObject];
    if (subjectIsPlural) {
        theVerb = theVerbWord.simple;
    }
    else {
        theVerb = theVerbWord.thirdPersonSingular;
    }

    //
    // object
    //
    
    Word*theWordObject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"object"] withContext:context]] firstObject];
    
    NSMutableString* myObject = [NSMutableString stringWithFormat:@""];
    myObject = [theWordObject.english mutableCopy];
    
    //
    // object determiner
    //
    
    NSString* theObjectDeterminer;
    theObjectDeterminer = [self setMyDeterminer:theWordObject];
    
    //
    // second object
    //
    
    Word*theSecondObject;
    bool hasSecondObject = false;
    NSString* theSecondObjectDeterminer;
    NSMutableString* mySecondObject = [NSMutableString stringWithFormat:@""];

    if ([dictionary objectForKey:@"second_object"]) {
        theSecondObject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"second_object"] withContext:context]] firstObject];
        hasSecondObject = true;
        mySecondObject = [theSecondObject.english mutableCopy];

        // determiner second object
        theSecondObjectDeterminer = [self setMyDeterminer:theSecondObject];
    }
    else {
        theSecondObjectDeterminer = @"";
    }
    
    //
    //plural and suffix
    //
    
    bool objectIsPlural = false;
    objectIsPlural= [self thePluralCheckForObject:dictionary withWord:theWordObject];
    if ([self canBePluralized:theWordObject withCase:objectIsPlural]){
        myObject = [[self suffixCheck:theWordObject.english]mutableCopy];
    }
    
    //
    /// answer - pronoun - for accusative
    //
    
    NSString*thePronoun;
    thePronoun = [self theAnswerComputationForAccusative:theWordObject withCase:objectIsPlural];
    
    //
    //return
    //

    if ([dictionary objectForKey:@"second_object"]) {
        return @{@"determiner":theDeterminer,
                 @"subject":mySubject,
                 @"verb":theVerb,
                 @"objectDeterminer":theObjectDeterminer,
                 @"object":myObject,
                 @"second_determiner":theSecondObjectDeterminer,
                 @"second_object":mySecondObject,
                 @"thePronoun":thePronoun};
    }
    else {
        return @{@"determiner":theDeterminer,
                 @"subject":mySubject,
                 @"verb":theVerb,
                 @"objectDeterminer":theObjectDeterminer,
                 @"object":myObject,
                 @"thePronoun":thePronoun};
    }
}

@end
