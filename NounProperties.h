//
//  NounProperties.h
//  YolarooGrammar
//
//  Created by MGM on 5/15/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjectPhrase, PrepositionalPhrase, SubjectPhrase;

@interface NounProperties : NSManagedObject

@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * hasAdjective;
@property (nonatomic, retain) NSNumber * hasDeterminer;
@property (nonatomic, retain) NSNumber * hasNumber;
@property (nonatomic, retain) NSNumber * hasPossesive;
@property (nonatomic, retain) NSNumber * hasPronoun;
@property (nonatomic, retain) NSNumber * hasSuffix;
@property (nonatomic, retain) NSNumber * isDate;
@property (nonatomic, retain) NSNumber * isFirstPerson;
@property (nonatomic, retain) NSNumber * isGeneralization;
@property (nonatomic, retain) NSNumber * isLocation;
@property (nonatomic, retain) NSNumber * isPlural;
@property (nonatomic, retain) NSNumber * isSecondPerson;
@property (nonatomic, retain) NSNumber * isThirdPerson;
@property (nonatomic, retain) NSNumber * isTime;
@property (nonatomic, retain) NSString * semanticType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatObject;
@property (nonatomic, retain) NSSet *whatPreposition;
@property (nonatomic, retain) NSSet *whatSubject;
@end

@interface NounProperties (CoreDataGeneratedAccessors)

- (void)addWhatObjectObject:(ObjectPhrase *)value;
- (void)removeWhatObjectObject:(ObjectPhrase *)value;
- (void)addWhatObject:(NSSet *)values;
- (void)removeWhatObject:(NSSet *)values;

- (void)addWhatPrepositionObject:(PrepositionalPhrase *)value;
- (void)removeWhatPrepositionObject:(PrepositionalPhrase *)value;
- (void)addWhatPreposition:(NSSet *)values;
- (void)removeWhatPreposition:(NSSet *)values;

- (void)addWhatSubjectObject:(SubjectPhrase *)value;
- (void)removeWhatSubjectObject:(SubjectPhrase *)value;
- (void)addWhatSubject:(NSSet *)values;
- (void)removeWhatSubject:(NSSet *)values;

@end
