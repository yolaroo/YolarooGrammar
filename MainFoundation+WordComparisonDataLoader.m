//
//  MainFoundation+WordComparisonDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+WordComparisonDataLoader.h"

#import "MainFoundation+WordSearch.h"
#import "MainFoundation+AdjectiveSearch.h"

#import "Copula+Create.h"
#import "MainFoundation+SentenceUtility.h"
#import "MainFoundation+SemanticTypeUtilities.h"

#import "MainFoundation+GrammarUtilities.h"

#import "ComparisonObject+Create.h"

@implementation MainFoundation (WordComparisonDataLoader)

#define DK 2
#define LOG if(DK == 1)

//
//// comparison builder
//

- (void) setMyComparisonDataClass: (NSArray*)myComparisonClassData withWinnerString: (NSString*)theWinner withSentenceString:(NSString*) fullString withContext:(NSManagedObjectContext*) context
{
    if ([myComparisonClassData count] && [theWinner length] && [fullString length]) {
        ComparisonObject*myComparisonObject = [ComparisonObject comparisonWithName:[myComparisonClassData lastObject] withContext:context];
        
        myComparisonObject.term1 = [myComparisonClassData objectAtIndex:1];
        myComparisonObject.term2 = [myComparisonClassData objectAtIndex:2];
        myComparisonObject.adjective = [myComparisonClassData firstObject];
        
        myComparisonObject.winner = theWinner;
        
        if ([fullString isEqualToString:@" - "]) {
            myComparisonObject.sentence = [NSString stringWithFormat:@"%@ - %@ or %@?",[myComparisonClassData firstObject],[myComparisonClassData objectAtIndex:1],[myComparisonClassData objectAtIndex:2]];
        }
        else {
            myComparisonObject.sentence = fullString;
        }
        
        NSInteger myCount = [myComparisonObject.count intValue];
        myCount++;
        myComparisonObject.count = [NSNumber numberWithInteger:myCount];
        
        [self saveData:context];
        
        LOG NSLog(@"- (object name) %@ - ",myComparisonObject.name);

    }
    // adjective - 01
    // wrd01 - 02
    // wrd02 - 03
    // name - 04
}

//
//// data loader - random/specific
//

- (NSArray*) myDataLoaderForComparisons: (NSArray*) myAdjective withContext:(NSManagedObjectContext*) context
{
    NSArray* myNoun = [self setNounGroupForComparison:context];

    if (![myAdjective  isEqual: @[]]){
        LOG NSLog(@"bypass");
    }
    else {
        myAdjective = [self setAdjectiveGroup:context];
    }

    NSDictionary* myData = [self sentenceBuilderForSimpleTokenType:myNoun withAdjectiveGroup:myAdjective withContext:context];

    //
    ////
    //
    
    NSString* firstIsBigger = [self firstWordIsBiggerWriter:myData]; // answer 01
    NSArray* myQuestionArray = [self setQuestionArray:myData]; // buttons
    NSString* myQuestionString = [self setQuestionString:myData]; // label

    NSString* myAdjectiveString = [self setMyAdjective:myData];
    NSArray* comparisonClass = [self setMyComparisonObjectClass:myAdjectiveString withMyWords:myQuestionArray]; //comparison
    LOG NSLog(@"3b");

    NSString* secondIsBigger = [self secondWordIsBiggerWriter:myData]; // answer 02
    LOG NSLog(@"4b");

    return @[firstIsBigger,myQuestionArray,myQuestionString,comparisonClass,myAdjectiveString,secondIsBigger];
    
    // first answer - first object
    // second answer - last object
    
    // button - 01
    // label (question) - 02
    // comparison - 03
}

//
////
//

- (NSArray*) setMyComparisonObjectClass: (NSString*) myAdjective withMyWords: (NSArray*) myWordArray
{    
    // NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    // sortedArray=[anArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    NSArray* sortedArray = [myWordArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    NSMutableString*myQuestionString = [NSMutableString stringWithFormat:@" "];
    [myQuestionString appendString: myAdjective];
    [myQuestionString appendString: [sortedArray firstObject]];
    [myQuestionString appendString: [sortedArray lastObject]];
    myQuestionString = [[self zeroSpaceFixer:[myQuestionString copy]] mutableCopy];
    
    return @[myAdjective,[sortedArray firstObject],[sortedArray lastObject],[myQuestionString copy]];
    
    // adjective - 01
    // wrd01 - 02
    // wrd02 - 03
    // name - 04s
}

- (NSString*) setMyAdjective:(NSDictionary*) dictionary
{
    if ([dictionary objectForKey:@"adjective"]){
        return [dictionary objectForKey:@"adjective"];
    }
    else {
        return @"error";
    }
}

- (NSString*) setQuestionString:(NSDictionary*) dictionary {
    NSMutableString*myQuestionString = [NSMutableString stringWithFormat:@" "];
    [myQuestionString appendString: @"What is "];
    if ([dictionary objectForKey:@"adjective"]){
        [myQuestionString appendString:[dictionary objectForKey:@"adjective"] ];
        [myQuestionString appendString: @"?"];
    }
    return [myQuestionString copy];
}

