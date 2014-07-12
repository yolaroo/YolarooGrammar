//
//  Goal.h
//  YolarooGrammar
//
//  Created by MGM on 5/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Event;

@interface Goal : NSManagedObject

@property (nonatomic, retain) NSDate * completedDate;
@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSNumber * isFinancial;
@property (nonatomic, retain) NSNumber * isPersonal;
@property (nonatomic, retain) NSNumber * isPlural;
@property (nonatomic, retain) NSNumber * isSexual;
@property (nonatomic, retain) NSNumber * isSocial;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * infinitive;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) NSSet *whoseGoal;
@end

@interface Goal (CoreDataGeneratedAccessors)

- (void)addWhatEventObject:(Event *)value;
- (void)removeWhatEventObject:(Event *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhoseGoalObject:(Character *)value;
- (void)removeWhoseGoalObject:(Character *)value;
- (void)addWhoseGoal:(NSSet *)values;
- (void)removeWhoseGoal:(NSSet *)values;

@end
