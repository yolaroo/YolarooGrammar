//
//  MainFoundation+MakeAStoryDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

#import "CharacterMaker.h"
@class CharacterMaker;

@interface MainFoundation (MakeAStoryDataLoader)

- (NSArray*) myArrayAdvancedSetter: (CharacterMakerValue)myCharacterMakerValue withContext: (NSManagedObjectContext*)context;

- (void) writeCharacterToDatbase: (CharacterMaker*) aCharacter withEventSet: (NSSet*) eventSet withContext: (NSManagedObjectContext*) context;
- (void) deletePropertyAction: (CharacterMakerValue)myCharacterMakerValue withCharacter: (CharacterMaker*)myCharacter;
- (void) testCharacterfill: (CharacterMaker*)myCharacter;

- (CharacterMakerValue) choiceButtonPress: (NSInteger) myTag;

@end
