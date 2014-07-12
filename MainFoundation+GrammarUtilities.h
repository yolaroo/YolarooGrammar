//
//  MainFoundation+GrammarUtilities.h
//  YolarooGrammar
//
//  Created by MGM on 5/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (GrammarUtilities)

- (NSString*) myCommonPeople;
- (NSString*) myCommonSubject;

- (NSString*) suffixCheck: (NSString*)aString;
- (NSString*) possessiveSuffixCheck: (NSString*)aString;

- (NSString*) myVerbSubjectComplex;
- (NSString*) myVerbSubjectSimple;
- (NSString*) myVerbSubjectPronouns;

- (NSString*) mySimpleVerbList;

//utility

- (NSString*) setMyDeterminer: (Word*)theWord;
- (BOOL) canBePluralized: (Word*) theWord withCase: (BOOL) subjectIsPlural;
- (BOOL) thePluralCheck: (NSDictionary*)dictionary withWord: (Word*) theWord;
- (BOOL) thePluralCheckForObject: (NSDictionary*)dictionary withWord: (Word*) theWord;

// verb
- (NSString*) theCopulaString: (NSDictionary*)dictionary withCase: (BOOL)subjectIsPlural withContext: (NSManagedObjectContext*)context;
- (NSString*) theVerbStringWithTense: (NSDictionary*)dictionary withTense: (NSString*)sentenceTense withCase: (BOOL)subjectIsPlural withWord: (Word*) theWord withContext: (NSManagedObjectContext*)context;

// tense
- (NSString*) theVerbTense: (NSDictionary*)dictionary;
- (NSString*) makeAdverbForTense: (NSDictionary*)dictionary withTense: (NSString*)sentenceTense;


// answers
- (NSString*) theAnswerComputationForPossessive: (Word*)theWord withCase: (BOOL) isPlural;
- (NSString*) theAnswerComputationForPronoun: (Word*)theWord withCase: (BOOL) isPlural;
- (NSString*) theAnswerComputationForAccusative: (Word*)theWord withCase: (BOOL) isPlural;

- (NSString*) myReformedAnswer: (NSString*) sentence withNewPart: (NSString*) part;

@end
