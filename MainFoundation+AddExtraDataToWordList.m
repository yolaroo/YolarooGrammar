//
//  MainFoundation+AddExtraDataToWordList.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+AddExtraDataToWordList.h"

#import "MainFoundation+WordSearch.h"
#import "MainFoundation+SemanticSearch.h"
#import "MainFoundation+GrammarWordSearch.h"

@implementation MainFoundation (AddExtraDataToWordList)

#define DK 2
#define LOG if(DK == 1)

#pragma mark - Main Function

- (void) newAddExtraWordData: (NSManagedObjectContext*)context
{
    NSArray* completeWordArray = [[self completeWordList:context]copy];
    NSArray* definiteArray = [[self setDefiniteDetermineredWords:context]copy];
    NSArray* properArray = [[self setProperNamedWords:context]copy];
    NSArray* pluralArray = [[self setPlurals:context]copy];
    NSArray* notCountable = [[self setUnCountables:context]copy];
    NSArray* isFemale = [[self setFemale:context]copy];
    NSArray* isMale = [[self setMale:context]copy];
    NSArray* isNumber = [[self setNumbers:context]copy];
    
    LOG NSLog(@"-- FC: %lu",(unsigned long)[completeWordArray count]);
    for (Word* wrd in completeWordArray) {
        if ([self isAnX:wrd.english withArray: definiteArray]) {
            wrd.hasDefiniteDeterminer = [NSNumber numberWithBool:true];
        } else {
            wrd.hasDefiniteDeterminer = [NSNumber numberWithBool:false];
        }
        if ([self isAnX:wrd.english withArray:properArray]) {
            wrd.isProperName = [NSNumber numberWithBool:true];
        } else {
            wrd.isProperName = [NSNumber numberWithBool:false];
        }
        if ([self isAnX:wrd.english withArray:pluralArray]) {
            wrd.isPlural = [NSNumber numberWithBool:true];
        } else {
            wrd.isPlural = [NSNumber numberWithBool:false];
        }
        if ([self isAnX:wrd.english withArray: notCountable]) {
            wrd.isUncountable = [NSNumber numberWithBool:true];
        } else {
            wrd.isUncountable = [NSNumber numberWithBool:false];
        }
        if ([self isAnX:wrd.english withArray: isFemale]) {
            wrd.gender = @"female";
        }
        if ([self isAnX:wrd.english withArray: isMale]) {
            wrd.gender = @"male";
        }
        if ([self isAnX:wrd.english withArray: isNumber]) {
            wrd.isNumber = [NSNumber numberWithBool:true];
        } else {
            wrd.isNumber = [NSNumber numberWithBool:false];
        }
    }
    [self saveData:context];
}

//
//
////
//////
////
//
//

#pragma mark - Arrays

- (NSArray*) setNumbers: (NSManagedObjectContext*)context
{
    NSArray* mydefinite = [[self wordListFromSemanticTypeName:@"numbers" withContext:context]copy];
    NSMutableArray* myDefiniteWordArray = [[NSMutableArray alloc]init];
    for (Word* wrd in mydefinite) {
        [myDefiniteWordArray addObject:wrd.english];
    }
    return [myDefiniteWordArray copy];
}

- (NSArray*) setDefiniteDetermineredWords: (NSManagedObjectContext*)context
{
    NSArray* mydefinite = [[self grammarWordListFromSemanticTypeName:@"definite determiner" withContext: context]copy];
    NSMutableArray* myDefiniteWordArray = [[NSMutableArray alloc]init];
    for (GrammarWord* wrd in mydefinite) {
        [myDefiniteWordArray addObject:wrd.name];
    }
    return [myDefiniteWordArray copy];
}

- (NSArray*) setProperNamedWords: (NSManagedObjectContext*)context
{
    NSArray* myNames = [[self grammarWordListFromSemanticTypeName:@"proper name" withContext: context]copy];
    NSMutableArray* myNameWordArray = [[NSMutableArray alloc]init];
    for (GrammarWord* wrd in myNames) {
        [myNameWordArray addObject:wrd.name];
    }
    return [myNameWordArray copy];
}

- (NSArray*) setPlurals: (NSManagedObjectContext*)context
{
    NSArray* myPluralArray = [[self grammarWordListFromSemanticTypeName:@"natural plural" withContext: context]copy];
    NSMutableArray* myPluralWordArray = [[NSMutableArray alloc]init];
    for (GrammarWord* wrd in myPluralArray) {
        [myPluralWordArray addObject:wrd.name];
    }
    return [myPluralWordArray copy];
}

- (NSArray*) setUnCountables: (NSManagedObjectContext*)context
{
    NSArray* myNotCountable = [[self grammarWordListFromSemanticTypeName:@"uncountable" withContext: context]copy];
    NSMutableArray* myNotCountableWordArray = [[NSMutableArray alloc]init];
    for (GrammarWord* wrd in myNotCountable) {
        [myNotCountableWordArray addObject:wrd.name];
    }
    return [myNotCountableWordArray copy];
}

- (NSArray*) setFemale: (NSManagedObjectContext*)context
{
    NSArray* myNotCountable = [[self grammarWordListFromSemanticTypeName:@"female" withContext: context]copy];
    NSMutableArray* myNotCountableWordArray = [[NSMutableArray alloc]init];
    for (GrammarWord* wrd in myNotCountable) {
        [myNotCountableWordArray addObject:wrd.name];
    }
    return [myNotCountableWordArray copy];
}

- (NSArray*) setMale: (NSManagedObjectContext*)context
{
    NSArray* myNotCountable = [[self grammarWordListFromSemanticTypeName:@"male" withContext: context]copy];
    NSMutableArray* myNotCountableWordArray = [[NSMutableArray alloc]init];
    for (GrammarWord* wrd in myNotCountable) {
        [myNotCountableWordArray addObject:wrd.name];
    }
    return [myNotCountableWordArray copy];
}

//
//
////
//////
////
//
//

#pragma mark - BOOL

- (BOOL) isAnX: (NSString*)myWord withArray: (NSArray*) myWordArray{
    for (NSString* str in myWordArray) {
        if ([str isEqualToString:myWord])
            return YES;
    }
    return NO;
}

@end
