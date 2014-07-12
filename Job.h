//
//  Job.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Duty;

@interface Job : NSManagedObject

@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * wage;
@property (nonatomic, retain) NSSet *whatCharacter;
@property (nonatomic, retain) NSSet *whatDuty;
@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

- (void)addWhatDutyObject:(Duty *)value;
- (void)removeWhatDutyObject:(Duty *)value;
- (void)addWhatDuty:(NSSet *)values;
- (void)removeWhatDuty:(NSSet *)values;

@end
