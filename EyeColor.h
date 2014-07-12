//
//  EyeColor.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface EyeColor : NSManagedObject

@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * objectIsAdjective;
@property (nonatomic, retain) NSString * verb;
@property (nonatomic, retain) NSSet *whatCharacter;
@end

@interface EyeColor (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(Character *)value;
- (void)removeWhatCharacterObject:(Character *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

@end
