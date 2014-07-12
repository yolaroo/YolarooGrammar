//
//  MainFoundation+CharacterCreate.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+CharacterCreate.h"

#import "AdjectiveClass.h"

#import "Specie+Create.h"
#import "Location+Create.h"
#import "Likes+Create.h"
#import "Dislikes+Create.h"

#import "Job+Create.h"
#import "Clothes+Create.h"
#import "Goal+Create.h"
#import "Home+Create.h"
#import "Birthday+Create.h"
#import "Gender+Create.h"
#import "HairColor+Create.h"
#import "Age+Create.h"
#import "EyeColor+Create.h"

#import "Weight+Create.h"
#import "Height+Create.h"
#import "Disposition+Create.h"

#import "Nationality+Create.h"

#import "MainFoundation+AdjectiveSearch.h"

#import "MainFoundation+EventOptionsDataForCharacter.h"

@implementation MainFoundation (CharacterCreate)

#define DK 2
#define LOG if(DK == 1)

- (Character*) writeCharacter: (NSManagedObjectContext*) context
{
    ////
    //test
    //[self timeTestStart];
    //test
    ////
    
    NSMutableArray* myCharacterData = [[NSMutableArray alloc] init];
    
    NSString* gender = [self setRandomGender];
    NSString* name;
    if ([gender isEqualToString:@"male"] || [gender isEqualToString:@"boy"]){
        name = [self randomWordFromSemanticType:@"boy's names" withContext:context];
    }
    else {
        name = [self randomWordFromSemanticType:@"girl's names" withContext:context];
    }
    Gender* theGender = [Gender genderWithName:gender withContext:context];
    
    NSString* hairColorColor = [self randomAdjectiveFromSemanticType:@"hair color" withContext:context];
    HairColor* theHairColor = [HairColor hairColorWithColor:hairColorColor withContext:context];
    
    NSString* eyeColorColor = [self randomAdjectiveFromSemanticType:@"eye color" withContext:context];
    EyeColor* theEyeColor = [EyeColor eyeColorWithColor:eyeColorColor withContext:context];

    NSDate* dateForBirth = [self randomDate];
    Birthday* theBirthday = [Birthday birthdayWithDate:dateForBirth withDateString:[self dateStyleNoYear:dateForBirth] withContext:context];

    NSString* specie = [self randomWordFromSemanticType:@"species" withContext:context];
    
    NSString* currentLocationName = [self randomWordFromSemanticType:@"locations" withContext:context];
    
    NSNumber* age = [self ageComputation:dateForBirth];
    
    NSString* nation = [self randomAdjectiveFromSemanticType:@"nations" withContext:context];
    Nationality* theNationality = [Nationality nationalityWithName:nation withContext:context];

    LOG NSLog(@"(nationality) %@",theNationality.name);
    
    //
    ///
    /////
    ///
    //
    
    Word* homeWord = [self randomObjectFromSemanticType:@"homes" withContext:context];
    Word* likeWord = [self randomObjectFromSemanticType:@"food" withContext:context];
    Word* hateWord = [self randomObjectFromSemanticType:@"pests" withContext:context];
    Word* clothesWordTop = [self randomObjectFromSemanticTypeWithRelaxedConditions:@"clothes tops" withContext:context];
    Word* clothesWordBottom = [self randomObjectFromSemanticTypeWithRelaxedConditions:@"clothes bottoms" withContext:context];

    LOG NSLog(@"(age) %@",age);
    NSString* jobName;
    NSNumber* theHeight;
    NSNumber* theWeight;

    if ([age integerValue] <= 18 ){
        jobName = @"student";
        
        if ([age integerValue] <= 11 ){
            theHeight = [NSNumber numberWithInteger:100+(NSInteger)arc4random_uniform(15)];
            theWeight = [NSNumber numberWithInteger:40+(NSInteger)arc4random_uniform(30)];
        }
        else {
            theHeight = [NSNumber numberWithInteger:150+(NSInteger)arc4random_uniform(15)];
            theWeight = [NSNumber numberWithInteger:85+(NSInteger)arc4random_uniform(20)];
        }
    }
    else {
        jobName= [self randomWordFromSemanticType:@"jobs" withContext:context];
        theHeight = [NSNumber numberWithInteger:170+(NSInteger)arc4random_uniform(25)];
        theWeight = [NSNumber numberWithInteger:95+(NSInteger)arc4random_uniform(40)];
    }
    
    NSString* goalName = [self randomWordFromSemanticType:@"instruments" withContext:context];
    
    //
    ////
    // add simples 0-7
    ////
    //
    
    NSString* UUID = [self buildUUID];
    [myCharacterData addObject: UUID];
    [myCharacterData addObject: name];
    [myCharacterData addObject:[self setNSNumber:@"0"]]; //display order
    [myCharacterData addObject: theBirthday];
    [myCharacterData addObject:theGender];
    [myCharacterData addObject:theHairColor];
    [myCharacterData addObject:[NSNumber numberWithBool:FALSE]]; //plural
    
    //
    ////
    //object section
    ////
    //
    
    //specie
    Specie* theSpecie = [Specie specieWithName:specie withContext:context];
    [myCharacterData addObject:theSpecie];
    
    //location
    Location* theCurrentlocationObject = [Location locationWithName:currentLocationName  withContext:context];
    theCurrentlocationObject.isCurrent = [NSNumber numberWithBool:TRUE];
    NSSet* locationsSet = [NSSet  setWithObjects:theCurrentlocationObject, nil];
    [myCharacterData addObject:locationsSet];

    //home
    Home* theHomelocationObject = [Home homeWithString:homeWord.english withContext:context];
    [myCharacterData addObject:theHomelocationObject];

    //like    
    Likes* likeObject = [Likes likesWithWordObject:likeWord withContext:context];
    NSSet* likeSet = [NSSet  setWithObjects:likeObject, nil];
    [myCharacterData addObject:likeSet];

    //dislike
    Dislikes* hateObject = [Dislikes dislikesWithWordObject:hateWord withContext:context];
    NSSet* hateSet = [NSSet  setWithObjects:hateObject, nil];
    [myCharacterData addObject:hateSet];

    //job
    Job* theJobObject = [Job jobWithName:jobName withContext:context];
    NSSet* jobSet = [NSSet  setWithObjects:theJobObject,nil];
    [myCharacterData addObject:jobSet];
    
    //clothes
    Clothes* theClothesObjectTop = [Clothes clothesWithWordObject:clothesWordTop withContext:context];
    Clothes* theClothesObjectBottom = [Clothes clothesWithWordObject:clothesWordBottom withContext:context];
    NSSet* clothesSet = [NSSet  setWithObjects:theClothesObjectTop,theClothesObjectBottom, nil];
    [myCharacterData addObject:clothesSet];

    //goal
    Goal* theGoalObject = [Goal goalWithNameandInfinitive:goalName withInfinitive:@"to learn to play" withContext:context];
    NSSet* goalSet = [NSSet setWithObjects:theGoalObject, nil];
    [myCharacterData addObject:goalSet];
    
    //age
    Age* theAgeObject = [Age ageWithNumber:age withContext:context];
    [myCharacterData addObject:theAgeObject];
    
    //eye color
    [myCharacterData addObject:theEyeColor];
    
    //height
    Height*heightObject = [Height heightWithNumber:theHeight withContext:context];
    [myCharacterData addObject:heightObject];
    
    Weight*weightObject = [Weight weightWithNumber:theWeight withContext:context];
    [myCharacterData addObject:weightObject];
  
    //disposition
    AdjectiveClass* myDispositionAdjective = [[self shuffleArray:[self selectedAdjectiveListFromSemanticTypeWithName:@"common copular" withContext:context]]firstObject];
    
    Disposition*theDisposition = [Disposition dispositionWithName:myDispositionAdjective.basic withContext:context];
    NSSet* dispositionSet = [NSSet  setWithObjects:theDisposition, nil];
    [myCharacterData addObject:dispositionSet];

    // nation
    [myCharacterData addObject:theNationality];

    // event
    NSString* firstUUID = [NSString stringWithFormat:@"first%@",UUID];
    NSString* secondUUID = [NSString stringWithFormat:@"second%@",UUID];

    Event* theEventObject01 = [self myEventReturn:[self returnRandomEvent] withTitle:firstUUID withContext:self.managedObjectContext];
    Event* theEventObject02 = [self myEventReturn:[self returnRandomEvent] withTitle:secondUUID withContext:self.managedObjectContext];
    LOG NSLog(@"-- (EViCC) %@ %@ %@ --",theEventObject01.name,theEventObject01.verb,theEventObject01.object);
    NSSet* eventSet = [NSSet setWithObjects:theEventObject01,theEventObject02, nil];
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

//
//
////////
//
////////
//
//

#pragma mark - String to Data

- (NSDate *) randomDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];

    [components setYear:[components year] - arc4random_uniform(50) - 5];
    [components setMonth:arc4random_uniform(12)];
    NSRange range =[[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[calendar dateFromComponents:components]];
    [components setDay: arc4random_uniform ((uint32_t)range.length)];
    
    return [calendar dateFromComponents:components];
}

