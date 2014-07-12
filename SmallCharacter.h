//
//  SmallCharacter.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SmallCharacterClass, SmallCharacterDescription;

@interface SmallCharacter : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuID;
@property (nonatomic, retain) SmallCharacterClass *whatClass;
@property (nonatomic, retain) NSSet *whatDescription;
@end

@interface SmallCharacter (CoreDataGeneratedAccessors)

- (void)addWhatDescriptionObject:(SmallCharacterDescription *)value;
- (void)removeWhatDescriptionObject:(SmallCharacterDescription *)value;
- (void)addWhatDescription:(NSSet *)values;
- (void)removeWhatDescription:(NSSet *)values;

@end
