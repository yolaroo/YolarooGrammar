//
//  Clothes.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface Clothes : NSManagedObject

@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSNumber * isPlural;
@property (nonatomic, retain) NSNumber * isWearing;
@property (nonatomic, retain) NSDate * lostDate;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * recievedDate;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSSet *whatCharacter;
@end

@interface Clothes (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

@end
