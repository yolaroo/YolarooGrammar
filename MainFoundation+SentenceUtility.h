//
//  MainFoundation+SentenceUtility.h
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

#import "Character.h"

#import "PrepositionalPhrase+Create.h"
#import "SubjectPhrase+Create.h"
#import "ObjectPhrase+Create.h"
#import "SententialVerb+Create.h"

#import "Determiner+Create.h"
#import "SententialAdjective+Create.h"
#import "NounProperties+Create.h"

@interface MainFoundation (SentenceUtility)

- (BOOL) canConvertToNumber: (NSString*)objectString;

- (NSString*) stringFromDictionaryWithString: (NSDictionary*) dictionary withKey: (NSString*) myKey;

- (NSString*) stringFromDictionaryWithArray: (NSDictionary*) dictionary withKey: (NSString*) myKey withType: (NSString*) theType;
- (NSString*) stringFromDictionaryWithArrayAtIndex: (NSDictionary*) dictionary withKey: (NSString*) myKey withType: (NSString*) theType withIndex: (NSInteger) myIndex;

- (NSString*) stringForMultiObjectWithArray: (NSArray*)myArray withObjectNumber: (NSInteger) theObjectCount withType: (NSString*) theType;

- (NSString*) sentenceSuffixCheck: (NSString*)aString;

- (Word*) wordObjectFromNameWithComplexTypes: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext;

- (Word*) wordObjectFromName: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext;

- (AdjectiveClass*) adjectiveObjectFromName: (NSString*)theWord withContext: (NSManagedObjectContext*)newContext;

- (NSString*) setPronounSubject: (Character*)theCharacter;

- (NSString*) setPronounObject: (Word*)word;

- (NSString*) setDefaultDeterminer: (Word*) theWord;

- (NSString*) setDeterminer:(Character*) theCharacter withWord: (Word*) theWord withType: (NSString*) theType;

- (NSString*) setPossesive: (Character*)theCharacter;

- (BOOL) hasInitialVowel: (NSString*)objectString;

//

- (BOOL) isAdjectiveTest: (NSDictionary*)dictionary withType: (NSString*)type;
- (BOOL) isDateTest: (NSDictionary*)dictionary withType: (NSString*)type;
- (BOOL) isNumberTest: (NSDictionary*)dictionary withType: (NSString*)type;


@end
