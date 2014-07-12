//
//  MainFoundation+AntonymMatchDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+AntonymMatchDataLoader.h"

#import "MainFoundation+SynonymSearch.h"
#import "MainFoundation+WordSearch.h"
#import "MainFoundation+AdjectiveSearch.h"
#import "MainFoundation+SemanticTypeUtilities.h"
#import "MainFoundation+GrammarUtilities.h"

#import "Copula+Create.h"

@implementation MainFoundation (AntonymMatchDataLoader)

#define DK 2
#define LOG if(DK == 1)

//
//// MAIN ARG
//

- (NSArray*) myDataLoaderForAntonym: (NSManagedObjectContext*) context
{
    LOG NSLog(@"1myDataLoaderForAntonym");
    NSArray* adjectiveArray = [self setSynonymGroupForAntonym:context];
    LOG NSLog(@"2myDataLoaderForAntonym");
    NSArray* nounArray = [self setNounGroupForAntonym: context];
    LOG NSLog(@"3myDataLoaderForAntonym");
    NSDictionary* dataDictionary = [self sentenceBuilderForAntonymYesNo:nounArray withAdjectiveGroup:adjectiveArray withContext:context];
    LOG NSLog(@"4myDataLoaderForAntonym");
    NSString* mainQuestion = [self dataTransformationForAntonymQuestionFirstPart:dataDictionary];
    LOG NSLog(@"5myDataLoaderForAntonym");

    NSString* correctQuestion = [self dataTransformationForAntonymQuestionSecondPartCorrect:dataDictionary];
    NSString* falseQuestion = [self dataTransformationForAntonymQuestionSecondPartFalse:dataDictionary];

    NSString* yesAnswerSynonym = [self synonymDataTransformationForYesAnswer:dataDictionary];
    NSString* noAnswerSynonym = [self synonymDataTransformationForNoAnswer:dataDictionary];

    NSString* yesAnswerAntonym = [self antonymDataTransformationForYesAnswer:dataDictionary];
    NSString* noAnswerAntonym = [self antonymDataTransformationForNoAnswer:dataDictionary];

    LOG NSLog(@"-- (mainQuestion) %@--",mainQuestion);
    LOG NSLog(@"-- (correctQuestion) %@--",correctQuestion);
    LOG NSLog(@"-- (falseQuestion) %@--",falseQuestion);
    LOG NSLog(@"-- (yesAnswerSynonym) %@--",yesAnswerSynonym);
    LOG NSLog(@"-- (noAnswerSynonym) %@--",noAnswerSynonym);
    LOG NSLog(@"-- (yesAnswerAntonym) %@--",yesAnswerAntonym);
    LOG NSLog(@"-- (noAnswerSynonym) %@--",noAnswerAntonym);

    // question
    // correct
    // yesSyn
    // noSyn
    // yes Ant
    // no Ant
    // false
    
    return @[mainQuestion,correctQuestion,yesAnswerSynonym,noAnswerSynonym,yesAnswerAntonym,noAnswerAntonym,falseQuestion];
}

//
//// writing
//

- (NSString*) dataTransformationForAntonymQuestionFirstPart: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @"  "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @"  "];
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

- (NSString*) dataTransformationForAntonymQuestionSecondPartCorrect: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"synonym_adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"synonym_adjective"]];
        [mySentenceString appendString: @"?"];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

- (NSString*) dataTransformationForAntonymQuestionSecondPartFalse: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"antonym_adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"antonym_adjective"]];
        [mySentenceString appendString: @"?"];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

//
////
//

- (NSString*) synonymDataTransformationForYesAnswer: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    [mySentenceString appendString: @"Yes, "];
    
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"synonym_adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"synonym_adjective"]];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

