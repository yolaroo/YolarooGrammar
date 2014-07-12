//
//  SynonymObjectClass.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SynonymWordClass;

@interface SynonymObjectClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * antonym;
@property (nonatomic, retain) NSSet *whatWord;
@end

@interface SynonymObjectClass (CoreDataGeneratedAccessors)

- (void)addWhatWordObject:(SynonymWordClass *)value;
- (void)removeWhatWordObject:(SynonymWordClass *)value;
- (void)addWhatWord:(NSSet *)values;
- (void)removeWhatWord:(NSSet *)values;

@end
