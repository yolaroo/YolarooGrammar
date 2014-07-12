//
//  MainFoundation+PronounDataLoaders.m
//  YolarooGrammar
//
//  Created by MGM on 5/2/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+PronounDataLoaders.h"

#import "MainFoundation+WordSearch.h"
#import "MainFoundation+AdjectiveSearch.h"
#import "Copula+Create.h"
#import "MainFoundation+SentenceUtility.h"

#import "MainFoundation+GrammarUtilities.h"

@implementation MainFoundation (PronounDataLoaders)

#define DK 2
#define LOG if(DK == 1)



//
//
////////
// view maker
////////
//
//

- (NSArray*) buttonViewFromCaseForPronoun:(NSInteger)myNumber
{
    switch (myNumber) {
        case 0:
            return @[@"It",@"They",@"-",@"-"];
            break;
        case 1:
            return @[@"It",@"They",@"-",@"-"];
            break;
        case 2:
            return @[@"It",@"They",@"-",@"-"];
            break;
        case 3:
            return @[@"It",@"They",@"-",@"-"];
            break;
        case 4:
            return @[@"It",@"They",@"-",@"-"];
            break;
        case 5:
            return @[@"He",@"She",@"-",@"-"];
            break;
        case 6:
            return @[@"He",@"She",@"It",@"They"];
            break;
        default:
            return @[@"He",@"She",@"It",@"They"];
            break;
    }
}

