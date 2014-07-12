//
//  MakeAStoryView.m
//  YolarooGrammar
//
//  Created by MGM on 5/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MakeAStoryView.h"

#import "Word.h"
#import "MainFoundation+WordSearch.h"
#import "MainFoundation+AdjectiveSearch.h"
#import "MainFoundation+Notifications.h"
#import "MainFoundation+MakeAStoryDataLoader.h"

#import "MainFoundation+EventOptionsDataForCharacter.h"
#import "Event+Create.h"
#import "CharacterMaker+CreateCharacter.h"
#import "MainFoundation+SentenceController.h"
#import "MainFoundation+MakeACharacterSearches.h"

#import <objc/message.h>

//
////
//

#import "EventMaker.h"
@class EventMaker;

#import "CharacterMaker.h"
@class CharacterMaker;

#import "GoalMaker.h"
@class GoalMaker;

//
////
//

@interface MakeAStoryView ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *myBG;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *myLabelCollection;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

//
////
//

@property (weak, nonatomic) IBOutlet UILabel *labelForSpecie;
@property (weak, nonatomic) IBOutlet UILabel *labelForClothes;
@property (weak, nonatomic) IBOutlet UILabel *labelForLocation;

@property (weak, nonatomic) IBOutlet UILabel *labelForHome;
@property (weak, nonatomic) IBOutlet UILabel *labelForHairColor;
@property (weak, nonatomic) IBOutlet UILabel *labelForEyeColor;
@property (weak, nonatomic) IBOutlet UILabel *labelForJob;

@property (weak, nonatomic) IBOutlet UILabel *labelForFood;
@property (weak, nonatomic) IBOutlet UILabel *labelForDislikes;
@property (weak, nonatomic) IBOutlet UILabel *labelForDisposition;
@property (weak, nonatomic) IBOutlet UILabel *labelForDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelForHeight;
@property (weak, nonatomic) IBOutlet UILabel *labelForWeight;
@property (weak, nonatomic) IBOutlet UILabel *labelForGender;

@property (weak, nonatomic) IBOutlet UILabel *labelForNationality;
@property (weak, nonatomic) IBOutlet UILabel *labelForBirthday;
@property (weak, nonatomic) IBOutlet UILabel *labelForAge;
@property (weak, nonatomic) IBOutlet UILabel *labelForEvent;
@property (weak, nonatomic) IBOutlet UILabel *labelForGoal;

//
////
//

@property (strong, nonatomic) NSArray* recordCheck;
@property (strong, nonatomic) NSManagedObject* selectedRecord;
@property (nonatomic) BOOL isSelectingRecord;
@property (strong, nonatomic) NSMutableString* recordCheckUpType;

@property (nonatomic) CharacterMakerValue myCharacterMakerValue;
@property (strong, nonatomic) CharacterMaker* myCharacter;
@property (strong, nonatomic) EventMaker* myEvent;
@property (strong, nonatomic) GoalMaker* myGoal;

@property (nonatomic) BOOL hasPressedSave;

//
////
//

@end

@implementation MakeAStoryView

@synthesize recordCheck=_recordCheck,speechTextField=_speechTextField;

#define DARK_COLOR [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:0.2f]
#define NORMAL_COLOR [UIColor colorWithRed:164.0f/255.0f green:164.0f/255.0f blue:164.0f/255.0f alpha:0.2f]
#define DARK_TEXT [UIColor colorWithRed: 180.0f/255.0f green:180.0f/255.0f blue:180.0f/255.0f alpha:1.0f]
#define LIGHT_TEXT [UIColor colorWithRed: 220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f]
#define HIGHTLIGHT_TEXT [UIColor colorWithRed: 220.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:0.4f]

#define DK 2
#define LOG if(DK == 1)

//
//
////////
#pragma mark - Delete Property Button
////////
//
//

- (IBAction)deletePropertyActionPress:(UIButton *)sender {
    [self deletePropertyAction:self.myCharacterMakerValue withCharacter:self.myCharacter];
    [self deleteLabelAction: self.myCharacterMakerValue];
}