- (NSArray*) setQuestionArray:(NSDictionary*) dictionary {
    NSMutableArray*questionArray = [[NSMutableArray alloc]init];
    if ([dictionary objectForKey:@"word01"]){
        [questionArray addObject:[dictionary objectForKey:@"word01"]];
    }
    if ([dictionary objectForKey:@"word02"]){
        [questionArray addObject:[dictionary objectForKey:@"word02"]];
    }
    return [questionArray copy];
}

//
////
//

- (NSString*) firstWordIsBiggerWriter: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    
    if ([dictionary objectForKey:@"determiner01"]){
        [myTopString appendString:[dictionary objectForKey:@"determiner01"]];
    }
    if ([dictionary objectForKey:@"word01"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"word01"]];
    }
    if ([dictionary objectForKey:@"verb01"]){
        [myTopString appendString: @" "];
        [myTopString appendString: [dictionary objectForKey:@"verb01"]];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"adjective"]];
        [myTopString appendString: @" than "];
    }
    if ([dictionary objectForKey:@"determiner02"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"determiner02"]];
    }
    if ([dictionary objectForKey:@"word02"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"word02"]];
    }
    return [self sentenceSpaceFixer:[myTopString copy] withCaps:true];
}

- (NSString*) secondWordIsBiggerWriter: (NSDictionary*) dictionary
{
    NSMutableString*myTopString = [NSMutableString stringWithFormat:@" "];
    
    if ([dictionary objectForKey:@"determiner02"]){
        [myTopString appendString:[dictionary objectForKey:@"determiner02"]];
    }
    if ([dictionary objectForKey:@"word02"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"word02"]];
    }
    if ([dictionary objectForKey:@"verb02"]){
        [myTopString appendString: @" "];
        [myTopString appendString: [dictionary objectForKey:@"verb02"]];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"adjective"]];
        [myTopString appendString: @" than "];
    }
    if ([dictionary objectForKey:@"determiner01"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"determiner01"]];
    }
    if ([dictionary objectForKey:@"word01"]){
        [myTopString appendString: @" "];
        [myTopString appendString:[dictionary objectForKey:@"word01"]];
    }
    return [self sentenceSpaceFixer:[myTopString copy] withCaps:true];
}

//
////
//

- (NSArray*) setNounGroupForComparison: (NSManagedObjectContext*) context
{
    NSString* categoryName = @"species";
    return[self shuffleArray:[self wordListFromSemanticTypeName:categoryName withContext:context]];
}

- (NSArray*) setAdjectiveGroup: (NSManagedObjectContext*) context
{
    NSString* adjectiveName = @"basic comparison measurement";
    return  [self shuffleArray:[self selectedAdjectiveListFromSemanticTypeWithName:adjectiveName withContext:context]];
}

- (NSDictionary*) sentenceBuilderForSimpleTokenType: (NSArray*)myNounGroup withAdjectiveGroup: (NSArray*) myAdjectiveGroup withContext: (NSManagedObjectContext*) context
{
    Word*theWord01;
    theWord01 = [myNounGroup firstObject];
    Word*theWord02;
    theWord02 =[myNounGroup lastObject];
    
    //
    // string
    //

    NSMutableString* word01String = [NSMutableString stringWithFormat:@""];
    NSMutableString* word02String = [NSMutableString stringWithFormat:@""];
    word01String = [theWord01.english mutableCopy];
    word02String = [theWord02.english mutableCopy];
    
    //
    // determiner
    //
    
    NSString* theDeterminer01;
    theDeterminer01 = [self setIndefiniteDeterminer:theWord01];
    NSString* theDeterminer02;
    theDeterminer02 = [self setIndefiniteDeterminer:theWord02];

    //
    // subject plural and suffix
    //
    
    bool subject01IsPlural = false;
    subject01IsPlural = [self simplePluralityTest:theWord01];
    if ([self canBePluralized:theWord01 withCase:subject01IsPlural]){
        word01String = [[self suffixCheck:theWord01.english]mutableCopy];
    }

    bool subject02IsPlural = false;
    subject02IsPlural = [self simplePluralityTest:theWord02];
    if ([self canBePluralized:theWord02 withCase:subject02IsPlural]){
        word02String = [[self suffixCheck:theWord02.english]mutableCopy];
    }
    
    //
    //verb
    //

    Copula*theCopula = [Copula getCopula:context];

    NSString*theVerb01;
    if (subject01IsPlural) {
        theVerb01 = theCopula.presentPlural;
    }
    else {
        theVerb01 = theCopula.thirdPersonSingular;
    }

    NSString*theVerb02;
    if (subject02IsPlural) {
        theVerb02 = theCopula.presentPlural;
    }
    else {
        theVerb02 = theCopula.thirdPersonSingular;
    }
    
    //
    //adjective
    //
    
    AdjectiveClass*theAdjectiveClass = [myAdjectiveGroup firstObject];

    NSString* theAdjective;
    if ([theAdjectiveClass.comparative isEqualToString:@"more"]){
        theAdjective = [NSString stringWithFormat:@"more %@",theAdjectiveClass.basic];
    }
    else {
        theAdjective = theAdjectiveClass.comparative;
    }
    
    return @{@"determiner01":theDeterminer01,
             @"word01":[word01String copy],
             @"determiner02":theDeterminer02,
             @"word02":[word02String copy],
             @"verb01":theVerb01,
             @"verb02":theVerb02,
             @"adjective":theAdjective};
}

@end
