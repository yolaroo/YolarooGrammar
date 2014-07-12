//
//  MainFoundation+PossessiveDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+PossessiveDataLoader.h"

#import "MainFoundation+SentenceUtility.h"
#import "MainFoundation+GrammarUtilities.h"

#import "MainFoundation+WordSearch.h"

#import "Copula+Create.h"
#import "MainFoundation+AdjectiveSearch.h"

@implementation MainFoundation (PossessiveDataLoader)

#define DK 2
#define LOG if(DK == 1)

//
//
////////
// composition
////////
//
//

- (NSDictionary*) sentenceForPossessiveExercise: (NSInteger)number withContext: (NSManagedObjectContext*) context
{
    NSDictionary* sentence00;
    NSDictionary* sentence01;
    NSDictionary* sentence02;

    sentence00 = @{@"possessive":@"farm animals",
                   @"subject":@"food",
                   @"verb":@"BE",
                   @"adjective":@"taste and smell"};
    
    sentence01 = @{@"possessive":[self myCommonPeople],
                   @"subject":@"pets",
                   @"verb":@"BE",
                   @"adjective":@"common copular"};
    
    if ([self oneInTwo]){
        LOG NSLog(@"**first**");
        sentence02 = @{@"possessive":[self myCommonSubject],
                       @"subject":@"common possessions",
                       @"verb":@"BE",
                       @"adjective":@"common copular"};
    }
    else {
        LOG NSLog(@"**second**");
        sentence02 = @{@"possessive":@"boy's names",
                       @"second_possessive":@"girl's names",
                       @"subject":@"common possessions",
                       @"verb":@"BE",
                       @"adjective":@"common copular"};
    }
    
    NSArray*myDictionaryArray = @[sentence00,sentence01,sentence02];
    if (number  >  [myDictionaryArray count] || number < 0 ) {
        number = 0;
    }
    return [self sentenceBuilderForPossessive:[myDictionaryArray objectAtIndex:number] withContext:context];
}

//
//
////////
// view maker
////////
//
//

- (NSArray*) buttonViewFromCaseForPossessive:(NSInteger)myNumber
{
    switch (myNumber) {
        case 0:
            return @[@"Its",@"Their",@"-",@"-"];
            break;
        case 1:
            return @[@"His",@"Her",@"-",@"-"];
            break;
        case 2:
            return @[@"Its",@"Their",@"His",@"Her"];
            break;
        default:
            return @[@"Its",@"Their",@"Him",@"Her"];
            break;
    }
}


- (NSDictionary*) theDataSetFromCaseForPossessive:(NSInteger)myNumber withContext: (NSManagedObjectContext*) context
{
    switch (myNumber) {
        case 0:
            return [self sentenceForPossessiveExercise:0 withContext: context];
            break;
        case 1:
            return [self sentenceForPossessiveExercise:1 withContext: context];
            break;
        case 2:
            return [self sentenceForPossessiveExercise:2 withContext: context];
            break;
        default:
            return [self sentenceForPossessiveExercise:0 withContext: context];
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

- (NSArray*) dataTransformationForPossessive: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    NSMutableString*myBottomString = [NSMutableString stringWithFormat:@" "];
    NSMutableString*myAnswerString = [NSMutableString stringWithFormat:@" "];

    if ([dictionary objectForKey:@"determiner"]){
        [myTopString appendString:[dictionary objectForKey:@"determiner"]];
        [myTopString appendString: @"  "];
    }
    
    if ([dictionary objectForKey:@"possessive"]){
        [myTopString appendString:[dictionary objectForKey:@"possessive"]];
        [myTopString appendString: [self possessiveSuffixCheck:[dictionary objectForKey:@"possessive"]]];
        [myBottomString appendString: @" ______ "];
    }
    if ([dictionary objectForKey:@"thePronoun"]){
        [myAnswerString appendString:[dictionary objectForKey:@"thePronoun"]];
    }
    
    if ([dictionary objectForKey:@"second_possessive"]){
        [myTopString appendString: @" and "];
        [myTopString appendString:[dictionary objectForKey:@"second_possessive"]];
        [myTopString appendString: [self possessiveSuffixCheck:[dictionary objectForKey:@"second_possessive"]]];
    }
    
    if ([dictionary objectForKey:@"subject"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"subject"]];
        [myBottomString appendString: @" "];
        [myBottomString appendString:[dictionary objectForKey:@"subject"]];
        [myAnswerString appendString:@" "];
        [myAnswerString appendString:[dictionary objectForKey:@"subject"]];
    }
    
    if ([dictionary objectForKey:@"verb"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"verb"]];
        [myBottomString appendString: @" "];
        [myBottomString appendString:[dictionary objectForKey:@"verb"]];
        [myAnswerString appendString:@" "];
        [myAnswerString appendString:[dictionary objectForKey:@"verb"]];
    }

    if ([dictionary objectForKey:@"adjective"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"adjective"]];
        [myBottomString appendString: @" "];
        [myBottomString appendString:[dictionary objectForKey:@"adjective"]];
        [myAnswerString appendString:@" "];
        [myAnswerString appendString:[dictionary objectForKey:@"adjective"]];
    }
    
    return @[[self sentenceSpaceFixer:[myTopString copy] withCaps:true],[self sentenceSpaceFixer:[myBottomString copy] withCaps:true],[self sentenceSpaceFixer:[myAnswerString copy] withCaps:true],[dictionary objectForKey:@"thePronoun"]];
}

