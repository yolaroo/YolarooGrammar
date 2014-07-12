//
//  SmallCharacterClass.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SmallCharacter;

@interface SmallCharacterClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSSet *whatCharacter;
@end

@interface SmallCharacterClass (CoreDataGeneratedAccessors)

- (void)addWhatCharacterObject:(SmallCharacter *)value;
- (void)removeWhatCharacterObject:(SmallCharacter *)value;
- (void)addWhatCharacter:(NSSet *)values;
- (void)removeWhatCharacter:(NSSet *)values;

@end