- (void) deleteLabelAction: (CharacterMakerValue)myCharacterMakerValue {
    if (myCharacterMakerValue == kChMaSpecie) {
        self.labelForSpecie.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaWeight) {
        self.labelForWeight.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaHeight) {
        self.labelForHeight.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaLocation) {
        self.labelForLocation.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaJob) {
        self.labelForJob.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaHome) {
        self.labelForHome.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaHairColor) {
        self.labelForHairColor.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaEyeColor) {
        self.labelForEyeColor.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaNationality) {
        self.labelForNationality.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaGender) {
        self.labelForGender.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaBirthday) {
        self.labelForBirthday.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaAge) {
        self.labelForAge.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaFavoriteFoods) {
        self.labelForFood.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaDisposition) {
        self.labelForDisposition.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaDislikes) {
        self.labelForDislikes.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaDescription) {
        self.labelForDescription.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaClothes) {
        self.labelForClothes.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaEvent) {
        self.labelForEvent.text = @"-- ";
    }
    else if (myCharacterMakerValue == kCHMaGoal) {
        self.labelForGoal.text = @"-- ";
    }
}

//
//
////////
#pragma mark - Save Button
////////
//
//

- (IBAction)characterSave:(UIButton *)sender {
    self.myActivityIndicator = [self activityIndicatorAction];
    [self performSelector:@selector(characterSaveAction) withObject:nil afterDelay:0.3];
}

- (void) characterSaveAction {
    self.myCharacter.name = self.nameTextField.text;

    //test
    //[self testCharacterfill:self.myCharacter];
    //test
    
    if ([self.myCharacter isCharacterFull]){
        [self myAlert:@"Saving"];
        if (!self.hasPressedSave){
            self.hasPressedSave = true;
            [self performSelector:@selector(theStoryWriter) withObject:nil afterDelay:.3];
        }
    }
    else {
        [self myAlert:@"Not Complete"];
        [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:.3];
    }
}

- (void) theStoryWriter {
    Character* theCharacter = [self.myCharacter writeAdvancedCharacterForMaker:self.myCharacter withContext:self.managedObjectContext];
    [self buildTheStoryFromMaker:theCharacter withContext:self.managedObjectContext];
    [self performSelector:@selector(loadFinished) withObject:nil afterDelay:.6];
}

//
//
////////
#pragma mark - Data Finished and Clear
////////
//
//

- (void) loadFinished {
    [self dataClear];
    [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:.3];
}

- (void) dataClear {
    self.hasPressedSave = false;
    self.myCharacter = nil;
    self.nameTextField.text = @"";
    for (UILabel* LBL in self.myLabelCollection){
        LBL.text = @"-- ";
    }
}

//
//
////////
#pragma mark - Button Type Choice Selection
////////
//
//

- (IBAction)buttonPress:(UIButton *)sender {
    UIButton* myButton = (UIButton*)sender;
    [self buttonAction: myButton.tag];
}

- (void) buttonAction: (NSInteger) myTag {
    self.myCharacterMakerValue = [self choiceButtonPress:myTag];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

//
//
////////
#pragma mark - Back Button
////////
//
//

- (IBAction)backSelectionPress:(UIButton *)sender {
    [self backButtonAction];
}

- (void) backButtonAction {
    self.hasClicked = false;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"needsToUpdate"
     object:self];
}

