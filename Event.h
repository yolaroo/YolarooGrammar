//
//  Event.h
//  YolarooGrammar
//
//  Created by MGM on 5/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Goal;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSNumber * isComplex;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * object;
@property (nonatomic, retain) NSString * preposition;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *whatCharacter;
@property (nonatomic, retain) NSSet *whatGoal;
@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

- (void)addWhatGoalObject:(Goal *)value;
- (void)removeWhatGoalObject:(Goal *)value;
- (void)addWhatGoal:(NSSet *)values;
- (void)removeWhatGoal:(NSSet *)values;

@end
