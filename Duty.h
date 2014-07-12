//
//  Duty.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Job;

@interface Duty : NSManagedObject

@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) NSSet *whatJob;
@end

@interface Duty (CoreDataGeneratedAccessors)

- (void)addWhatJobObject:(Job *)value;
- (void)removeWhatJobObject:(Job *)value;
- (void)addWhatJob:(NSSet *)values;
- (void)removeWhatJob:(NSSet *)values;

@end
