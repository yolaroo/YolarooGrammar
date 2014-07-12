//
//  ViewController.h
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
@import AVFoundation;
#import <CoreText/CoreText.h>

#import "GrammarDelegate.h"

#import "Word.h"
#import "SemanticType.h"
#import "SyntacticType.h"
#import "AdjectiveClass.h"
#import "AdjectiveSemanticType.h"
#import "Determiner.h"
#import "SententialAdjective.h"
#import "PrepositionalPhrase.h"

#import "SynonymObjectClass.h"
#import "SynonymWordClass.h"

#import "GrammarWordList.h"
#import "GrammarWordDataModel.h"
#import "GrammarWord.h"
#import "GrammarWordSemanticType.h"

#import "ObjectPhrase.h"
#import "NounProperties.h"
#import "SubjectPhrase.h"
#import "SententialVerb.h"
#import "VerbWord.h"
#import "VerbSemanticType.h"

#import "ComparisonObject.h"

#import "Character.h"

#import "Specie.h"
#import "Job.h"
#import "Duty.h"
#import "Location.h"
#import "Goal.h"
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
#import "Copula.h"
#import "SententialVerb.h"
#import "Story.h"
#import "Sentence.h"
#import "SubjectPhrase.h"
#import "BodyPart.h"
#import "Statements.h"
#import "SocialGroup.h"
#import "Belief.h"
#import "Weight.h"
#import "Height.h"
#import "Disposition.h"
#import "Nationality.h"

//
//
//////
#pragma mark - Class imports
//////
//
//

#import "TimerTest.h"
@class TimerTest;

#import "SpeechClass.h"
@class SpeechClass;

#import "SwipeClass.h"
@class SwipeClass;

//
//
//////
#pragma mark - Enum
//////
//
//

typedef NS_ENUM(NSInteger, AdjectiveValue)  {
    kAdjectiveElementary,
    kAdjectiveWeather,
    kAdjectiveCommoncopular,
    kAdjectiveNations,
    kAdjectiveEyecolor,
    kAdjectiveHaircolor,
    kAdjectiveHairstyle,
    kAdjectiveColor,
    kAdjectivePositive,
    kAdjectiveAbilityPositive,
    kAdjectiveLooksPositive,
    kAdjectiveHealthPositive,
    kAdjectiveSocial,
    kAdjectivePsychologicalPositive,
    kAdjectivePsychologicalNegative,
    kAdjectiveNominalPsychological,
    kAdjectiveVerbalPsychological,
    kAdjectiveTasteAndSmell,
    kAdjectiveStatus,
    kAdjectiveShape,
    kAdjectiveBasicComparisonMeasurement,
    kAdjectiveBasicComparisonValue,
    kAdjectiveComparisonMeasurement,
    kAdjectiveNatureAndSenses,
    kAdjectiveNeutral,
    kAdjectiveAbilityNegative,
    kAdjectiveNegative,
    kAdjectiveHealthNegative,
    kAdjectiveLooksNegative,
    kAdjectiveBiological,
    kAdjectiveBusiness,
    kAdjectiveEpistemological,
    kAdjectiveAbstract,
};

typedef NS_ENUM(NSInteger, WordValue)  {
    kWordCategories,
    kWordCommonTerms,
    kWordCommonPossessions,
    kWordMusicians,
    kWordMusic,
    kWordBooks,
    kWordMovies,
    kWordPronouns,
    kWordBoysNames,
    kWordGirlsNames,
    kWordSpecies,
    kWordFish,
    kWordShellfish,
    kWordAmphibians,
    kWordReptiles,
    kWordAquaticAnimals,
    kWordAquaticMammals,
    kWordAcademics,
    kWordAppliances,
    kWordBirds,
    kWordBugs,
    kWordWorms,
    kWordBodyParts,
    kWordClothesTops,
    kWordClothesBottoms,
    kWordClothesAccessories,
    kWordClothesUndergarments,
    kWordClothesOuterWear,
    kWordClothesFootwear,
    kWordClothesWomensFootwear,
    kWordClothesWomensWear,
    kWordClothesMensWear,
    kWordClothes,
    kWordCountries,
    kWordDinosaurs,
    kWordDirections,
    kWordDogs,
    kWordDrinks,
    kWordKitchenware,
    kWordFruits,
    kWordFamily,
    kWordFurniture,
    kWordFood,
    kWordSauces,
    kWordDesserts,
    kWordFlowers,
    kWordFarmAnimals,
    kWordToys,
    kWordSportsEquipment,
    kWordSports,
    kWordLuxuryGoods,
    kWordElectronics,
    kWordHerbs,
    kWordInstruments,
    kWordJobs,
    kWordLinens,
    kWordLandmarks,
    kWordHomes,
    kWordRooms,
    kWordRegions,
    kWordLocations,
    kWordNaturalLocations,
    kWordNaturalObjects,
    kWordPlants,
    kWordBeans,
    kWordBerries,
    kWordGrains,
    kWordNuts,
    kWordNumbers,
    kWordPlanets,
    kWordAstronomicalObjects,
    kWordPets,
    kWordPests,
    kWordPersonalCareObjects,
    kWordReligions,
    kWordPlacesOfWorship,
    kWordSnakes,
    kWordShapes,
    kWordSchoolSupplies,
    kWordMonths,
    kWordDaysOfTheWeek,
    kWordTime,
    kWordSeasons,
    kWordVehicles,
    kWordAquaticVehicles,
    kWordAerialVehicles,
    kWordTransportationLocations,
    kWordVegetables,
    kWordRootVegetables,
    kWordGourds,
    kWordTemperature,
    kWordCosmetics,
    kWordWines,
    kWordMeasurement,
    kWordMythicalCreatures,
    kWordWeather,
    kWordNaturalDisasters,
    kWordCompanies,
    kWordUniversities,
    kWordMeat,
};

