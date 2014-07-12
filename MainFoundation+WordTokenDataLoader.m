//
//  MainFoundation+WordTokenDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+WordTokenDataLoader.h"

#import "MainFoundation+WordSearch.h"

#import "MainFoundation+SemanticTypeUtilities.h"
#import "MainFoundation+GrammarUtilities.h"


@implementation MainFoundation (WordTokenDataLoader)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
// data methods
////////
//
//


- (NSArray*) simpleSentenceLoadForTokenType:(NSDictionary*) dictionaryData withContext:(NSManagedObjectContext*)context
{
    NSDictionary*mySentenceDictionary = [self sentenceBuilderForSimpleTokenType:dictionaryData withContext:context];
    return [self dataTransformationForTokenType:mySentenceDictionary];
}

- (NSDictionary*) myDataForTokenType: (NSManagedObjectContext*)context
{
    return [self simpleCategoryList:context];
}


//
//
////////
// writer
////////
//
//

- (NSArray*) dataTransformationForTokenType: (NSDictionary*) dictionary
{
    NSMutableString*myHiddenString = [NSMutableString stringWithFormat:@" "];
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];

    if ([dictionary objectForKey:@"subject_determiner"]){
        [myHiddenString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [myHiddenString appendString: @" "];
        [myHiddenString appendString:[dictionary objectForKey:@"subject"]];
        
        [mySentenceString appendFormat: @"What"];
        
    }
    if ([dictionary objectForKey:@"verb"]){
        [myHiddenString appendString: @" "];
        [myHiddenString appendString:[dictionary objectForKey:@"verb"]];

        [mySentenceString appendFormat: @" is "];

    }
    if ([dictionary objectForKey:@"object_determiner"]){
        [myHiddenString appendString: @" "];
        [myHiddenString appendString:[dictionary objectForKey:@"object_determiner"]];
        
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"object_determiner"]];

    }
    if ([dictionary objectForKey:@"object"]){
        [myHiddenString appendString: @" "];
        [myHiddenString appendString:[dictionary objectForKey:@"object"]];
        
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"object"]];
        [mySentenceString appendString: @"?"];

    }
    return @[[self sentenceSpaceFixer:[mySentenceString copy] withCaps:true],[self sentenceSpaceFixer:[myHiddenString copy] withCaps:true], [dictionary objectForKey:@"theFourAnswers"]];
}

- (NSDictionary*) sentenceBuilderForSimpleTokenType: (NSDictionary*)dictionary withContext: (NSManagedObjectContext*) context
{
    //NSArray *keys = [dictionary allKeys];
    //NSArray *values = [dictionary allValues];
    
    NSArray* keyArray = [self shuffleArray:[dictionary allKeys]];
    LOG NSLog(@"keycount %lu", (unsigned long)[keyArray count]);
    
    NSArray* fourKeyArray = @[[keyArray objectAtIndex:0],[keyArray objectAtIndex:1],[keyArray objectAtIndex:2],[keyArray objectAtIndex:3]];
    
    LOG NSLog(@"keyarray: %@",fourKeyArray);
    
    //
    //subject
    //
    
    NSString* myCategoryName = [dictionary objectForKey:[fourKeyArray firstObject]];
    Word*theWordSubject = [[self shuffleArray:[self wordListFromSemanticTypeName:myCategoryName withContext:context]] firstObject];
    
    NSMutableString* mySubject = [NSMutableString stringWithFormat:@""];
    mySubject = [theWordSubject.english mutableCopy];
    
    LOG NSLog(@"subject: %@",mySubject);
    
    //
    //plural and suffix
    //
    
    bool subjectHasDeterminer = false;
    subjectHasDeterminer = [self simpleDeterminerTest:theWordSubject];
    
    bool subjectIsPlural = false;
    subjectIsPlural = [self simplePluralityTest:theWordSubject];

    //
    //fix for case
    if ([theWordSubject.english isEqualToString:@"they"] || [theWordSubject.english isEqualToString:@"we"]) {
        subjectIsPlural = false;
    }
    //
    
    //
    //determiner
    //
    
    NSString*mySubjectDeterminer;
    if (subjectHasDeterminer) {
        if ([self hasInitialVowelForSemanticType:mySubject]){
            mySubjectDeterminer = @"an";
        }
        else {
            mySubjectDeterminer = @"a";
        }
    }
    else {
        if ([theWordSubject.hasDefiniteDeterminer boolValue]){
            mySubjectDeterminer = @"the";
        }
        else {
            mySubjectDeterminer = @" ";
        }
    }
    
    //
    //verb
    //
    
    NSString*theVerb;
    theVerb = [self theSimpleCopulaString:subjectIsPlural withContext:context];
    
    LOG NSLog(@"verb: %@",theVerb);
    
    //
    //object
    //
    
    NSArray *tempArray = [dictionary allKeysForObject:myCategoryName];
    NSString *myKeyForClass = [tempArray firstObject];
    
//    Word* theWordObject = [[self wordListFromName:myKeyForClass withContext:context]firstObject];
    LOG NSLog(@"object: %@",myKeyForClass);
    
    
    //
    //plural and suffix
    //
    
    bool objectHasDeterminer = true;
    
//    objectHasDeterminer = [self simpleDeterminerTest:theWordObject];
    if (objectHasDeterminer){
        LOG NSLog(@"det");
    }
    
    //
    //determiner
    //
    
    NSString*myObjectDeterminer;
    if (objectHasDeterminer) {
        if ([self hasInitialVowelForSemanticType:myKeyForClass]){
            myObjectDeterminer = @"an";
        }
        else {
            myObjectDeterminer = @"a";
        }
    }
    else {
        myObjectDeterminer = @" ";
    }
    
    //
    // answer array
    //
    
    NSString* secondString = [dictionary objectForKey:[fourKeyArray objectAtIndex:1]];
    NSString* thirdString = [dictionary objectForKey:[fourKeyArray objectAtIndex:2]];
    NSString* fourthString = [dictionary objectForKey:[fourKeyArray objectAtIndex:3]];
    
    Word* secondWord = [[self shuffleArray:[self wordListFromSemanticTypeName:secondString withContext:context]] firstObject];
    Word* thirdWord = [[self shuffleArray:[self wordListFromSemanticTypeName:thirdString withContext:context]] firstObject];
    Word* fourthWord = [[self shuffleArray:[self wordListFromSemanticTypeName:fourthString withContext:context]] firstObject];
    
    NSArray* myExampleArray = @[[mySubject copy],secondWord.english,thirdWord.english,fourthWord.english];

    //
    //return
    //
    
    return @{@"subject_determiner":mySubjectDeterminer,
             @"subject":mySubject,
             @"verb":theVerb,
             @"object_determiner":myObjectDeterminer,
             @"object":myKeyForClass,
             @"theFourAnswers":myExampleArray};
}

@end
