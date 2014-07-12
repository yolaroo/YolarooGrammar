//
//  Nationality.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface Nationality : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSNumber * objectIsAdjective;
@property (nonatomic, retain) NSSet *whatCharacter;
@end

@interface Nationality (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

@end
