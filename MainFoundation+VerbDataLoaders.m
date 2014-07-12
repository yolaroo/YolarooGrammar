//
//  MainFoundation+VerbDataLoaders.m
//  YolarooGrammar
//
//  Created by MGM on 5/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+VerbDataLoaders.h"

#import "MainFoundation+GrammarUtilities.h"

#import "MainFoundation+WordSearch.h"
#import "MainFoundation+AdjectiveSearch.h"
#import "Copula+Create.h"
#import "MainFoundation+SentenceUtility.h"

@implementation MainFoundation (VerbDataLoaders)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
// cases
////////
//
//

- (NSDictionary*) theDataSetFromCaseForVerb:(NSInteger)myNumber withContext: (NSManagedObjectContext*)context
{
    switch (myNumber) {
        case 0:
            return [self sentenceForVerbExercise:0 withContext: context];
            break;
        case 1:
            return [self sentenceForVerbExercise:1 withContext: context];
            break;
        case 2:
            return [self sentenceForVerbExercise:2 withContext: context];
            break;
        case 3:
            return [self sentenceForVerbExercise:3 withContext: context];
            break;
        case 4:
            return [self sentenceForVerbExercise:4 withContext: context];
            break;
        case 5:
            return [self sentenceForVerbExercise:5 withContext: context];
            break;
        case 6:
            return [self sentenceForVerbExercise:6 withContext: context];
            break;
        case 7:
            return [self sentenceForVerbExercise:7 withContext: context];
            break;
        case 8:
            return [self sentenceForVerbExercise:8 withContext: context];
            break;
        case 9:
            return [self sentenceForVerbExercise:9 withContext: context];
            break;
        case 10:
            return [self sentenceForVerbExercise:10 withContext: context];
            break;
        case 11:
            return [self sentenceForVerbExercise:11 withContext: context];
            break;
        case 12:
            return [self sentenceForVerbExercise:12 withContext: context];
            break;
        default:
            return [self sentenceForVerbExercise:0 withContext: context];
            break;
    }
}

//
//
////////
// data for writer
////////
//
//

- (NSArray*) dataTransformationForVerb: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    
    if ([dictionary objectForKey:@"adverb"]){
        if ([[dictionary objectForKey:@"adverb"] length]){
            [myTopString appendString:[dictionary objectForKey:@"adverb"]];
            [myTopString appendString: @" , "];
        }
    }
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
        [myTopString appendString: @" ______ "];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"adjective"]];
    }
    LOG NSLog(@"--  %@ --",[myTopString copy]);
    
    return @[[self sentenceSpaceFixer:[myTopString copy] withCaps:true],[self myReformedAnswer:[self sentenceSpaceFixer:[myTopString copy] withCaps:true] withNewPart:[dictionary objectForKey:@"verb"]],[dictionary objectForKey:@"verb"]];
}

- (NSArray*) buttonViewFromCaseForVerbs:(NSInteger)myNumber
{
    switch (myNumber) {
        case 0:
            return @[@"is",@"are",@"-",@"-",@"-"];
            break;
        case 1:
            return @[@"is",@"are",@"-",@"-",@"-"];
            break;
        case 2:
            return @[@"is",@"are",@"-",@"-",@"-"];
            break;
        case 3:
            return @[@"is",@"are",@"-",@"-",@"-"];
            break;
        case 4:
            return @[@"is",@"are",@"-",@"-",@"-"];
            break;
        case 5:
            return @[@"is",@"are",@"am",@"-",@"-"];
            break;
        case 6:
            return @[@"is",@"are",@"am",@"-",@"-"];
            break;
        case 7:
            return @[@"was",@"were",@"-",@"-",@"-"];
            break;
        case 8:
            return @[@"was",@"were",@"-",@"-",@"-"];
            break;
        case 9:
            return @[@"was",@"were",@"-",@"-",@"-"];
            break;
        case 10:
            return @[@"is",@"are",@"am",@"was",@"were"];
            break;
        case 11:
            return @[@"is",@"are",@"am",@"was",@"were"];
            break;
        case 12:
            return @[@"is",@"are",@"am",@"was",@"were"];
            break;
        default:
            return @[@"is",@"are",@"am",@"was",@"were"];
            break;
    }
}

//
//
////////
// sentences
////////
//
//

