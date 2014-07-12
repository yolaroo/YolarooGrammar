//
//  Address.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Home, Location, Nation, State, Street;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSNumber * address;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSNumber * zipcode;
@property (nonatomic, retain) NSNumber * objectIsNumber;
@property (nonatomic, retain) City *whatCity;
@property (nonatomic, retain) NSSet *whatHome;
@property (nonatomic, retain) NSSet *whatLocation;
@property (nonatomic, retain) Nation *whatNation;
@property (nonatomic, retain) State *whatState;
@property (nonatomic, retain) Street *whatStreet;
@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addWhatHomeObject:(Home *)value;
- (void)removeWhatHomeObject:(Home *)value;
- (void)addWhatHome:(NSSet *)values;
- (void)removeWhatHome:(NSSet *)values;

- (void)addWhatLocationObject:(Location *)value;
- (void)removeWhatLocationObject:(Location *)value;
- (void)addWhatLocation:(NSSet *)values;
- (void)removeWhatLocation:(NSSet *)values;

@end
