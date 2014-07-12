//
//  Character.h
//  YolarooGrammar
//
//  Created by MGM on 5/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Age, Belief, Birthday, BodyPart, Clothes, Dislikes, Disposition, Event, EyeColor, Gender, Goal, HairColor, Height, Home, Job, Likes, Location, Nationality, SocialGroup, Specie, Statements, Story, Weight;

@interface Character : NSManagedObject

@property (nonatomic, retain) NSDate * deathDate;
@property (nonatomic, retain) NSNumber * displayOrder;
@property (nonatomic, retain) NSString * familyName;
@property (nonatomic, retain) NSNumber * isDirectIdentity;
@property (nonatomic, retain) NSNumber * isPlural;
@property (nonatomic, retain) NSString * metaType;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuID;
@property (nonatomic, retain) NSNumber * isSaved;
@property (nonatomic, retain) Age *whatAge;
@property (nonatomic, retain) NSSet *whatBelief;
@property (nonatomic, retain) Birthday *whatBirthday;
@property (nonatomic, retain) NSSet *whatBodyPart;
@property (nonatomic, retain) NSSet *whatClothes;
@property (nonatomic, retain) NSSet *whatDislike;
@property (nonatomic, retain) NSSet *whatDisposition;
@property (nonatomic, retain) NSSet *whatEvent;
@property (nonatomic, retain) EyeColor *whatEyeColor;
@property (nonatomic, retain) Gender *whatGender;
@property (nonatomic, retain) NSSet *whatGoal;
@property (nonatomic, retain) HairColor *whatHairColor;
@property (nonatomic, retain) Height *whatHeight;
@property (nonatomic, retain) Home *whatHome;
@property (nonatomic, retain) NSSet *whatJob;
@property (nonatomic, retain) NSSet *whatLike;
@property (nonatomic, retain) NSSet *whatLocation;
@property (nonatomic, retain) Nationality *whatNationality;
@property (nonatomic, retain) NSSet *whatSocialGroup;
@property (nonatomic, retain) Specie *whatSpecie;
@property (nonatomic, retain) NSSet *whatStatements;
@property (nonatomic, retain) NSSet *whatStory;
@property (nonatomic, retain) Weight *whatWeight;
@end

@interface Character (CoreDataGeneratedAccessors)

- (void)addWhatBeliefObject:(Belief *)value;
- (void)removeWhatBeliefObject:(Belief *)value;
- (void)addWhatBelief:(NSSet *)values;
- (void)removeWhatBelief:(NSSet *)values;

- (void)addWhatBodyPartObject:(BodyPart *)value;
- (void)removeWhatBodyPartObject:(BodyPart *)value;
- (void)addWhatBodyPart:(NSSet *)values;
- (void)removeWhatBodyPart:(NSSet *)values;

- (void)addWhatClothesObject:(Clothes *)value;
- (void)removeWhatClothesObject:(Clothes *)value;
- (void)addWhatClothes:(NSSet *)values;
- (void)removeWhatClothes:(NSSet *)values;

- (void)addWhatDislikeObject:(Dislikes *)value;
- (void)removeWhatDislikeObject:(Dislikes *)value;
- (void)addWhatDislike:(NSSet *)values;
- (void)removeWhatDislike:(NSSet *)values;

- (void)addWhatDispositionObject:(Disposition *)value;
- (void)removeWhatDispositionObject:(Disposition *)value;
- (void)addWhatDisposition:(NSSet *)values;
- (void)removeWhatDisposition:(NSSet *)values;

- (void)addWhatEventObject:(Event *)value;
- (void)removeWhatEventObject:(Event *)value;
- (void)addWhatEvent:(NSSet *)values;
- (void)removeWhatEvent:(NSSet *)values;

- (void)addWhatGoalObject:(Goal *)value;
- (void)removeWhatGoalObject:(Goal *)value;
- (void)addWhatGoal:(NSSet *)values;
- (void)removeWhatGoal:(NSSet *)values;

- (void)addWhatJobObject:(Job *)value;
- (void)removeWhatJobObject:(Job *)value;
- (void)addWhatJob:(NSSet *)values;
- (void)removeWhatJob:(NSSet *)values;

- (void)addWhatLikeObject:(Likes *)value;
- (void)removeWhatLikeObject:(Likes *)value;
- (void)addWhatLike:(NSSet *)values;
- (void)removeWhatLike:(NSSet *)values;

- (void)addWhatLocationObject:(Location *)value;
- (void)removeWhatLocationObject:(Location *)value;
- (void)addWhatLocation:(NSSet *)values;
- (void)removeWhatLocation:(NSSet *)values;

- (void)addWhatSocialGroupObject:(SocialGroup *)value;
- (void)removeWhatSocialGroupObject:(SocialGroup *)value;
- (void)addWhatSocialGroup:(NSSet *)values;
- (void)removeWhatSocialGroup:(NSSet *)values;

- (void)addWhatStatementsObject:(Statements *)value;
- (void)removeWhatStatementsObject:(Statements *)value;
- (void)addWhatStatements:(NSSet *)values;
- (void)removeWhatStatements:(NSSet *)values;

- (void)addWhatStoryObject:(Story *)value;
- (void)removeWhatStoryObject:(Story *)value;
- (void)addWhatStory:(NSSet *)values;
- (void)removeWhatStory:(NSSet *)values;

@end
