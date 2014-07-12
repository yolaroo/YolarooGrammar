//
//  Location.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address, Character;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSDate * arrivalDate;
@property (nonatomic, retain) NSDate * departureDate;
@property (nonatomic, retain) NSNumber * isCurrent;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * preposition;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSNumber * isLocation;
@property (nonatomic, retain) Address *whatAddress;
@property (nonatomic, retain) NSSet *whatCharacter;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

@end