typedef NS_ENUM(NSInteger, ObjectDefine)  {
    kObjectIsString,
    kObjectIsSet,
    kObjectIsObject,
    kObjectIsEmpty,
    kObjectIsMXO,
};

typedef NS_ENUM(NSInteger, SubjectDefine)  {
    kSubjectIsString,
    kSubjectIsSet,
    kSubjectIsObject,
    kSubjectIsEmpty,
    kSubjectIsMXO,
};

typedef NS_ENUM(NSInteger, VerbDefine)  {
    kVerbIsString,
    kVerbIsSet,
    kVerbIsObject,
    kVerbIsEmpty,
    kVerbIsMXO,
};

typedef NS_ENUM(NSInteger, EventDefine)  {
    kEventRead,
    kEventWatch,
    kEventDrink,
    kEventFly,
    kEventDrive,
    kEventEat,
    kEventWalkto,
    kEventDriveto,
    kEventFlyto,
    kEventTravelto,
};

@interface MainFoundation : UIViewController

//
//
//////
//
//////
//
//

//
#pragma mark - Speech
//

@property (strong,nonatomic) SpeechClass* mySpeechClass;
@property (strong,nonatomic) SwipeClass* mySwipeClass;

//
#pragma mark - Data
//

@property (nonatomic, strong) NSArray* fetchedRecordsArray;
@property (nonatomic) BOOL hasClicked;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext* seedManagedObjectContext;

//
#pragma mark - indicator
//

@property (strong,nonatomic) UIActivityIndicatorView* myActivityIndicator;
- (UIActivityIndicatorView *) activityIndicatorAction;
- (void) stopActivityIndicator;

//
#pragma mark - audio
//

- (void) foundationRunSpeech: (NSArray*) speechArray;
- (void) foundationStopSpeech;

//
#pragma mark - Wordlists
//

- (NSArray*) foundationAdjectiveListArray;
- (NSArray*) foundationWordListArray;

//
#pragma mark - managed object action
//

- (NSManagedObject*) myObject: (NSSet*) set;

- (NSString*) objectName: (NSManagedObject*)myObject;
- (NSString*) objectType: (NSManagedObject*)myObject;
- (NSString*) objectVerb: (NSManagedObject*)myObject;

//
#pragma mark - sentence style
//

- (NSString*) sentenceSpaceFixer: (NSString*) theSentence withCaps: (BOOL)isInCaps;
- (NSString*) zeroSpaceFixer: (NSString*) theSentence;

//
#pragma mark - date
//

- (NSString*) dateStyle: (NSDate*)myDate;
- (NSString*) dateStyleNoYear: (NSDate*)myDate;
- (NSString *) addSuffixToNumber:(NSInteger) myNumber;
- (NSString*) addSuffixToFullDate:(NSString*)myString;

- (NSNumber*) ageComputation: (NSDate*)dateForBirth;

- (BOOL) isItDate: (NSString*) theString;

//
#pragma mark - data save
//

- (void) saveData: (NSManagedObjectContext*)myContext;

//
#pragma mark - randomizers
//

- (bool) oneInTwo;
- (bool) oneInFour;
- (bool) oneInThree;
- (bool) oneInTen;

//
#pragma mark - styles
//

- (void) buttonShadow: (UIButton*)shadowObject;
- (void) viewShadow: (UIView*)shadowObject;
- (void) labelShadow: (UILabel*)shadowObject;

//
#pragma mark - timer test
//

@property (strong,nonatomic) TimerTest* myTimerTest;
@property (nonatomic) NSTimer * myTimer;
- (void) timeRunGameForTest;
- (void) timeTestStart;
- (void) timeTestUpdate;

//
#pragma mark - textfix
//

- (IBAction)textFieldFinished:(id)sender;

//
#pragma mark - swipe action
//

- (void) foundationSwipeSingleLoad: (UIView*)view;
- (void) loadSwipeNotification;

//
#pragma mark - orientation lock
//

- (BOOL) isPortraitOrientation;
- (void) portraitLock;
- (void) portraitUnLock;

//
#pragma mark - utilities
//

- (UIImage*) loadBGImage: (NSString*) nameOfBG;

- (NSArray*) shuffleArray:(NSArray*)myArray;
- (NSArray*) removeDuplicateObjects: (NSArray*) myArray;
- (NSString *) buildUUID;
- (void) clearButton: (NSArray*)buttonCollection;
- (BOOL) myArrayIndexIsOk: (NSInteger) myIndex withArray: (NSArray*) myArray;
- (void) myAlert: (NSString*)myString;


@end