//
//
////////
#pragma mark - Table view data source
////////
//
//

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedRecordsArray count] ? [self.fetchedRecordsArray count] : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell = [self setMyCell:cell cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 1 || indexPath.row % 2) {
        cell.backgroundColor = DARK_COLOR;
        cell.textLabel.textColor = LIGHT_TEXT;
    }
    else {
        cell.backgroundColor = NORMAL_COLOR;
        cell.textLabel.textColor = DARK_TEXT;
    }
    return cell;
}

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString*myString;
    
    if (self.myCharacterMakerValue == kCHMaHeight ||
        self.myCharacterMakerValue == kCHMaWeight ||
        self.myCharacterMakerValue == kCHMaGender ||
        self.myCharacterMakerValue == kCHMaBirthday ||
        self.myCharacterMakerValue == kCHMaAge ||
        self.myCharacterMakerValue == kCHMaEvent ||
        self.myCharacterMakerValue == kCHMaGoal ) {
        
        if (self.hasClicked){
            myString = [self objectName:[self.fetchedRecordsArray objectAtIndex:indexPath.row]];
        }
        else {
            myString = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
        }
    }
    else {
        myString = [self objectName:[self.fetchedRecordsArray objectAtIndex:indexPath.row]];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = HIGHTLIGHT_TEXT;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.textLabel.text = myString;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

//
//
////////
#pragma mark - Table Action for conversion
////////
//
//

- (void) eventSave: (NSIndexPath *)indexPath withWord: (NSString*)myWord {
    self.myEvent.name = myWord;
    self.myEvent.title = [NSString stringWithFormat:@"%@%@",myWord,self.myCharacter.UUID];
    [self.myCharacter saveEventRecordToClass:self.myEvent];
    self.myEvent = nil;
    [self updateUI];
}

- (void) eventVerbSet:(NSIndexPath *)indexPath {
    self.myEvent.verb = [[self eventTypeList]objectAtIndex:indexPath.row];
    self.myEvent.object = [[self eventObjectList]objectAtIndex:indexPath.row];
}

- (void) goalSave: (NSIndexPath *)indexPath withWord: (NSString*)myWord {
    self.myGoal.name = myWord;
    [self.myCharacter saveGoalRecordToClass:self.myGoal];
    self.myGoal = nil;
    [self updateUI];
}

- (void) goalInfinitiveSet:(NSIndexPath *)indexPath {
    self.myGoal.infinitive = [[self goalInfinitiveList]objectAtIndex:indexPath.row];
}

//
////
//

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.hasClicked){ // get value from second advancedsection
        if (self.myCharacterMakerValue == kChMaSpecie ||
            self.myCharacterMakerValue == kCHMaClothes ||
            self.myCharacterMakerValue == kCHMaFavoriteFoods ||
            self.myCharacterMakerValue == kCHMaLocation ||
            self.myCharacterMakerValue == kCHMaDescription ||
            self.myCharacterMakerValue == kCHMaDisposition ||
            self.myCharacterMakerValue == kCHMaDislikes ||
            self.myCharacterMakerValue == kCHMaEvent ||
            self.myCharacterMakerValue == kCHMaGoal ) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            NSString *myWord = cell.textLabel.text;
            
            if (self.myCharacterMakerValue == kCHMaEvent) {
                [self eventSave:indexPath withWord:myWord];
            }
            else if (self.myCharacterMakerValue == kCHMaGoal) {
                [self goalSave:indexPath withWord:myWord];
            }
            else {
                if (self.myCharacterMakerValue == kChMaSpecie ||
                    self.myCharacterMakerValue == kCHMaClothes ||
                    self.myCharacterMakerValue == kCHMaFavoriteFoods ||
                    self.myCharacterMakerValue == kCHMaLocation ||
                    self.myCharacterMakerValue == kCHMaDisposition  ||
                    self.myCharacterMakerValue == kCHMaDescription ||
                    self.myCharacterMakerValue == kCHMaDislikes) {
                    [self.myCharacter saveRecordToClass:self.myCharacterMakerValue withWord:myWord];
                    [self updateUI];
                }
            }
            [self displayRecordToText];
        }
    }
    else { // first click
        if (self.myCharacterMakerValue == kChMaSpecie ||
            self.myCharacterMakerValue == kCHMaClothes ||
            self.myCharacterMakerValue == kCHMaFavoriteFoods ||
            self.myCharacterMakerValue == kCHMaLocation ||
            self.myCharacterMakerValue == kCHMaDescription ||
            self.myCharacterMakerValue == kCHMaDisposition ||
            self.myCharacterMakerValue == kCHMaDislikes ||
            self.myCharacterMakerValue == kCHMaEvent ||
            self.myCharacterMakerValue == kCHMaGoal ){ //change data
            
            if (self.myCharacterMakerValue == kCHMaDisposition ||
                self.myCharacterMakerValue == kCHMaDescription) {
                self.fetchedRecordsArray = [[self selectedAdjectiveListFromSemanticType:[self.fetchedRecordsArray objectAtIndex:indexPath.row] withContext: self.managedObjectContext]copy];
            }
            else if (self.myCharacterMakerValue == kCHMaEvent) {
                [self eventVerbSet:indexPath];
                self.fetchedRecordsArray = [[self wordListFromSemanticTypeName:[[self eventCategoryListForSemanticSearch] objectAtIndex:indexPath.row] withContext: self.managedObjectContext]copy];
            }
            else if (self.myCharacterMakerValue == kCHMaGoal) {
                [self goalInfinitiveSet:indexPath];
                self.fetchedRecordsArray = [[self wordListFromSemanticTypeName:[[self goalCategoryListForSemanticSearch] objectAtIndex:indexPath.row] withContext: self.managedObjectContext]copy];
            }
            else { // common
                self.fetchedRecordsArray = [[self wordListFromSemanticType:[self.fetchedRecordsArray objectAtIndex:indexPath.row] withContext: self.managedObjectContext]copy];
            }
            self.hasClicked = true;
            [self.tableView reloadData];
        }
        else { // get value from simple section
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            NSString *myWord = cell.textLabel.text;
            [self.myCharacter saveRecordToClass:self.myCharacterMakerValue withWord:myWord];
            [self displayRecordToText];
        }
    }
}

