//
//  Word.h
//  YolarooGrammar
//
//  Created by MGM on 5/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjectPhrase, PrepositionalPhrase, SemanticType, SubjectPhrase, SyntacticType;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * english;
@property (nonatomic, retain) NSString * french;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * hasDefiniteDeterminer;
@property (nonatomic, retain) NSNumber * isAdjective;
@property (nonatomic, retain) NSNumber * isNumber;
@property (nonatomic, retain) NSNumber * isPlural;
@property (nonatomic, retain) NSNumber * isProperName;
@property (nonatomic, retain) NSNumber * isUncountable;
@property (nonatomic, retain) NSString * mandarin;
@property (nonatomic, retain) NSString * pinyin;
@property (nonatomic, retain) NSString * wordObject;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatObject;
@property (nonatomic, retain) NSSet *whatPreposition;
@property (nonatomic, retain) SemanticType *whatSemanticType;
@property (nonatomic, retain) NSSet *whatSubject;
@property (nonatomic, retain) SyntacticType *whatSyntacticType;
@end

@interface Word (CoreDataGeneratedAccessors)

- (void)addWhatObjectObject:(PrepositionalPhrase *)value;
- (void)removeWhatObjectObject:(PrepositionalPhrase *)value;
- (void)addWhatObject:(NSSet *)values;
- (void)removeWhatObject:(NSSet *)values;

- (void)addWhatPrepositionObject:(ObjectPhrase *)value;
- (void)removeWhatPrepositionObject:(ObjectPhrase *)value;
- (void)addWhatPreposition:(NSSet *)values;
- (void)removeWhatPreposition:(NSSet *)values;

- (void)addWhatSubjectObject:(SubjectPhrase *)value;
- (void)removeWhatSubjectObject:(SubjectPhrase *)value;
- (void)addWhatSubject:(NSSet *)values;
- (void)removeWhatSubject:(NSSet *)values;

@end
