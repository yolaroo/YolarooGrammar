//
//  SubjectPhrase.h
//  YolarooGrammar
//
//  Created by MGM on 5/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Determiner, NounProperties, NumberDeterminer, Sentence, SententialAdjective, Word;

@interface SubjectPhrase : NSManagedObject

@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * thePossesive;
@property (nonatomic, retain) NSString * thePronoun;
@property (nonatomic, retain) NSString * theSubjectPhrase;
@property (nonatomic, retain) NSString * theWord;
@property (nonatomic, retain) NSNumber * isCharacter;
@property (nonatomic, retain) NSSet *whatAdjective;
@property (nonatomic, retain) Determiner *whatDeterminer;
@property (nonatomic, retain) NumberDeterminer *whatNumber;
@property (nonatomic, retain) NounProperties *whatProperties;
@property (nonatomic, retain) NSSet *whatSentence;
@property (nonatomic, retain) NSSet *whatWord;
@end

@interface SubjectPhrase (CoreDataGeneratedAccessors)

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
