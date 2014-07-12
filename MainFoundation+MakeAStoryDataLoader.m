//
//  MainFoundation+MakeAStoryDataLoader.m
//  YolarooGrammar
//
//  Created by MGM on 5/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+MakeAStoryDataLoader.h"

#import "MainFoundation+MakeACharacterSearches.h"
#import "CharacterMaker.h"
#import "MainFoundation+SentenceController.h"
#import "CharacterMaker+CreateCharacter.h"

@implementation MainFoundation (MakeAStoryDataLoader) 

//
//
////////
#pragma mark - Write Action
////////
//
//

- (void) writeCharacterToDatbase: (CharacterMaker*) aCharacter withEventSet: (NSSet*) eventSet withContext: (NSManagedObjectContext*) context
{
}

//
//
////////
#pragma mark - Data Load
////////
//
//

- (NSArray*) myArrayAdvancedSetter: (CharacterMakerValue)myCharacterMakerValue withContext: (NSManagedObjectContext*)context
{
    @try {
        if (myCharacterMakerValue == kChMaSpecie) {
            return [self characterTypesMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaClothes) {
            return [self clothesListMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaFavoriteFoods) {
            return [self foodListMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaLocation) {
            return [self locationListMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaDescription) {
            return [self descriptionListMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaDisposition) {
            return [self dispositionListMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaDislikes) {
            return [self dislikeListMACS:context];
        }
        else if (myCharacterMakerValue == kCHMaEvent) { // HYBRID
            return [self eventTypeList];
        }
        else if (myCharacterMakerValue == kCHMaGoal) { // HYBRID
            return [self goalInfinitiveList];
        }
        else if (myCharacterMakerValue == kCHMaWeight) { //single
            return [self weightMACS];
        }
        else if (myCharacterMakerValue == kCHMaHeight) { //single
            return [self heightMACS];
        }
        else if (myCharacterMakerValue == kCHMaNationality) { //single
            return [self adjectListMACS:kAdjectiveNations withContext:context];
        }
        else if (myCharacterMakerValue == kCHMaEyeColor) { //single
            return [self adjectListMACS:kAdjectiveEyecolor withContext:context];
        }
        else if (myCharacterMakerValue == kCHMaHairColor) { //single
            return [self adjectListMACS:kAdjectiveHaircolor withContext:context];
        }
        else if (myCharacterMakerValue == kCHMaHome) { //single
            return [self wordListMACS:kWordHomes withContext:context];
        }
        else if (myCharacterMakerValue == kCHMaJob) { //single
            return [self wordListMACS:kWordJobs withContext:context];
        }
        else if (myCharacterMakerValue == kCHMaGender) { //single
            return @[@"male",@"female"];
        }
        else if (myCharacterMakerValue == kCHMaAge) { //single
            return [self AgeMACS];
        }
        else if (myCharacterMakerValue == kCHMaBirthday) { //single
            return [self DateMACS];
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
//
////////
#pragma mark - choice press
////////
//
//

- (CharacterMakerValue) choiceButtonPress: (NSInteger) myTag
{
    if (myTag == 100) {
        return kChMaSpecie;
    }
    else if (myTag == 101) {
        return kCHMaClothes;
    }
    else if (myTag == 102) {
        return kCHMaLocation;
    }
    else if (myTag == 103) {
        return kCHMaHome;
    }
    else if (myTag == 104) {
        return kCHMaHairColor;
    }
    else if (myTag == 105) {
        return kCHMaEyeColor;
    }
    else if (myTag == 106) {
        return kCHMaJob;
    }
    else if (myTag == 107) {
        return kCHMaFavoriteFoods;
    }
    else if (myTag == 108) {
        return kCHMaDislikes;
    }
    else if (myTag == 109) {
        return kCHMaDisposition;
    }
    else if (myTag == 110) {
        return kCHMaDescription;
    }
    else if (myTag == 111) {
        return kCHMaHeight;
    }
    else if (myTag == 112) {
        return kCHMaWeight;
    }
    else if (myTag == 113) {
        return kCHMaGender;
    }
    else if (myTag == 114) {
        return kCHMaNationality;
    }
    else if (myTag == 115) {
        return kCHMaBirthday;
    }
    else if (myTag == 116) {
        return kCHMaAge;
    }
    else if (myTag == 117) {
        return kCHMaEvent;
    }
    else if (myTag == 118) {
        return kCHMaGoal;
    }
    return kChMaSpecie;
}

//
//
////////
#pragma mark - delete press Load
////////
//
//

- (void) deletePropertyAction: (CharacterMakerValue)myCharacterMakerValue withCharacter: (CharacterMaker*)myCharacter
{
    if (myCharacterMakerValue == kChMaSpecie) {
        myCharacter.specie = @"";
    }
    else if (myCharacterMakerValue == kCHMaWeight) {
        myCharacter.weight = @"";
    }
    else if (myCharacterMakerValue == kCHMaHeight) {
        myCharacter.height = @"";
    }
    else if (myCharacterMakerValue == kCHMaLocation) {
        myCharacter.location = @"";
    }
    else if (myCharacterMakerValue == kCHMaJob) {
        myCharacter.job = @"";
    }
    else if (myCharacterMakerValue == kCHMaHome) {
        myCharacter.home = @"";
    }
    else if (myCharacterMakerValue == kCHMaHairColor) {
        myCharacter.hairColor = @"";
    }
    else if (myCharacterMakerValue == kCHMaEyeColor) {
        myCharacter.eyeColor = @"";
    }
    else if (myCharacterMakerValue == kCHMaNationality) {
        myCharacter.nationality = @"";
    }
    else if (myCharacterMakerValue == kCHMaGender) {
        myCharacter.gender = @"";
    }
    else if (myCharacterMakerValue == kCHMaBirthday) {
        myCharacter.birthday = @"";
    }
    else if (myCharacterMakerValue == kCHMaAge) {
        myCharacter.age = @"";
    }
    else if (myCharacterMakerValue == kCHMaFavoriteFoods) {
        [myCharacter.foodLikes removeAllObjects];
    }
    else if (myCharacterMakerValue == kCHMaDisposition) {
        [myCharacter.disposition removeAllObjects];
    }
    else if (myCharacterMakerValue == kCHMaDislikes) {
        [myCharacter.dislikes removeAllObjects];
    }
    else if (myCharacterMakerValue == kCHMaDescription) {
        [myCharacter.description removeAllObjects];
    }
    else if (myCharacterMakerValue == kCHMaClothes) {
        [myCharacter.clothes removeAllObjects];
    }
    else if (myCharacterMakerValue == kCHMaEvent) {
        [myCharacter.events removeAllObjects];
    }
    else if (myCharacterMakerValue == kCHMaGoal) {
        [myCharacter.goals removeAllObjects];
    }
}

//
//
////////
#pragma mark - test fill
////////
//
//

- (void) testCharacterfill: (CharacterMaker*)myCharacter
{
    NSString*myWord = @"cheese";
    myCharacter.specie = myWord;
    myCharacter.weight = @"101 kg";
    myCharacter.height = @"101 cm";
    myCharacter.location = myWord;
    myCharacter.job = myWord;
    myCharacter.home = myWord;
    myCharacter.hairColor = @"red";
    myCharacter.eyeColor = @"red";
    myCharacter.nationality = myWord;
    myCharacter.gender = @"male";
    myCharacter.birthday = @"january 1";
    myCharacter.age = @"5 years old";
    [myCharacter.foodLikes addObject: myWord];
    [myCharacter.disposition addObject: @"happy"];
    [myCharacter.dislikes addObject: myWord];
    [myCharacter.description addObject: @"happy"];
    [myCharacter.clothes addObject: myWord];
    [myCharacter.clothes addObject: myWord];
}


@end
