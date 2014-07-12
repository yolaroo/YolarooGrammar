//
//  CharacterMaker.m
//  YolarooGrammar
//
//  Created by MGM on 5/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "CharacterMaker.h"


@implementation CharacterMaker

@synthesize foodLikes=_foodLikes,dislikes=_dislikes,disposition=_disposition,description=_description,clothes=_clothes,events=_events;

//
//
////////
#pragma mark - init
////////
//
//

-(id) init {

    if (self = [super init]) {
        [self writeUUID];
    }
    return self;
}

//
//
////////
#pragma mark - uuid
////////
//
//

- (void) writeUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    NSString *uuidString =
    (__bridge_transfer NSString *)CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    self.UUID = uuidString;
}

//
//
////////
#pragma mark - Save Check
////////
//
//

- (BOOL) isCharacterFull
{
    if (![self.name length]){
        return false;
    }
    if (![self.UUID length]){
        return false;
    }
    if (![self.specie length]){
        return false;
    }
    if (![self.home length]){
        return false;
    }
    if (![self.location length]){
        return false;
    }
    if (![self.job length]){
        return false;
    }
    if (![self.hairColor length]){
        return false;
    }
    if (![self.eyeColor length]){
        return false;
    }
    if (![self.weight length]){
        return false;
    }
    if (![self.height length]){
        return false;
    }
    if (![self.birthday length]){
        return false;
    }
    if (![self.gender length]){
        return false;
    }
    if (![self.age length]){
        return false;
    }
    if (![self.nationality length]){
        return false;
    }
    if (![self.foodLikes count]){
        return false;
    }
    if (![self.dislikes count]){
        return false;
    }
    if (![self.disposition count]){
        return false;
    }
    if (![self.description count]){
        return false;
    }
    if ([self.clothes count] < 2){
        return false;
    }
    if ([self.events count] < 2){
        return false;
    }
    if (![self.goals count]){
        return false;
    }
    return true;
}

//
//
////////
#pragma mark - Save Data
////////
//
//

- (void) saveRecordToClass: (CharacterMakerValue)myCharacterMakerValue withWord: (NSString*)myWord
{
    if (myCharacterMakerValue == kChMaSpecie) {
        self.specie = myWord;
    }
    else if (myCharacterMakerValue == kCHMaWeight) {
        self.weight = myWord;
    }
    else if (myCharacterMakerValue == kCHMaHeight) {
        self.height = myWord;
    }
    else if (myCharacterMakerValue == kCHMaLocation) {
        self.location = myWord;
    }
    else if (myCharacterMakerValue == kCHMaJob) {
        self.job = myWord;
    }
    else if (myCharacterMakerValue == kCHMaHome) {
        self.home = myWord;
    }
    else if (myCharacterMakerValue == kCHMaHairColor) {
        self.hairColor = myWord;
    }
    else if (myCharacterMakerValue == kCHMaEyeColor) {
        self.eyeColor = myWord;
    }
    else if (myCharacterMakerValue == kCHMaNationality) {
        self.nationality = myWord;
    }
    else if (myCharacterMakerValue == kCHMaGender) {
        self.gender = myWord;
    }
    else if (myCharacterMakerValue == kCHMaBirthday) {
        self.birthday = myWord;
    }
    else if (myCharacterMakerValue == kCHMaAge) {
        self.age = myWord;
    }
    else if (myCharacterMakerValue == kCHMaFavoriteFoods) {
        [self.foodLikes addObject: myWord];
    }
    else if (myCharacterMakerValue == kCHMaDisposition) {
        [self.disposition addObject: myWord];
    }
    else if (myCharacterMakerValue == kCHMaDislikes) {
        [self.dislikes addObject: myWord];
    }
    else if (myCharacterMakerValue == kCHMaDescription) {
        [self.description addObject: myWord];
    }
    else if (myCharacterMakerValue == kCHMaClothes) {
        [self.clothes addObject: myWord];
    }
}

- (void) saveGoalRecordToClass: (GoalMaker*)myGoal
{
    [self.goals addObject: myGoal];
}

- (void) saveEventRecordToClass: (EventMaker*)myEvent
{
    [self.events addObject: myEvent];
}

//
//
////////
#pragma mark - Setters
////////
//
//

- (NSMutableArray*) foodLikes {
    if(!_foodLikes) {
        _foodLikes = [[NSMutableArray alloc]init];
    }
    return _foodLikes;
}

- (NSMutableArray*) dislikes {
    if(!_dislikes) {
        _dislikes = [[NSMutableArray alloc]init];
    }
    return _dislikes;
}

- (NSMutableArray*) disposition {
    if(!_disposition) {
        _disposition = [[NSMutableArray alloc]init];
    }
    return _disposition;
}

- (NSMutableArray*) description {
    if(!_description) {
        _description = [[NSMutableArray alloc]init];
    }
    return _description;
}

- (NSMutableArray*) clothes {
    if(!_clothes) {
        _clothes = [[NSMutableArray alloc]init];
    }
    return _clothes;
}

- (NSMutableArray*) events {
    if(!_events) {
        _events = [[NSMutableArray alloc]init];
    }
    return _events;
}

- (NSMutableArray*) goals {
    if(!_goals) {
        _goals = [[NSMutableArray alloc]init];
    }
    return _goals;
}



@end