- (NSString*) synonymDataTransformationForNoAnswer: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    [mySentenceString appendString: @"No, "];
    
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
        [mySentenceString appendString: @" not "];
    }
    if ([dictionary objectForKey:@"synonym_adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"synonym_adjective"]];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

//
////
//

- (NSString*) antonymDataTransformationForYesAnswer: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    [mySentenceString appendString: @"Yes, "];
    
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
    }
    if ([dictionary objectForKey:@"antonym_adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"antonym_adjective"]];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

- (NSString*) antonymDataTransformationForNoAnswer: (NSDictionary*) dictionary
{
    NSMutableString*mySentenceString = [NSMutableString stringWithFormat:@" "];
    [mySentenceString appendString: @"No, "];
    
    if ([dictionary objectForKey:@"subject_determiner"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject_determiner"]];
    }
    if ([dictionary objectForKey:@"subject"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"subject"]];
    }
    if ([dictionary objectForKey:@"verb"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"verb"]];
        [mySentenceString appendString: @" not "];
    }
    if ([dictionary objectForKey:@"antonym_adjective"]){
        [mySentenceString appendString: @" "];
        [mySentenceString appendString:[dictionary objectForKey:@"antonym_adjective"]];
    }
    return [self sentenceSpaceFixer:[mySentenceString copy] withCaps:true];
}

//
//// noun
//

- (NSArray*) setNounGroupForAntonym: (NSManagedObjectContext*) context
{
    NSString* categoryName = @"species";
    return [self shuffleArray:[self wordListFromSemanticTypeName:categoryName withContext:context]];
}

//
//// adjective pair
//

- (SynonymObjectClass*) setAntonymFirstGroupName: (NSManagedObjectContext*) context {
    return [[self shuffleArray:[self completeSynonymClassList:context]]firstObject];
}

- (SynonymObjectClass*) setAntonymSecondGroupName: (SynonymObjectClass*) synonymGroup withContext: (NSManagedObjectContext*) context {
    SynonymObjectClass* synonymObject = synonymGroup;
    return [[self shuffleArray:[self selectSynonymClassfromName:synonymObject.antonym withContext:context]]firstObject];
}

- (NSArray*) setSynonymGroupForAntonym: (NSManagedObjectContext*) context
{
    LOG NSLog(@"1setSynonymGroupForAntonym");
    SynonymObjectClass* mySynonymObject = [self setAntonymFirstGroupName:context];
    LOG NSLog(@"2setSynonymGroupForAntonym - %@",mySynonymObject.name);
    SynonymObjectClass* myAntonymObject = [self setAntonymSecondGroupName:mySynonymObject withContext:context];
    LOG NSLog(@"3setSynonymGroupForAntonym - %@",myAntonymObject.name);

    return @[mySynonymObject,myAntonymObject];
}

//
//// data Load
//

- (NSDictionary*) sentenceBuilderForAntonymYesNo: (NSArray*)myNounGroup withAdjectiveGroup: (NSArray*) myAdjectiveGroup withContext: (NSManagedObjectContext*) context
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

    
    //
    // determiner added to string
    //
    
    NSString*mySubjectDeterminer;
    mySubjectDeterminer = @"the";

    //
    //verb
    //
    
    Copula*theCopula = [Copula getCopula:context];
    
    NSString*theVerbString;
    if (subjectIsPlural){
        theVerbString = theCopula.presentPlural;
    }
    else {
        theVerbString = theCopula.thirdPersonSingular;
    }
    //
    // adjective
    //
    
    SynonymObjectClass* adjectiveObjectClass = [myAdjectiveGroup firstObject];
    LOG NSLog(@"-- (class name) %@ --",adjectiveObjectClass.name);

    NSArray* synonymGroup = [self setSynonymWordForAntonym:adjectiveObjectClass.name withContext:context];
    
    SynonymWordClass* adjectiveWord = [synonymGroup firstObject];
    NSString* theAdjectiveString = adjectiveWord.name;
    LOG NSLog(@"-- (adjective name) %@ --",theAdjectiveString);

    SynonymWordClass* synonymWord = [synonymGroup lastObject];
    NSString* theSynonymString = synonymWord.name;
    LOG NSLog(@"-- (synonym name) %@ --",theSynonymString);

    // antonym
    SynonymObjectClass* antonymObjectClass = [myAdjectiveGroup lastObject];
    NSArray* antonymGroup = [self setSynonymWordForAntonym:antonymObjectClass.name withContext:context];
    LOG NSLog(@"-- (class name) %@ --",antonymObjectClass.name);
    
    SynonymWordClass* antonymWord = [antonymGroup firstObject];
    NSString* theAntonymString = antonymWord.name;
    LOG NSLog(@"-- (antonym name) %@ --",theAntonymString);

    return @{@"subject_determiner":mySubjectDeterminer,
             @"subject":theSubjectString,
             @"verb":theVerbString,
             @"adjective":theAdjectiveString,
             @"synonym_adjective":theSynonymString,
             @"antonym_adjective":theAntonymString};
    
}

- (NSArray*) setSynonymWordForAntonym:(NSString*) withType withContext: (NSManagedObjectContext*) context
{
    return [self shuffleArray:[self selectSynonymWordFromClassName:withType withContext:context]];
}



@end
