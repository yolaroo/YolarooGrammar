//
//  Sentence.h
//  YolarooGrammar
//
//  Created by MGM on 5/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjectPhrase, PrepositionalPhrase, SententialVerb, Story, SubjectPhrase;

@interface Sentence : NSManagedObject

@property (nonatomic, retain) NSString * characterGender;
@property (nonatomic, retain) NSString * characterName;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSNumber * hasAdjectiveForObject;
@property (nonatomic, retain) NSNumber * hasCopula;
@property (nonatomic, retain) NSNumber * hasIndirectObject;
@property (nonatomic, retain) NSNumber * hasMultipleObjects;
@property (nonatomic, retain) NSNumber * hasObject;
@property (nonatomic, retain) NSNumber * hasPreposition;
@property (nonatomic, retain) NSNumber * isAnthropomorphic;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSNumber * isPassive;
@property (nonatomic, retain) NSNumber * objectsCount;
@property (nonatomic, retain) NSString * pragmaticType;
@property (nonatomic, retain) NSString * sentenceAspect;
@property (nonatomic, retain) NSString * sentenceModal;
@property (nonatomic, retain) NSString * sentenceTense;
@property (nonatomic, retain) NSString * textObject;
@property (nonatomic, retain) NSString * textObjectDeterminer;
@property (nonatomic, retain) NSString * textObjectInfinitive;
@property (nonatomic, retain) NSString * textPrep;
@property (nonatomic, retain) NSString * textPrepDeterminer;
@property (nonatomic, retain) NSString * textPrepObject;
@property (nonatomic, retain) NSString * textSubject;
@property (nonatomic, retain) NSString * textVerb;
@property (nonatomic, retain) NSString * textVerbAuxiliary;
@property (nonatomic, retain) NSString * theSentence;
@property (nonatomic, retain) NSString * uuID;
@property (nonatomic, retain) NSNumber * singleObjectUnpackIndex;
@property (nonatomic, retain) NSNumber * hasSingleObjectUnpack;
@property (nonatomic, retain) NSSet *whatObject;
@property (nonatomic, retain) NSSet *whatPreposition;
@property (nonatomic, retain) NSSet *whatSententialVerb;
@property (nonatomic, retain) NSSet *whatStory;
@property (nonatomic, retain) NSSet *whatSubject;
@end

@interface Sentence (CoreDataGeneratedAccessors)

- (void)addWhatObjectObject:(ObjectPhrase *)value;
- (void)removeWhatObjectObject:(ObjectPhrase *)value;
- (void)addWhatObject:(NSSet *)values;
- (void)removeWhatObject:(NSSet *)values;

- (void)addWhatPrepositionObject:(PrepositionalPhrase *)value;
- (void)removeWhatPrepositionObject:(PrepositionalPhrase *)value;
- (void)addWhatPreposition:(NSSet *)values;
- (void)removeWhatPreposition:(NSSet *)values;

- (void)addWhatSententialVerbObject:(SententialVerb *)value;
- (void)removeWhatSententialVerbObject:(SententialVerb *)value;
- (void)addWhatSententialVerb:(NSSet *)values;
- (void)removeWhatSententialVerb:(NSSet *)values;

- (void)addWhatStoryObject:(Story *)value;
- (void)removeWhatStoryObject:(Story *)value;
- (void)addWhatStory:(NSSet *)values;
- (void)removeWhatStory:(NSSet *)values;

- (void)addWhatSubjectObject:(SubjectPhrase *)value;
- (void)removeWhatSubjectObject:(SubjectPhrase *)value;
- (void)addWhatSubject:(NSSet *)values;
- (void)removeWhatSubject:(NSSet *)values;

@end