//
//
////////
// grammar
////////
//
//

- (NSDictionary*) sentenceBuilderForPossessive: (NSDictionary*)dictionary withContext: (NSManagedObjectContext*) context
{
    //
    //possessive
    //
    Word*theWordPossessive =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"possessive"] withContext:context]] firstObject];
    
    NSMutableString* myPossessive = [NSMutableString stringWithFormat:@""];
    myPossessive = [theWordPossessive.english mutableCopy];
    
    LOG NSLog(@"(possessive) %@",myPossessive);
    
    //
    // possessive plural and suffix
    //
    
    bool possessiveIsPlural = false;
    possessiveIsPlural = [self thePluralCheck:dictionary withWord:theWordPossessive];
    if ([self canBePluralized:theWordPossessive withCase:possessiveIsPlural]){
        myPossessive = [[self suffixCheck:theWordPossessive.english]mutableCopy];
    }

    //
    //possessive determiner
    //
    
    NSString* theDeterminer;
    theDeterminer = [self setMyDeterminer:theWordPossessive];

    //
    //second possessive
    //
    
    NSMutableString* mySecondPossessive = [NSMutableString stringWithFormat:@""];
    if ([dictionary objectForKey:@"second_possessive"]) {
        Word*theWordSecondPossessive =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"second_possessive"] withContext:context]] firstObject];
        
        mySecondPossessive = [theWordSecondPossessive.english mutableCopy];
        
        LOG NSLog(@"(second possessive) %@",mySecondPossessive);
        
        //
        //second possessive plural and suffix
        //
        
        bool secondPossessiveIsPlural = false;
        secondPossessiveIsPlural = [self thePluralCheck:dictionary withWord:theWordSecondPossessive];
        if ([self canBePluralized:theWordSecondPossessive withCase:secondPossessiveIsPlural]){
            mySecondPossessive = [[self suffixCheck:theWordSecondPossessive.english]mutableCopy];
        }
    }

    //
    //subject
    //
    
    Word*theWordSubject =[[self shuffleArray:[self wordListFromSemanticTypeName:[dictionary objectForKey:@"subject"] withContext:context]] firstObject];


    NSMutableString* mySubject = [NSMutableString stringWithFormat:@""];
    mySubject = [theWordSubject.english mutableCopy];

    LOG NSLog(@"(mySubject) %@",mySubject);

    //
    // subject plural and suffix
    //

    bool subjectIsPlural = false;
    subjectIsPlural = [self thePluralCheck:dictionary withWord:theWordSubject];
    if ([self canBePluralized:theWordSubject withCase:subjectIsPlural]){
        mySubject = [[self suffixCheck:theWordSubject.english]mutableCopy];
    }

    LOG subjectIsPlural ? NSLog(@"plural") : NSLog(@"NOT plural");
    
    //
    //verb
    //
    
    NSString*theVerb = [self theCopulaString:dictionary withCase:subjectIsPlural withContext:context];

    LOG NSLog(@"(possessive theVerb) %@",theVerb);

    //
    //adjective
    //
    
    AdjectiveClass*theAdjective = [[self shuffleArray:[self selectedAdjectiveListFromSemanticTypeWithName:[dictionary objectForKey:@"adjective"] withContext:context]]firstObject];
    
    LOG NSLog(@"(possessive theAdjective) %@",theAdjective.basic);

    //
    /// answer - pronoun - for possesive
    //
    
    NSString*thePronoun;
    
    if ([dictionary objectForKey:@"second_possessive"]){
        possessiveIsPlural = true;
    }
    thePronoun = [self theAnswerComputationForPossessive:theWordPossessive withCase:possessiveIsPlural];
    LOG NSLog(@"(possessive thePronoun) %@",thePronoun);

    //
    //return
    //
    
    if ([dictionary objectForKey:@"second_possessive"]) {
        return @{@"determiner":theDeterminer,
                 @"possessive":myPossessive,
                 @"second_possessive":mySecondPossessive,
                 @"subject":mySubject,
                 @"verb":theVerb,
                 @"adjective":theAdjective.basic,
                 @"thePronoun":thePronoun};
    }
    else {
        return @{@"determiner":theDeterminer,
                 @"possessive":myPossessive,
                 @"subject":mySubject,
                 @"verb":theVerb,
                 @"adjective":theAdjective.basic,
                 @"thePronoun":thePronoun};
    }
}

@end
