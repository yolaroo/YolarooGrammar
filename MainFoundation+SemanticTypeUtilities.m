//
//  MainFoundation+SemanticTypeUtilities.m
//  YolarooGrammar
//
//  Created by MGM on 5/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SemanticTypeUtilities.h"

#import "Copula+Create.h"
#import "MainFoundation+SemanticSearch.h"

@implementation MainFoundation (SemanticTypeUtilities)


#define DK 2
#define LOG if(DK == 1)

- (BOOL) simpleDeterminerTest: (Word*)theWord
{
    if ([theWord.isPlural boolValue] || [theWord.isUncountable boolValue] || [theWord.isNumber boolValue] || [theWord.isProperName boolValue]) {
        return false;;
    }
    else {
        return true;
    }
}

- (BOOL) simplePluralityTest: (Word*)theWord
{
    if ([theWord.english isEqualToString:@"they"] || [theWord.english isEqualToString:@"we"]) {
        return false;
    }
    else if ([theWord.isPlural boolValue]) {
        return true;
    }
    else {
        return false;
    }
    
    /*
     if ([theWord.isPlural boolValue] && ![theWord.isUncountable boolValue]) {
     return true;
     }
     else {
     return false;
     }
     */
}

#pragma mark - VERB

- (NSString*) theSimpleCopulaString: (BOOL)subjectIsPlural withContext: (NSManagedObjectContext*)context
{
    Copula*theCopula = [Copula getCopula:context];
    if (subjectIsPlural) {
        return theCopula.presentPlural;
    }
    else {
        return theCopula.thirdPersonSingular;
    }
}

- (BOOL) hasInitialVowelForSemanticType: (NSString*)objectString
{
    if ([objectString hasPrefix:@"a"] || [objectString hasPrefix:@"A"] || [objectString hasPrefix:@"e"] || [objectString hasPrefix:@"E"] || [objectString hasPrefix:@"i"] || [objectString hasPrefix:@"I"] || [objectString hasPrefix:@"o"] || [objectString hasPrefix:@"O"]|| [objectString hasPrefix:@"Herb"] || [objectString hasPrefix:@"herb"] || [objectString hasPrefix:@"hour"] || [objectString hasPrefix:@"Hour"] || [objectString hasPrefix:@"under"]) {
        return true;
    }
    else {
        return false;
    }
}

//

- (NSString*) setIndefiniteDeterminer: (Word*) myWord
{
    if (![myWord.isPlural boolValue]) {
        if ([self hasInitialVowelForSemanticType:myWord.english]) {
            return @"an";
        }
        else {
            return @"a";
        }
    }
    else {
        return @" ";
    }
}

- (NSDictionary*) simpleCategoryList: (NSManagedObjectContext*)context
{
    NSArray* keyArray;
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc]init];
    
    while ([keyArray count] < 4){
        //
        // change for specific area study
        //
        NSArray* completeSemanticList = [self shuffleArray:[self completeModifiedSemanticTypeList:context]];
        
        NSArray* groupOfFour = @[[completeSemanticList objectAtIndex:0],[completeSemanticList objectAtIndex:1],[completeSemanticList objectAtIndex:2],[completeSemanticList objectAtIndex:3]];
        
        for (SemanticType* smt in groupOfFour) {
            [dictionary setObject:smt.name forKey:smt.wordObject];
        }
        keyArray = [dictionary allKeys];
    }
    LOG NSLog(@"groupOfFour %lu", (unsigned long)[keyArray count]);
    
    return [dictionary copy];
}

@end