- (NSDictionary*) theDataSetFromCaseForPronoun:(NSInteger)myNumber withContext: (NSManagedObjectContext*) context
{
    switch (myNumber) {
        case 0:
            return [self sentenceForPronounExercise:0 withContext: context];
            break;
        case 1:
            return [self sentenceForPronounExercise:1 withContext: context];
            break;
        case 2:
            return [self sentenceForPronounExercise:2 withContext:context];
            break;
        case 3:
            return [self sentenceForPronounExercise:3 withContext: context];
            break;
        case 4:
            return [self sentenceForPronounExercise:4 withContext: context];
            break;
        case 5:
            return [self sentenceForPronounExercise:5 withContext: context];
            break;
        case 6:
            if([self oneInTen]){
                return [self sentenceForPronounExercise:7 withContext: context];
            }
            else {
                return [self sentenceForPronounExercise:6 withContext:context];
            }
            break;
        default:
            return [self sentenceForPronounExercise:0 withContext: context];
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

- (NSArray*) dataTransformationForPronoun: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    NSMutableString*myBottomString = [NSMutableString stringWithFormat:@" "];
    if ([dictionary objectForKey:@"determiner"]){
        [myTopString appendString:[dictionary objectForKey:@"determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [myTopString appendString: @"  "];
        [myTopString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"second_subject"]){
        [myTopString appendString: @" and "];
        [myTopString appendString:[dictionary objectForKey:@"second_subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [myBottomString appendString: @"______ "];
        [myBottomString appendString:[dictionary objectForKey:@"verb"]];

        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"adjective"]];

        [myBottomString appendString: @" "];
        [myBottomString appendString:[dictionary objectForKey:@"adjective"]];
    }
    return @[[self sentenceSpaceFixer:[myTopString copy] withCaps:true],[self sentenceSpaceFixer:[myBottomString copy] withCaps:true],[self myReformedAnswer:[self sentenceSpaceFixer:[myBottomString copy] withCaps:true] withNewPart:[dictionary objectForKey:@"thePronoun"]],[dictionary objectForKey:@"thePronoun"]];
}

//
//
////////
// composition
////////
//
//

- (NSDictionary*) sentenceForPronounExercise: (NSInteger)number withContext: (NSManagedObjectContext*) context
{
    NSDictionary* sentence01 = @{@"subject":@"farm animals",
                                 @"verb":@"BE",
                                 @"adjective":@"elementary"};
    
    NSDictionary* sentence02 = @{@"subject":@"shapes",
                                 @"verb":@"BE",
                                 @"adjective":@"color"};
    
    NSDictionary* sentence03 = @{@"subject":@"farm animals",
                                 @"verb":@"BE",
                                 @"adjective":@"common copular"};
    
    NSDictionary* sentence04 = @{@"subject":@"food",
                                 @"verb":@"BE",
                                 @"adjective":@"taste and smell"};
    
    NSDictionary* sentence05 = @{@"subject":@"farm animals",
                                 @"verb":@"BE",
                                 @"adjective":@"common copular"};
    
    NSDictionary* sentence06 = @{@"subject":[self myCommonPeople],
                                 @"verb":@"BE",
                                 @"adjective":@"common copular"};

    NSDictionary* sentence07 = @{@"subject":[self myCommonSubject],
                                 @"verb":@"BE",
                                 @"adjective":@"common copular"};
    
    NSDictionary* sentence08 = @{@"subject":[self myCommonSubject],
                                 @"second_subject": [self myCommonSubject],
                                 @"verb":@"BE",
                                 @"adjective":@"common copular"};
    
    NSArray*myDictionaryArray = @[sentence01,sentence02,sentence03,sentence04,sentence05,sentence06,sentence07,sentence08];
    if (number  >  [myDictionaryArray count] || number < 0 ) {
        number = 0;
    }
    return [self sentenceBuilderForPronoun:[myDictionaryArray objectAtIndex:number] withContext:context];
}


//
//
////////
// grammar
////////
//
//

- (NSDictionary*) sentenceBuilderForPronoun: (NSDictionary*)dictionary withContext: (NSManagedObjectContext*) context
{
    //
    //subject 01
    //
    
    Word*theWordSubject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"subject"] withContext:context]] firstObject];
    
    NSMutableString* mySubject = [NSMutableString stringWithFormat:@""];
    mySubject = [theWordSubject.english mutableCopy];
    
    //
    //determiner
    //
    
    NSString* theDeterminer;
    theDeterminer = [self setMyDeterminer:theWordSubject];
    
    //
    //subject 02
    //
    
    Word*theSecondWord;
    NSMutableString* mySecondSubject = [NSMutableString stringWithFormat:@""];
    NSString* theSecondDeterminer;

    if ([dictionary objectForKey:@"second_subject"]) {
        theSecondWord =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"subject"] withContext:context]] firstObject];
        mySecondSubject = [theSecondWord.english mutableCopy];

        //
        // the determiner
        //
        
        theSecondDeterminer = [self setMyDeterminer:theSecondWord];

    }
    
    //
    //plural and suffix
    //
    
    bool subjectIsPlural = false;
    
    subjectIsPlural = [self thePluralCheck:dictionary withWord:theWordSubject];
    if ([self canBePluralized:theWordSubject withCase:subjectIsPlural]){
        mySubject = [[self suffixCheck:theWordSubject.english]mutableCopy];
    }
        
    //
    //verb
    //
    
    NSString*theVerb;
    theVerb = [self theCopulaString:dictionary withCase:subjectIsPlural withContext:context];

    //
    //adjective
    //
    
    AdjectiveClass*theAdjective = [[self shuffleArray:[self selectedAdjectiveListFromSemanticTypeWithName:[dictionary objectForKey:@"adjective"] withContext:context]]firstObject];
    
    //
    /// answer - pronoun - for pronoun
    //
    
    NSString*thePronoun;
    thePronoun = [self theAnswerComputationForPronoun:theWordSubject withCase:subjectIsPlural];
    
    //
    //return
    //
    
    if ([dictionary objectForKey:@"second_subject"]){
        return @{@"determiner":theDeterminer,
                 @"subject":mySubject,
                 @"second_determiner":theSecondDeterminer,
                 @"second_subject":mySecondSubject,
                 @"verb":theVerb,
                 @"adjective":theAdjective.basic,
                 @"thePronoun":thePronoun};
    }
    else {
        return @{@"determiner":theDeterminer,
                 @"subject":mySubject,
                 @"verb":theVerb,
                 @"adjective":theAdjective.basic,
                 @"thePronoun":thePronoun};
    }
}

@end
