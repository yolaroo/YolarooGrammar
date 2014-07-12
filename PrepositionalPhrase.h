//
//  PrepositionalPhrase.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Determiner, NounProperties, NumberDeterminer, PrepositionSemanticType, Sentence, SententialAdjective, Word;

@interface PrepositionalPhrase : NSManagedObject

@property (nonatomic, retain) NSString * emptyName;
@property (nonatomic, retain) NSNumber * isAnEmptyObject;
@property (nonatomic, retain) NSString * preposition;
@property (nonatomic, retain) NSString * theInfinitive;
@property (nonatomic, retain) NSString * thePossesive;
@property (nonatomic, retain) NSString * thePrepositionPhrase;
@property (nonatomic, retain) NSString * thePronoun;
@property (nonatomic, retain) NSString * theWord;
@property (nonatomic, retain) NSSet *whatAdjective;
@property (nonatomic, retain) Determiner *whatDeterminer;
@property (nonatomic, retain) NumberDeterminer *whatNumber;
@property (nonatomic, retain) NounProperties *whatProperties;
@property (nonatomic, retain) PrepositionSemanticType *whatSemanticType;
@property (nonatomic, retain) NSSet *whatSentence;
@property (nonatomic, retain) NSSet *whatWord;
@end

@interface PrepositionalPhrase (CoreDataGeneratedAccessors)

- (void)addWhatAdjectiveObject:(SententialAdjective *)value;
- (void)removeWhatAdjectiveObject:(SententialAdjective *)value;
- (void)addWhatAdjective:(NSSet *)values;
- (void)removeWhatAdjective:(NSSet *)values;

- (void)addWhatSentenceObject:(Sentence *)value;
- (void)removeWhatSentenceObject:(Sentence *)value;
- (void)addWhatSentence:(NSSet *)values;
- (void)removeWhatSentence:(NSSet *)values;

- (void)addWhatWordObject:(Word *)value;
- (void)removeWhatWordObject:(Word *)value;
- (void)addWhatWord:(NSSet *)values;
- (void)removeWhatWord:(NSSet *)values;

@end
