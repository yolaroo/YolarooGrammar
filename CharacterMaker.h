//
//  CharacterMaker.h
//  YolarooGrammar
//
//  Created by MGM on 5/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Specie.h"
#import "Job.h"
#import "Location.h"
#import "Event.h"
#import "Likes.h"
#import "Clothes.h"
#import "Dislikes.h"
#import "Home.h"
#import "Birthday.h"
#import "Age.h"
#import "EyeColor.h"
#import "Gender.h"
#import "HairColor.h"
#import "Sentence.h"
#import "Weight.h"
#import "Height.h"
#import "Disposition.h"
#import "Nationality.h"
#import "Goal.h"

#import "EventMaker.h"
@class EventMaker;

#import "GoalMaker.h"
@class GoalMaker;

typedef NS_ENUM(NSInteger, CharacterMakerValue)  {
    kChMaSpecie,
    kCHMaHome,
    kCHMaLocation,
    kCHMaJob,
    kCHMaHairColor,
    kCHMaEyeColor,
    kCHMaWeight,
    kCHMaHeight,
    kCHMaFavoriteFoods,
    kCHMaDislikes,
    kCHMaDisposition,
    kCHMaDescription,
    kCHMaClothes,
    kCHMaNationality,
    kCHMaGender,
    kCHMaName,
    kCHMaBirthday,
    kCHMaAge,
    kCHMaEvent,
    kCHMaGoal,
};


@interface CharacterMaker : NSObject

@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* UUID;

@property (strong,nonatomic) NSString* specie;
@property (strong,nonatomic) NSString* home;
@property (strong,nonatomic) NSString* location;
@property (strong,nonatomic) NSString* job;

@property (strong,nonatomic) NSString* hairColor;
@property (strong,nonatomic) NSString* eyeColor;
@property (strong,nonatomic) NSString* weight;
@property (strong,nonatomic) NSString* height;
@property (strong,nonatomic) NSString* birthday;
@property (strong,nonatomic) NSString* gender;
@property (strong,nonatomic) NSString* age;
@property (strong,nonatomic) NSString* nationality;

@property (strong,nonatomic) NSMutableArray* foodLikes;
@property (strong,nonatomic) NSMutableArray* dislikes;
@property (strong,nonatomic) NSMutableArray* disposition;
@property (strong,nonatomic) NSMutableArray* description;
@property (strong,nonatomic) NSMutableArray* clothes;
@property (strong,nonatomic) NSMutableArray* events;
@property (strong,nonatomic) NSMutableArray* goals;


//
////
//

- (BOOL) isCharacterFull;
- (void) saveRecordToClass: (CharacterMakerValue)myCharacterMakerValue withWord: (NSString*)myWord;
- (void) saveEventRecordToClass: (EventMaker*)myEvent;
- (void) saveGoalRecordToClass: (GoalMaker*)myGoal;

//
////
//


@end