//
//
//////
#pragma mark - display Record
/////
//
//

- (void) displayRecordToText {
    if (self.myCharacterMakerValue == kChMaSpecie) {
        self.labelForSpecie.text = self.myCharacter.specie;
    }
    else if (self.myCharacterMakerValue == kCHMaWeight) {
        self.labelForWeight.text = self.myCharacter.weight;
    }
    else if (self.myCharacterMakerValue == kCHMaHeight) {
        self.labelForHeight.text = self.myCharacter.height;
    }
    else if (self.myCharacterMakerValue == kCHMaLocation) {
        self.labelForLocation.text = self.myCharacter.location;
    }
    else if (self.myCharacterMakerValue == kCHMaJob) {
        self.labelForJob.text = self.myCharacter.job;
    }
    else if (self.myCharacterMakerValue == kCHMaHome) {
        self.labelForHome.text = self.myCharacter.home;
    }
    else if (self.myCharacterMakerValue == kCHMaHairColor) {
        self.labelForHairColor.text = self.myCharacter.hairColor;
    }
    else if (self.myCharacterMakerValue == kCHMaEyeColor) {
        self.labelForEyeColor.text = self.myCharacter.eyeColor;
    }
    else if (self.myCharacterMakerValue == kCHMaNationality) {
        self.labelForNationality.text = self.myCharacter.nationality;
    }
    else if (self.myCharacterMakerValue == kCHMaGender) {
        self.labelForGender.text = self.myCharacter.gender;
    }
    else if (self.myCharacterMakerValue == kCHMaBirthday) {
        self.labelForBirthday.text = self.myCharacter.birthday;
    }
    else if (self.myCharacterMakerValue == kCHMaAge) {
        self.labelForAge.text = self.myCharacter.age;
    }
    else if (self.myCharacterMakerValue == kCHMaFavoriteFoods) {
        self.labelForFood.text = [self.myCharacter.foodLikes firstObject];
    }
    else if (self.myCharacterMakerValue == kCHMaDisposition) {
        self.labelForDisposition.text = [self.myCharacter.disposition firstObject];
    }
    else if (self.myCharacterMakerValue == kCHMaDislikes) {
        self.labelForDislikes.text = [self.myCharacter.dislikes firstObject];
    }
    else if (self.myCharacterMakerValue == kCHMaDescription) {
        self.labelForDescription.text = [self.myCharacter.description firstObject];
    }
    else if (self.myCharacterMakerValue == kCHMaClothes) {
        NSString* clothesNames;
        if ([self.myCharacter.clothes count] > 1) {
            clothesNames = [NSString stringWithFormat:@"%@ - %@",[self.myCharacter.clothes firstObject],[self.myCharacter.clothes objectAtIndex:1]];
        }
        else {
            clothesNames = [self.myCharacter.clothes firstObject];
        }
        self.labelForClothes.text = clothesNames;
    }
    else if (self.myCharacterMakerValue == kCHMaEvent) {
        EventMaker*thisEvent = [self.myCharacter.events firstObject];
        NSString* myEventString;
        if ([self.myCharacter.events count] > 1) {
            EventMaker*mySecondEvent = [self.myCharacter.events objectAtIndex:1];
            myEventString =[NSString stringWithFormat:@"%@ %@ - %@ %@",thisEvent.verb,thisEvent.name,mySecondEvent.verb,mySecondEvent.name];
        }
        else {
            myEventString = [NSString stringWithFormat:@"%@ %@",thisEvent.verb,thisEvent.name];
        }
        self.labelForEvent.text = myEventString;
    }
    else if (self.myCharacterMakerValue == kCHMaGoal) {
        GoalMaker* thisGoal = [self.myCharacter.goals firstObject];
        NSString* myGoalString = [NSString stringWithFormat:@"%@ %@",thisGoal.infinitive,thisGoal.name];
        self.labelForGoal.text = myGoalString;
    }
}

