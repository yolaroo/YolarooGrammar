//
//  CharacterMaker+CreateCharacter.m
//  YolarooGrammar
//
//  Created by MGM on 5/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "CharacterMaker+CreateCharacter.h"

#import "Specie+Create.h"
#import "Location+Create.h"
#import "Home+Create.h"
#import "Likes+Create.h"
#import "Dislikes+Create.h"
#import "Job+Create.h"
#import "Clothes+Create.h"

#import "Age+Create.h"
#import "EyeColor+Create.h"
#import "Disposition+Create.h"
#import "Height+Create.h"
#import "Weight+Create.h"
#import "Character+Create.h"

#import "MainFoundation+EventOptionsDataForCharacter.h"
#import "Goal+Create.h"
#import "Gender+Create.h"
#import "HairColor+Create.h"
#import "EyeColor+Create.h"
#import "Birthday+Create.h"
#import "Nationality+Create.h"
#import "Event+Create.h"

#import "GrammarWord+Create.h"
#import "Word+Create.h"

@implementation CharacterMaker (CreateCharacter)

- (NSString*)convert {
    
    
    return nil;
}

- (Character*) writeAdvancedCharacterForMaker: (CharacterMaker*)theCharacter withContext: (NSManagedObjectContext*) context
{
    NSMutableArray* myCharacterData = [[NSMutableArray alloc] init];
    
    //
    ////
    // add simples 0-7
    ////
    //
    
    Gender* theGender = [Gender genderWithName:theCharacter.gender withContext:context];
    HairColor* theHairColor = [HairColor hairColorWithColor:theCharacter.hairColor withContext:context];
    EyeColor* theEyeColor = [EyeColor eyeColorWithColor:theCharacter.eyeColor withContext:context];
    Nationality* theNationality = [Nationality nationalityWithName:theCharacter.nationality withContext:context];
    
    NSDateFormatter *dateStringParser = [[NSDateFormatter alloc] init];
    [dateStringParser setDateFormat:@"MMMM d"];
    NSDate *date = [dateStringParser dateFromString:theCharacter.birthday];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date];
    NSInteger dayInt = [components day];

    
    NSString* myStringDate = [self characterMakerAddSuffixToFullDate:theCharacter.birthday withInt:dayInt];
    NSLog(@"-- new date %@ --",myStringDate);
    
    Birthday* theBirthday = [Birthday birthdayWithDate:date withDateString: myStringDate withContext:context];
    
    NSString* UUID = theCharacter.UUID;
    [myCharacterData addObject: UUID];
    [myCharacterData addObject: theCharacter.name];
    [myCharacterData addObject:[NSNumber numberWithInteger:0]]; //display order
    [myCharacterData addObject: theBirthday];
    [myCharacterData addObject:theGender];
    [myCharacterData addObject:theHairColor];
    [myCharacterData addObject:[NSNumber numberWithBool:FALSE]]; //plural
    
    //grammarWordForNewName
    
    Word* myWord = [Word wordWithNameFromNil:theCharacter.name withContext:context];
    myWord.isProperName = [NSNumber numberWithBool:true];
    myWord.gender = theCharacter.gender;
    
    [GrammarWord grammarWordForNewName:theCharacter.name inManagedObjectContext:context];
    
    //
    ////
    //object section
    ////
    //

    //specie
    Specie* theSpecie = [Specie specieWithName:theCharacter.specie withContext:context];
    [myCharacterData addObject:theSpecie];
    
    //location
    Location* theCurrentlocationObject = [Location locationWithName:theCharacter.location  withContext:context];
    theCurrentlocationObject.isCurrent = [NSNumber numberWithBool:TRUE];
    NSSet* locationsSet = [NSSet  setWithObjects:theCurrentlocationObject, nil];
    [myCharacterData addObject:locationsSet];
    
    //home
    Home* theHomelocationObject = [Home homeWithString:theCharacter.home withContext:context];
    [myCharacterData addObject:theHomelocationObject];
    
    //like
    Likes* likeObject = [Likes likesWithName:[theCharacter.foodLikes firstObject] withContext:context];
    NSSet* likeSet = [NSSet  setWithObjects:likeObject, nil];
    [myCharacterData addObject:likeSet];
    
    //dislike
    Dislikes* hateObject = [Dislikes dislikesWithName:[theCharacter.dislikes firstObject] withContext:context];
    NSSet* hateSet = [NSSet  setWithObjects:hateObject, nil];
    [myCharacterData addObject:hateSet];
    
    //job
    Job* theJobObject = [Job jobWithName:theCharacter.job withContext:context];
    NSSet* jobSet = [NSSet  setWithObjects:theJobObject,nil];
    [myCharacterData addObject:jobSet];
    
    //clothes
    Clothes* theClothesObjectTop = [Clothes clothesWithName:[theCharacter.clothes firstObject] withContext:context];
    Clothes* theClothesObjectBottom = [Clothes clothesWithName:[theCharacter.clothes lastObject] withContext:context];
    
    NSSet* clothesSet = [NSSet  setWithObjects:theClothesObjectTop,theClothesObjectBottom, nil];
    [myCharacterData addObject:clothesSet];

    //goal
    Goal* theGoalObject = [Goal goalWithNameandInfinitiveForGoalMaker:[theCharacter.goals firstObject] withContext:context];
    NSSet* goalSet = [NSSet setWithObjects:theGoalObject, nil];
    [myCharacterData addObject:goalSet];
    
    //age
    Age* theAgeObject = [Age ageWithString:theCharacter.age withContext:context];
    [myCharacterData addObject:theAgeObject];
    
    //eye color
    [myCharacterData addObject:theEyeColor];
    
    //height
    Height*heightObject = [Height heightWithString:theCharacter.height withContext:context];
    [myCharacterData addObject:heightObject];
    
    //weight
    Weight*weightObject = [Weight weightWithString:theCharacter.weight withContext:context];
    [myCharacterData addObject:weightObject];
    
    //disposition
    Disposition*theDisposition = [Disposition dispositionWithName:[theCharacter.disposition firstObject] withContext:context];
    NSSet* dispositionSet = [NSSet  setWithObjects:theDisposition, nil];
    [myCharacterData addObject:dispositionSet];
    
    //nation
    [myCharacterData addObject:theNationality];
    
    //event
    Event* firstEvent = [Event eventWithEventMaker:[theCharacter.events firstObject] withContext:context];
    Event* secondEvent = [Event eventWithEventMaker:[theCharacter.events lastObject] withContext:context];
    NSSet* eventSet = [NSSet  setWithObjects:firstEvent,secondEvent, nil];
    [myCharacterData addObject:eventSet];
    
    //
    ////
    //////
    ////////
    Character* finalCharacter = [Character createCharacter:[myCharacterData copy] withContext:context];
    
    ////
    //test
    //LOG NSLog(@"Character Done");
    //LOG [self timeTestUpdate];
    //test
    ////
    
    return finalCharacter;
}

- (NSString*) characterMakerAddSuffixToFullDate:(NSString*)myString withInt: (NSInteger) myInt
{
    NSString* mySuffix = [self characterMakerAddSuffixToNumber:myInt];
    
    return [NSString stringWithFormat:@"%@%@",myString,mySuffix];
}


- (NSString *) characterMakerAddSuffixToNumber:(NSInteger) myNumber
{
    NSString *suffix;
    NSInteger ones = myNumber % 10;
    NSInteger temp = floor(myNumber/10.0);
    NSInteger tens = temp%10;
    NSLog(@"suffix run");
    if (tens == 1) {
        suffix = @"th";
    } else if (ones == 1){
        suffix = @"st";
    } else if (ones == 2){
        suffix = @"nd";
    } else if (ones == 3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    return suffix;
}


@end
