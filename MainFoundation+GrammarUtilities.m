//
//  MainFoundation+GrammarUtilities.m
//  YolarooGrammar
//
//  Created by MGM on 5/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+GrammarUtilities.h"

#import "Copula+Create.h"

@implementation MainFoundation (GrammarUtilities)

#pragma mark - answer update

- (NSString*) myReformedAnswer: (NSString*) sentence withNewPart: (NSString*) part
{
    return [sentence stringByReplacingOccurrencesOfString:@"______" withString:part];
}


#pragma mark - subject methods

-(NSString*) myCommonPeople
{
    if ([self oneInTwo]) {
        return @"boy's names";
    } else {
        return @"girl's names";
    }
}

-(NSString*) myCommonSubject
{
    if ([self oneInTwo]) {
        return @"species";
    } else {
        if ([self oneInTwo]) {
            return @"boy's names";
        } else {
            return @"girl's names";
        }
    }
}

- (NSString*) myVerbSubjectSimple
{
    NSInteger myNumber = arc4random() % 4;
    switch (myNumber) {
        case 0:
            return @"She";
            break;
        case 1:
            return @"He";
            break;
        case 2:
            return @"They";
            break;
        case 3:
            return [self myCommonPeople];
            break;
        case 4:
            return [self myCommonPeople];
            break;
        default:
            return [self myCommonPeople];
            break;
    }
    return nil;
}

//
////
//

- (NSString*) mySimpleVerbList
{
    NSInteger myNumber = arc4random() % 19;
    switch (myNumber) {
        case 1:
            return @"to see";
            break;
        case 2:
            return @"to hear";
            break;
        case 3:
            return @"to smell";
            break;
        case 4:
            return @"to hit";
            break;
        case 5:
            return @"to find";
            break;
        case 6:
            return @"to pass";
            break;
        case 7:
            return @"to save";
            break;
        case 8:
            return @"to warn";
            break;
        case 9:
            return @"to remind";
            break;
        case 10:
            return @"to know";
            break;
        case 11:
            return @"to love";
            break;
        case 12:
            return @"to hate";
            break;
        case 13:
            return @"to like";
            break;
        case 14:
            return @"to dislike";
            break;
        case 15:
            return @"to draw";
            break;
        case 16:
            return @"to tease";
            break;
        case 17:
            return @"to paint";
            break;
        case 18:
            return @"to kick";
            break;
        default:
            return @"see";
            break;
    }
    return nil;
}

//
////
//

- (NSString*) myVerbSubjectPronouns
{
    NSInteger myNumber = arc4random() % 8;
    switch (myNumber) {
        case 1:
            return @"she";
            break;
        case 2:
            return @"he";
            break;
        case 3:
            return @"they";
            break;
        case 4:
            return @"we";
            break;
        case 5:
            return @"I";
            break;
        case 6:
            return @"it";
            break;
        case 7:
            return @"you";
            break;
        default:
            return @"I";
            break;
    }
    return nil;
}

- (NSString*) myVerbSubjectComplex
{
    NSInteger myNumber = arc4random() % 11;
    switch (myNumber) {
        case 1:
            return @"I";
            break;
        case 2:
            return @"you";
            break;
        case 3:
            return @"we";
            break;
        case 4:
            return @"she";
            break;
        case 5:
            return @"he";
            break;
        case 6:
            return @"they";
            break;
        case 7:
            return @"it";
            break;
        case 8:
            return [self myCommonPeople];
            break;
        case 9:
            return [self myCommonSubject];
            break;
        case 10:
            return [self myCommonSubject];
            break;
        case 11:
            return [self myCommonSubject];
            break;
        default:
            return [self myCommonPeople];
            break;
    }
    return nil;
}

#pragma mark - determiner

-(NSString*) setMyDeterminer: (Word*)theWord
{
    if([theWord.isProperName boolValue]){
        return @"";
    }else {
        if ([theWord.isPlural boolValue] && ![theWord.english hasSuffix:@"s"]) {
            return @"the two";
        }
        else {
            return @"the";
        }
    }
}

#pragma mark - can plural 

- (BOOL) canBePluralized: (Word*) theWord withCase: (BOOL) subjectIsPlural
{
    if (subjectIsPlural && ![theWord.isUncountable boolValue] && ![theWord.isProperName boolValue] && ![theWord.isPlural boolValue]){
        return true;
    }
    else {
        return false;
    }
}

#pragma mark - suffix

- (NSString*) suffixCheck: (NSString*)aString
{
    NSMutableString*myString = [NSMutableString stringWithString:aString];
    if ([myString isEqualToString:@"mouse"]){
        [myString stringByReplacingOccurrencesOfString:@"mouse" withString:@"mice"];
    }
    else if ([myString hasSuffix:@"y"] && ![myString hasSuffix:@"ey"] && ![myString hasSuffix:@"ay"]) {
        [myString deleteCharactersInRange:NSMakeRange([myString length]-1, 1)];
        [myString appendString:@"ies"];
    }
    else if ([myString hasSuffix:@"s"]) {
        [myString appendString: @"es"];
    }
    else if ([myString hasSuffix:@"x"]) {
        [myString appendString: @"es"];
    }
    else {
        [myString appendString: @"s"];
    }
    return [myString copy];
}

- (NSString*) possessiveSuffixCheck: (NSString*)aString
{
    if([aString hasSuffix:@"s"]) {
            return @"'";
    }
    else {
        return @"'s";
    }
}

