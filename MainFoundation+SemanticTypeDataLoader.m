//
//  MainFoundation+SemanticTypeDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SemanticTypeDataLoader.h"

#import "MainFoundation+WordSearch.h"


#import "MainFoundation+SemanticTypeUtilities.h"
#import "MainFoundation+GrammarUtilities.h"

#import "MainFoundation+SemanticSearch.h"


@implementation MainFoundation (SemanticTypeDataLoader)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
// data methods
////////
//
//

- (NSArray*) simpleSentenceLoadForSemanticType:(NSDictionary*) dictionaryData withContext:(NSManagedObjectContext*)context
{
    NSDictionary*mySentenceDictionary = [self sentenceBuilderForSimpleSemanticType:dictionaryData withContext:context];
    return [self dataTransformationForSemanticType:mySentenceDictionary];
}

- (NSDictionary*) myDataForSemanticType: (NSManagedObjectContext*)context
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

- (NSArray*) dataTransformationForSemanticType: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    if ([dictionary objectForKey:@"subject_determiner"]){
        [myTopString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"object_determiner"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"object_determiner"]];
    }
    if ([dictionary objectForKey:@"object"]){
            [myTopString appendString: @" _____ "];
    }
    return @[[self sentenceSpaceFixer:[myTopString copy] withCaps:true],[dictionary objectForKey:@"theFourAnswers"]];
}

- (NSDictionary*) sentenceBuilderForSimpleSemanticType: (NSDictionary*)dictionary withContext: (NSManagedObjectContext*) context
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
    Word*theWordSubject =[[self shuffleArray:[self wordListFromSemanticTypeName:myCategoryName withContext:context]] firstObject];
    
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
    
    Word* theWordObject = [[self wordListFromName:myKeyForClass withContext:context]firstObject];
    
    LOG NSLog(@"object: %@",myKeyForClass);

    
    //
    //plural and suffix
    //
    
    bool objectHasDeterminer = false;
    
    objectHasDeterminer = [self simpleDeterminerTest:theWordObject];
    if (objectHasDeterminer){
       LOG NSLog(@"plural");
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
    //return
    //
    
    return @{@"subject_determiner":mySubjectDeterminer,
             @"subject":mySubject,
             @"verb":theVerb,
             @"object_determiner":myObjectDeterminer,
             @"object":myKeyForClass,
             @"theFourAnswers":fourKeyArray};
}

@end
