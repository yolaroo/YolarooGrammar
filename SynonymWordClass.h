//
//  SynonymWordClass.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SynonymObjectClass;

@interface SynonymWordClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *whatType;
@end

@interface SynonymWordClass (CoreDataGeneratedAccessors)

- (void)addWhatTypeObject:(SynonymObjectClass *)value;
- (void)removeWhatTypeObject:(SynonymObjectClass *)value;
- (void)addWhatType:(NSSet *)values;
- (void)removeWhatType:(NSSet *)values;

@end
