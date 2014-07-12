//
//  MainFoundation+StoryCreation.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+StoryCreation.h"
#import "MainFoundation+SimpleWordPartsCreate.h"

@implementation MainFoundation (StoryCreation)

/*
- (NSArray *) exampleSmallStoryObject01: (Character*) theCharacter
{
    NSDictionary* sentence03 = @{
                                 @"subject":@"square",
                                 @"verb":@"BE",
                                 @"object":[self newAdjForSimpleWordPart:self.managedObjectContext]};

    NSArray* myStory = [NSArray arrayWithObjects:sentence03,nil];
    return myStory;
}

- (NSArray *) exampleSmallStoryObject02: (Character*) theCharacter
{
    NSDictionary* sentence03 = @{@"subject_adjective":@"happy",
                                 @"subject":@"heartattack",
                                 @"verb":@"has",
                                 @"object_adjective":@"lazy",
                                 @"object":@"monsterface",
                                 @"preposition":@"near",
                                 @"preposition_adjective":@"sad",
                                 @"preposition_object":@"banana",
                                 };

    NSArray* myStory = [NSArray arrayWithObjects:sentence03,nil];
    return myStory;
}
*/

- (NSArray *) exampleStoryObject: (Character*) theCharacter
{
    //identity
    NSDictionary* sentence01 = @{@"subject":theCharacter.whatSpecie,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatSpecie};

    NSDictionary* sentence02 = @{ @"subject":theCharacter.whatNationality,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatNationality};
    
    NSDictionary* sentence03 = @{@"subject":theCharacter.whatGender,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatGender};
    
    NSDictionary* sentence04 = @{@"subject":theCharacter.whatJob,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatJob};
    
    NSDictionary* sentence05 = @{@"subject":theCharacter.whatAge,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatAge};
    
    NSDictionary* sentence06 = @{@"subject":theCharacter.whatDisposition,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatDisposition};
    // singular description
    NSDictionary* sentence07 = @{@"subject":theCharacter.whatLocation,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatLocation};
    // singular description
    NSDictionary* sentence08 = @{@"subject":theCharacter.whatHairColor,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatHairColor};
    // singular description
    NSDictionary* sentence09 = @{@"subject":theCharacter.whatEyeColor,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatEyeColor};
    // singular description
    NSDictionary* sentence10 = @{@"subject":theCharacter.whatBirthday,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatBirthday};
    // singular description
    NSDictionary* sentence11 = @{@"subject":theCharacter.whatHome,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatHome};
    
    // no possesive
    NSDictionary* sentence12 = @{
                                 @"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":@"wear",
                                 @"object":theCharacter.whatClothes};

    // no possesive
    NSDictionary* sentence13 = @{@"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":theCharacter.whatLike,
                                 @"object_infinitive":@"to eat",
                                 @"object_determiner":@"generalization",
                                 @"object":theCharacter.whatLike};
    
    // no possesive
    NSDictionary* sentence14 = @{@"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":theCharacter.whatDislike,
                                 @"object_determiner":@"generalization",
                                 @"object":theCharacter.whatDislike};

    NSDictionary* sentence15 = @{@"sentence_single_unpack":@"1",
                                 @"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":theCharacter.whatEvent,
                                 @"object":theCharacter.whatEvent};
    
    NSDictionary* sentence16 = @{@"sentence_single_unpack":@"0",
                                 @"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":theCharacter.whatEvent,
                                 @"object":theCharacter.whatEvent};
    
    NSDictionary* sentence17 = @{@"subject":theCharacter.whatGoal,
                                 @"verb":@"BE",
                                 @"object_infinitive":theCharacter.whatGoal,
                                 @"object":theCharacter.whatGoal};
    
    NSDictionary* sentence18 = @{@"subject":theCharacter.whatWeight,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatWeight};
    
    NSDictionary* sentence19 = @{@"subject":theCharacter.whatHeight,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatHeight};
    

    NSArray* myStory = @[sentence01,sentence02,sentence03,sentence04,sentence05,sentence06,sentence07,sentence08,sentence09,sentence10,sentence11,sentence12,sentence13,sentence14,sentence15,sentence16,sentence17,sentence18,sentence19];

    return myStory;
}

//
// large example
//
/*
- (NSArray *) exampleStory02Object: (Character*) theCharacter
{
    //identity
    NSDictionary* sentence01 = @{@"subject":theCharacter.name,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatSpecie.name};

    NSDictionary* sentence02 = @{@"subject_determiner":@"possesive",
                                 @"subject":theCharacter.whatBirthday.metaType,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatBirthday.dataString};

    NSDictionary* sentence03 = @{@"subject_determiner":@"possesive",
                                 @"subject_type":@"metaType",
                                 @"subject":[theCharacter.whatJob allObjects],
                                 @"verb":@"BE",
                                 @"object_type":@"name",
                                 @"object":[theCharacter.whatJob allObjects]};

    NSDictionary* sentence04 = @{@"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":@"BE",
                                 @"object":@"EMPTY",
                                 @"preposition":@"near",
                                 @"preposition_type":@"current",
                                 @"preposition_object":[theCharacter.whatLocation allObjects]};
    // singular description
    NSDictionary* sentence05 = @{@"subject_determiner":@"possesive",
                                 @"subject":theCharacter.whatHairColor.metaType,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatHairColor.name};

    NSDictionary* sentence06 = @{@"subject_determiner":@"possesive",
                                 @"subject":theCharacter.whatGender.metaType,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatGender.name};
    
    NSDictionary* sentence07 = @{@"subject_determiner":@"possesive",
                                 @"subject":theCharacter.whatHome.metaType,
                                 @"verb":@"BE",
                                 @"object":theCharacter.whatHome.name};
    
    NSDictionary* sentence08 = @{@"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb":@"has",
                                 @"object_type":@"name",
                                 @"object":[theCharacter.whatClothes allObjects]};

    NSDictionary* sentence09 = @{@"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb_type":@"metaType",
                                 @"verb":[theCharacter.whatLike allObjects],
                                 @"object_determiner":@"generalization",
                                 @"object_type":@"name",
                                 @"object":[theCharacter.whatLike allObjects]};

    NSDictionary* sentence10 = @{@"subject_pronoun":@"YES",
                                 @"subject":theCharacter,
                                 @"verb_type":@"metaType",
                                 @"verb":[theCharacter.whatDislike allObjects],
                                 @"object_determiner":@"generalization",
                                 @"object_type":@"name",
                                 @"object":[theCharacter.whatDislike allObjects]};

    NSDictionary* sentence11 = @{@"subject_determiner":@"possesive",
                                 @"subject_type":@"metaType",
                                 @"subject":[theCharacter.whatGoal allObjects],
                                 @"verb":@"BE",
                                 @"object_infinitive":@"to learn to play",
                                 @"object_type":@"name",
                                 @"object":[theCharacter.whatGoal allObjects]};
    
    NSArray* myStory = [NSArray arrayWithObjects:sentence01,sentence02,sentence03,sentence04,sentence05,sentence06,sentence07,sentence08,sentence09,sentence10,sentence11,nil];

    return myStory;
}

*/


@end