//
//
///////
#pragma mark - DataLoad
//////
//
//

- (NSArray*) myArraySetter {
    @try {
        NSArray*mine = [[self myArrayAdvancedSetter:self.myCharacterMakerValue withContext:self.managedObjectContext]copy];
        return mine;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

//
//
///////
#pragma mark - Notification
//////
//
//

- (void) loadViewNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(resetDataNotifier:)
     name:@"needsToUpdate"
     object:nil];
}

- (void)resetDataNotifier:(NSNotification *)notification {
    [self performSelector:@selector(resetAction) withObject:nil afterDelay:0.3];
}

//
//
///////
#pragma mark - Update UI
//////
//
//

- (void) resetAction {
    [self updateUI];
}

- (void) updateUI
{
    self.hasClicked = false;
    self.fetchedRecordsArray = [[self myArraySetter] copy];
    [self.tableView reloadData];
}

//
////
//

- (void) initialLoad {
    [self loadViewNotification];
    self.myCharacterMakerValue = kChMaSpecie;
}

- (void) scrollViewSet {
    double myScrollOffset = 1.25;
    self.myScrollView.contentSize = CGSizeMake( self.myScrollView.frame.size.width*myScrollOffset , self.myScrollView.frame.size.height );
    [self.myScrollView setContentOffset:CGPointMake(0,0) animated:YES];
}

//
//
////////
#pragma mark - Life Cycle
////////
//
//

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self loadNotifications];
    [self viewStyleForLoad];
    self.myBG.image = [self loadBGImage:@"iphonewood"];
    [self scrollViewSet];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    
    [self initialLoad ];
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3];
    [self flipScreen];
}

- (void) flipScreen {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationLandscapeLeft );
    }
}

//
//
////////
#pragma mark - style
////////
//
//

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
}

//
//
////////
#pragma mark - setters
////////
//
//

- (CharacterMaker*) myCharacter {
    if (!_myCharacter) {
        _myCharacter = [[CharacterMaker alloc]init];
    }
    return _myCharacter;
}

- (EventMaker*) myEvent {
    if (!_myEvent) {
        _myEvent = [[EventMaker alloc]init];
    }
    return _myEvent;
}

- (GoalMaker*) myGoal {
    if (!_myGoal) {
        _myGoal = [[GoalMaker alloc]init];
    }
    return _myGoal;
}

@end
