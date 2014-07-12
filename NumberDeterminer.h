//
//  NumberDeterminer.h
//  YolarooGrammar
//
//  Created by MGM on 4/7/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjectPhrase, PrepositionalPhrase, SubjectPhrase;

@interface NumberDeterminer : NSManagedObject

@property (nonatomic, retain) NSNumber * theNumber;
@property (nonatomic, retain) NSSet *whatPrepositionObject;
@property (nonatomic, retain) NSSet *whatSubject;
@property (nonatomic, retain) NSSet *whatObject;
@end

@interface NumberDeterminer (CoreDataGeneratedAccessors)

- (void)addWhatPrepositionObjectObject:(PrepositionalPhrase *)value;
- (void)removeWhatPrepositionObjectObject:(PrepositionalPhrase *)value;
- (void)addWhatPrepositionObject:(NSSet *)values;
- (void)removeWhatPrepositionObject:(NSSet *)values;

- (void)addWhatSubjectObject:(SubjectPhrase *)value;
- (void)removeWhatSubjectObject:(SubjectPhrase *)value;
- (void)addWhatSubject:(NSSet *)values;
- (void)removeWhatSubject:(NSSet *)values;

- (void)addWhatObjectObject:(ObjectPhrase *)value;
- (void)removeWhatObjectObject:(ObjectPhrase *)value;
- (void)addWhatObject:(NSSet *)values;
- (void)removeWhatObject:(NSSet *)values;

@end
