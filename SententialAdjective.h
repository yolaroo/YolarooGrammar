//
//  SententialAdjective.h
//  YolarooGrammar
//
//  Created by MGM on 4/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AdjectiveClass, ObjectPhrase, PrepositionalPhrase, SubjectPhrase;

@interface SententialAdjective : NSManagedObject

@property (nonatomic, retain) NSString * theAdjective;
@property (nonatomic, retain) NSNumber * isComparative;
@property (nonatomic, retain) NSNumber * isSuperlative;
@property (nonatomic, retain) NSNumber * isIrregular;
@property (nonatomic, retain) AdjectiveClass *whatMainAdjective;
@property (nonatomic, retain) NSSet *whatObject;
@property (nonatomic, retain) NSSet *whatPrepositionalPhrase;
@property (nonatomic, retain) NSSet *whatSubject;
@end

@interface SententialAdjective (CoreDataGeneratedAccessors)

- (void)addWhatObjectObject:(ObjectPhrase *)value;
- (void)removeWhatObjectObject:(ObjectPhrase *)value;
- (void)addWhatObject:(NSSet *)values;
- (void)removeWhatObject:(NSSet *)values;

- (void)addWhatPrepositionalPhraseObject:(PrepositionalPhrase *)value;
- (void)removeWhatPrepositionalPhraseObject:(PrepositionalPhrase *)value;
- (void)addWhatPrepositionalPhrase:(NSSet *)values;
- (void)removeWhatPrepositionalPhrase:(NSSet *)values;

- (void)addWhatSubjectObject:(SubjectPhrase *)value;
- (void)removeWhatSubjectObject:(SubjectPhrase *)value;
- (void)addWhatSubject:(NSSet *)values;
- (void)removeWhatSubject:(NSSet *)values;

@end
