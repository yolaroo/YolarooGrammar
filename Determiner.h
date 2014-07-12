//
//  Determiner.h
//  YolarooGrammar
//
//  Created by MGM on 5/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjectPhrase, PrepositionalPhrase, SubjectPhrase;

@interface Determiner : NSManagedObject

@property (nonatomic, retain) NSNumber * isAffix;
@property (nonatomic, retain) NSNumber * isSuffix;
@property (nonatomic, retain) NSString * theDeterminer;
@property (nonatomic, retain) NSString * theWord;
@property (nonatomic, retain) NSSet *whatObject;
@property (nonatomic, retain) NSSet *whatPrepositionObject;
@property (nonatomic, retain) NSSet *whatSubject;
@end

@interface Determiner (CoreDataGeneratedAccessors)

- (void)addWhatObjectObject:(ObjectPhrase *)value;
- (void)removeWhatObjectObject:(ObjectPhrase *)value;
- (void)addWhatObject:(NSSet *)values;
- (void)removeWhatObject:(NSSet *)values;

- (void)addWhatPrepositionObjectObject:(PrepositionalPhrase *)value;
- (void)removeWhatPrepositionObjectObject:(PrepositionalPhrase *)value;
- (void)addWhatPrepositionObject:(NSSet *)values;
- (void)removeWhatPrepositionObject:(NSSet *)values;

- (void)addWhatSubjectObject:(SubjectPhrase *)value;
- (void)removeWhatSubjectObject:(SubjectPhrase *)value;
- (void)addWhatSubject:(NSSet *)values;
- (void)removeWhatSubject:(NSSet *)values;

@end