#pragma mark - String to NSNumber

- (NSNumber*) setNSNumber: (NSString*)myString {
    return [NSNumber numberWithInteger:[myString integerValue]];
}

#pragma mark - Set Random Gender

- (NSString*) setRandomGender {
    NSString*gender;
    if ([self oneInTwo]){
        gender = @"male";
    } else {
        gender = @"female";
    }
    return gender;
}

#pragma mark - Random Min Max

-(NSInteger)myRand:(NSUInteger) theMax {
    NSInteger myNumber = 0;
    if (theMax > 0) {
        LOG NSLog(@"count");
        myNumber = (NSInteger) arc4random() % theMax;
    } else {
        LOG NSLog(@"Count Error");
    }
    return myNumber;
}

//
//
////////
//
////////
//
//

#pragma mark - Search

- (NSString*)randomAdjectiveFromSemanticType:(NSString*)typeName withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:context];
    
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", typeName];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    AdjectiveClass*myWord = [[self shuffleArray:fetchedRecords]firstObject];
    LOG NSLog(@"%@",myWord.basic);
    return myWord.basic;
}

- (NSString*)randomWordFromSemanticType:(NSString*)typeName withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", typeName];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    Word*myWord = [[self shuffleArray:fetchedRecords]firstObject];
    LOG NSLog(@"%@",myWord.english);
    return myWord.english;
}

- (Word*)randomObjectFromSemanticType:(NSString*)typeName withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", typeName];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return [[self shuffleArray:fetchedRecords]firstObject];
}

- (Word*)randomObjectFromSemanticTypeWithRelaxedConditions:(NSString*)typeName withContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    
    NSPredicate *predicateSemanticType  = [NSPredicate predicateWithFormat:@"whatSemanticType.name CONTAINS[cd] %@", typeName];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateSemanticType, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [context executeFetchRequest:fetchRequest error:&error];
    
    return [[self shuffleArray:fetchedRecords]firstObject];
}


@end