#pragma mark - VERB

- (NSString*) theCopulaString: (NSDictionary*)dictionary withCase: (BOOL)subjectIsPlural withContext: (NSManagedObjectContext*)context
{
    if ([[dictionary objectForKey:@"verb"] isEqualToString:@"BE"]) {
        Copula*theCopula = [Copula getCopula:context];
        if (subjectIsPlural) {
            return theCopula.presentPlural;
        }
        else {
            return theCopula.thirdPersonSingular;
        }
    }
    else {
        NSLog(@"verb error");
        return nil;
    }
}

- (NSString*) theVerbStringWithTense: (NSDictionary*)dictionary withTense: (NSString*)sentenceTense withCase: (BOOL)subjectIsPlural withWord: (Word*) theWord withContext: (NSManagedObjectContext*)context
{
    if ([sentenceTense isEqualToString:@"present"]) {
        Copula*theCopula = [Copula getCopula:context];
        if (subjectIsPlural) {
            return theCopula.presentPlural;
        }
        else {
            if ([theWord.english isEqualToString:@"I"]){
                return  theCopula.firstPersonSingular;
            }
            else if ([theWord.english isEqualToString:@"you"]){
                return  theCopula.secondPersonSingular;
            }
            else {
                return  theCopula.thirdPersonSingular;
            }
        }
    }
    else if ([sentenceTense isEqualToString:@"past"]) {
        Copula*theCopula = [Copula getCopula:context];
        if (subjectIsPlural) {
            return  theCopula.pastPlural;
        }
        else {
            if ([theWord.english isEqualToString:@"I"]){
                return  theCopula.pastSingular;
            }
            else if ([theWord.english isEqualToString:@"you"]){
                return  theCopula.pastPlural;
            }
            else {
                return  theCopula.pastSingular;
            }
        }
    }
    else {
        return @"error";
    }
}

#pragma mark - plural

- (BOOL) thePluralCheck: (NSDictionary*)dictionary withWord: (Word*) theWord
{
    if (([dictionary objectForKey:@"second_subject"] || [dictionary objectForKey:@"second_possessive"] || [theWord.isPlural boolValue]) && ![theWord.isUncountable boolValue]) {
        return true;
    }
    else {
        if([self oneInTwo] && ![theWord.isProperName boolValue] && ![theWord.isUncountable boolValue]){
            return true;
        }
        else {
            if ([theWord.isPlural boolValue]) {
                return true; //for mashed potatoes
            }
            else {
                return false;
             }
        }
    }
}

- (BOOL) thePluralCheckForObject: (NSDictionary*)dictionary withWord: (Word*) theWord
{
    if (([dictionary objectForKey:@"second_object"] || [theWord.isPlural boolValue]) && ![theWord.isUncountable boolValue]) {
        return true;
    }
    else {
        if(![theWord.isProperName boolValue] && ![theWord.isUncountable boolValue] && [theWord.isPlural boolValue]){
            return true;
        }
        else {
            if ([theWord.isPlural boolValue]) {
                return true; //for mashed potatoes
            }
            else {
                return false;
            }
        }
    }
}


#pragma mark - tense

- (NSString*) theVerbTense: (NSDictionary*)dictionary
{
    if ([dictionary objectForKey:@"hasDouble"]) {
        if ([self oneInTwo]) {
            return @"present";
        }
        else {
            return  @"past";
        }
    }
    else {
        if ([[dictionary objectForKey:@"verb"] isEqualToString:@"BE_PAST"]) {
            return @"past";
        }
        else if ([[dictionary objectForKey:@"verb"] isEqualToString:@"BE"]) {
            return @"present";
        }
        else {
            return @"error";
        }
    }
}

#pragma mark - adverb

- (NSString*) makeAdverbForTense: (NSDictionary*)dictionary withTense: (NSString*)sentenceTense
{
    if ([dictionary objectForKey:@"hasDouble"] ) {
        if ([sentenceTense isEqualToString:@"present"]) {
            return @"Everyday";
        }
        else if ([sentenceTense isEqualToString:@"past"]) {
            return  @"Yesterday";
        }
        else {
            return @"error";
        }
    }
    else {
        return @"error";
    }
}

#pragma mark - answers

- (NSString*) theAnswerComputationForPossessive: (Word*)theWord withCase: (BOOL) isPlural
{
    if (isPlural) {
        return @"Their";
    }
    else if ([theWord.gender isEqualToString:@"male"]) {
        return  @"His";
    }
    else if ([theWord.gender isEqualToString:@"female"]) {
        return @"Her";
    }
    else {
        return  @"Its";
    }
}

- (NSString*) theAnswerComputationForAccusative: (Word*)theWord withCase: (BOOL) isPlural
{
    if (isPlural) {
        return @"them";
    }
    else if ([theWord.gender isEqualToString:@"male"]) {
        return  @"him";
    }
    else if ([theWord.gender isEqualToString:@"female"]) {
        return @"her";
    }
    else {
        return  @"it";
    }
}

- (NSString*) theAnswerComputationForPronoun: (Word*)theWord withCase: (BOOL) isPlural
{
    if (isPlural) {
        return @"They";
    }
    else if ([theWord.gender isEqualToString:@"male"]) {
        return  @"He";
    }
    else if ([theWord.gender isEqualToString:@"female"]) {
        return @"She";
    }
    else {
        return  @"It";
    }
}


@end
