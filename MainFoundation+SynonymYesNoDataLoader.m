//
//  MainFoundation+SynonymYesNoDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SynonymYesNoDataLoader.h"

#import "MainFoundation+SynonymSearch.h"
#import "MainFoundation+WordSearch.h"
#import "MainFoundation+AdjectiveSearch.h"
#import "MainFoundation+SemanticTypeUtilities.h"
#import "MainFoundation+GrammarUtilities.h"

#import "Copula+Create.h"

@implementation MainFoundation (SynonymYesNoDataLoader)


//
//
////////
// writer
////////
//
//

- (NSString*) dataTransformationForNoAnswer: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    [mySentenceString appendString: @"No, "];

    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
        [mySentenceString appendString: @" not "];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"adjective"]];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

- (NSString*) dataTransformationForYesAnswer: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    [mySentenceString appendString: @"Yes, "];

    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"adjective"]];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

- (NSString*) dataTransformationForSynonymQuestion: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"adjective"]];
        [mySentenceString appendString: @"?"];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

//
//// DATA PIECE
//

- (NSArray*) setNounGroupForSynonym: (NSManagedObjectContext*) context
{
    NSString* categoryName = @"species";
    return [self shuffleArray:[self wordListFromSemanticTypeName:categoryName withContext:context]];
}

- (NSString*) setAdjectiveGroupName: (NSManagedObjectContext*) context {
    NSArray*synonymListArray = [self shuffleArray:[self completeSynonymClassList:context]];
    SynonymObjectClass* objectClass = [synonymListArray firstObject];
    
    // return @"size+";
    return objectClass.name;
}

- (NSArray*) setSynonymGroupForSynonym:(NSString*) withType withContext: (NSManagedObjectContext*) context
{
    return [self shuffleArray:[self selectSynonymWordFromClassName:withType withContext:context]];
}

//
//// MAIN ARG
//

- (NSArray*) myDataLoaderForSynonyms:(NSString*)synonymType withContext: (NSManagedObjectContext*) context
{
    NSArray* myNounArray = [self setNounGroupForSynonym:context];
    NSArray* myAdjectiveArray = [self setSynonymGroupForSynonym:synonymType withContext:context];
    NSDictionary*myDictionary = [self sentenceBuilderForSynonymYesNo:myNounArray withAdjectiveGroup:myAdjectiveArray withContext:context];

    NSString*question = [self dataTransformationForSynonymQuestion:myDictionary];
    NSString*yesAnswer = [self dataTransformationForYesAnswer:myDictionary];
    NSString*noAnswer = [self dataTransformationForNoAnswer:myDictionary];

    // question
    // yes
    // no
    
    return @[question,yesAnswer,noAnswer];
}

//
//// DATA INPUT
//

- (NSDictionary*) sentenceBuilderForSynonymYesNo: (NSArray*)myNounGroup withAdjectiveGroup: (NSArray*) myAdjectiveGroup withContext: (NSManagedObjectContext*) context
{

    //
    // subject
    //
    
    Word*subjectWord;
    subjectWord = [myNounGroup firstObject];

    //
    // string
    //
    
    NSMutableString* theSubjectString = [NSMutableString stringWithFormat:@""];
    theSubjectString = [subjectWord.english mutableCopy];
    
    //
    // subject plural and suffix
    //
    
    bool subjectIsPlural = false;
    subjectIsPlural = [self simplePluralityTest:subjectWord];
    if ([self canBePluralized:subjectWord withCase:subjectIsPlural]){
        theSubjectString = [[self suffixCheck:subjectWord.english]mutableCopy];
    }
    
    //
    // determiner added to string
    //
    
    theSubjectString = [[self suffixCheck:[theSubjectString copy]] mutableCopy];
    
    //
    //verb
    //
    
    Copula*theCopula = [Copula getCopula:context];
    
    NSString*theVerbString;
    theVerbString = theCopula.presentPlural;

    //
    // adjective
    //
    
    SynonymWordClass* synonymWord = [myAdjectiveGroup firstObject];
    NSString* theSynonymString = synonymWord.name;
    
    return @{@"subject":theSubjectString,
             @"verb":theVerbString,
             @"adjective":theSynonymString};
    
}

@end