- (NSDictionary*) sentenceForVerbExercise: (NSInteger)number withContext: (NSManagedObjectContext*) context
{
    NSDictionary* sentence00;
    NSDictionary* sentence01;
    NSDictionary* sentence02;
    NSDictionary* sentence03;
    NSDictionary* sentence04;
    NSDictionary* sentence05;
    NSDictionary* sentence06;
    NSDictionary* sentence07;
    NSDictionary* sentence08;
    NSDictionary* sentence09;
    NSDictionary* sentence10;
    NSDictionary* sentence11;
    NSDictionary* sentence12;
    
    sentence00 = @{ @"subject":@"farm animals",
                    @"verb":@"BE",
                    @"adjective":@"elementary"};
    
    sentence01 = @{ @"subject":@"shapes",
                    @"verb":@"BE",
                    @"adjective":@"color"};
    
    sentence02 = @{ @"subject":@"farm animals",
                    @"verb":@"BE",
                    @"adjective":@"common copular"};
    
    sentence03 = @{ @"subject":@"food",
                    @"verb":@"BE",
                    @"adjective":@"taste and smell"};
    
    if([self oneInFour]){
        sentence04 = @{ @"subject":@"boy's names",
                        @"second_subject":@"girl's names",
                        @"verb":@"BE",
                        @"adjective":@"common copular"};
        LOG NSLog(@"true");

    }
    else {
        sentence04 = @{ @"subject":[self myVerbSubjectSimple],
                        @"verb":@"BE",
                        @"adjective":@"common copular"};

    }
    
    sentence05 = @{ @"subject":[self myVerbSubjectPronouns],
                    @"verb":@"BE",
                    @"adjective":@"common copular"};
    
    sentence06 = @{ @"subject":[self myVerbSubjectComplex],
                    @"verb":@"BE",
                    @"adjective":@"common copular"};
    
    sentence07 = @{ @"subject":@"farm animals",
                    @"verb":@"BE_PAST",
                    @"adjective":@"elementary"};
    
    sentence08 = @{ @"subject":@"shapes",
                    @"verb":@"BE_PAST",
                    @"adjective":@"color"};
    
    sentence09 = @{ @"subject":@"farm animals",
                    @"verb":@"BE_PAST",
                    @"adjective":@"common copular"};
    
    sentence10 = @{ @"hasDouble":@"true",
                    @"subject":[self myVerbSubjectSimple],
                    @"verb":@"BE",
                    @"adjective":@"common copular"};
    
    sentence11 = @{ @"hasDouble":@"true",
                    @"subject":[self myVerbSubjectPronouns],
                    @"verb":@"BE",
                    @"adjective":@"common copular"};

    sentence12 = @{ @"hasDouble":@"true",
                    @"subject":[self myVerbSubjectComplex],
                    @"verb":@"BE",
                    @"adjective":@"common copular"};

    NSArray*myDictionaryArray = @[sentence00,sentence01,sentence02,sentence03,sentence04,sentence05,sentence06,sentence07,sentence08,sentence09,sentence10,sentence11,sentence12];
    if (number  >  [myDictionaryArray count] || number < 0) {
        number = 0;
    }
    return [self sentenceBuilderForVerv:[myDictionaryArray objectAtIndex:number] withContext:context];
}

//
//
////////
// grammar
////////
//
//

- (NSDictionary*) sentenceBuilderForVerv: (NSDictionary*)dictionary withContext: (NSManagedObjectContext*) context
{
    
    //
    //subject 01
    //
    
    Word*theWordSubject;
    NSArray*myPronounArray = @[@"I",@"You",@"We",@"She",@"He",@"They",@"It",@"you",@"we",@"she",@"he",@"they",@"it"];
    if ([myPronounArray containsObject:[dictionary objectForKey:@"subject"]]) {
        LOG NSLog(@"-- verb grammar: (pronoun) --");
        theWordSubject =[[self wordListFromName:[dictionary objectForKey:@"subject"] withContext:context] firstObject];
    }
    else {
        LOG NSLog(@"-- verb grammar: (NOT a pronoun) --");
        theWordSubject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"subject"] withContext:context]] firstObject];
    }
    
    if (theWordSubject == nil) {
        LOG NSLog(@"word error at nil");
        LOG NSLog(@"-- %@ --",[dictionary objectForKey:@"subject"]);
        theWordSubject =[[self wordListFromName:[dictionary objectForKey:@"tacos"] withContext:context] firstObject];
    }
    
    LOG NSLog(@"-- (word subject) %@ --",theWordSubject.english);
    
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
    
    Word*theWordSecondSubject;
    NSMutableString* mySecondSubject = [NSMutableString stringWithFormat:@""];
    NSString* theSecondDeterminer;
    
    if ([dictionary objectForKey:@"second_subject"]) {
        theWordSecondSubject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"second_subject"] withContext:context]] firstObject];
        mySecondSubject = [theWordSecondSubject.english mutableCopy];
        
        //
        //determiner
        //
        
        theSecondDeterminer = [self setMyDeterminer:theWordSecondSubject];
        LOG NSLog(@"-- verb grammar (second subject): %@ --",mySecondSubject);

    }
    
    //
    //plural and suffix
    //
    
    bool subjectIsPlural = false;
    subjectIsPlural= [self thePluralCheck:dictionary withWord:theWordSubject];
    if ([self canBePluralized:theWordSubject withCase:subjectIsPlural]){
        mySubject = [[self suffixCheck:theWordSubject.english]mutableCopy];
    }
    
    //
    //tense
    //
    
    NSString*sentenceTense;
    NSString*theAdverb;
    sentenceTense = [self theVerbTense:dictionary];

    if ([dictionary objectForKey:@"hasDouble"]){
        theAdverb = [self makeAdverbForTense:dictionary withTense:sentenceTense];
    }
    else {
        theAdverb = @"";
    }
    
    //
    /// answer - verb - for verb
    //
    
    NSString*theVerb;
    theVerb = [self theVerbStringWithTense:dictionary withTense:sentenceTense withCase:subjectIsPlural withWord:theWordSubject withContext:context];
    
    LOG NSLog(@"-- %@ --",theVerb);
    
    //
    //adjective
    //
    
    AdjectiveClass*theAdjective = [[self shuffleArray:[self selectedAdjectiveListFromSemanticTypeWithName:[dictionary objectForKey:@"adjective"] withContext:context]]firstObject];
    
    //
    //return
    //
    
    if ([dictionary objectForKey:@"second_subject"]){
        LOG NSLog(@"-- verb grammar: 4 --");

        return @{@"adverb":theAdverb,
                 @"determiner":theDeterminer,
                 @"subject":mySubject,
                 @"second_determiner":theSecondDeterminer,
                 @"second_subject":mySecondSubject,
                 @"verb":theVerb,
                 @"adjective":theAdjective.basic};
    }
    else {
        return @{@"adverb":theAdverb,
                 @"determiner":theDeterminer,
                 @"subject":mySubject,
                 @"verb":theVerb,
                 @"adjective":theAdjective.basic};
    }
}

@end
