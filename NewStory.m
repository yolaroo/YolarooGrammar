//
//  NewStory.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "NewStory.h"
#import "MainFoundation+CharacterCreate.h"
#import "MainFoundation+CharacterSearch.h"

@interface NewStory ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewStory

#define DK 2
#define LOG if(DK == 1)

//
//
////////
////
////////
//
//

#pragma mark - Button Press

- (IBAction)testButtonPress:(UIButton *)sender {
    [self test];
}

- (void) test {
    [self writeCharacter:self.managedObjectContext];
    [self saveData:self.managedObjectContext];
    [self updateUI];
}

//
//
////////
//
////////
//
//

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedRecordsArray count] ? [self.fetchedRecordsArray count] : 0;
    //return [self.fetchedRecordsArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell = [self setMyCell:cell cellForRowAtIndexPath:indexPath];
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

    return cell;
}

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Character * theCharacter = [self.fetchedRecordsArray objectAtIndex:indexPath.row];

    if (theCharacter != nil){
        
        Birthday*theBirthday = theCharacter.whatBirthday;
        
        NSSet* jobSet = theCharacter.whatJob;
        NSArray* myJobArray = [jobSet allObjects];
        Job* mainJob = [myJobArray firstObject];

        NSSet* locactionSet = theCharacter.whatLocation;
        NSArray* myLocationArray = [locactionSet allObjects];
        Location* mainCurrentLocation = [myLocationArray firstObject];

        Home* theHome = theCharacter.whatHome;
        
        NSSet* clothesSet = theCharacter.whatClothes;
        NSArray* myClothesArray = [clothesSet allObjects];
        Clothes* mainClothes = [myClothesArray firstObject];

        NSSet* likeSet = theCharacter.whatLike;
        NSArray* myLikeArray = [likeSet allObjects];
        Likes* mainLikes = [myLikeArray firstObject];
        
        NSSet* hateSet = theCharacter.whatDislike;
        NSArray* myHateSet = [hateSet allObjects];
        Dislikes* mainHates = [myHateSet firstObject];

        NSSet* goalSet = theCharacter.whatGoal;
        NSArray* myGoalArray = [goalSet allObjects];
        Goal* mainGoals = [myGoalArray firstObject];

        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;

        cell.textLabel.text = [NSString stringWithFormat:@"%@",theCharacter.name];
        
        NSString* prounoun;
        NSString*possesive;
        if ([theCharacter.whatGender.name isEqualToString:@"male"]){
            prounoun = @"He";
            possesive = @"His";
        }
        else {
            prounoun = @"She";
            possesive = @"Her";
        }
        
        NSString* mainString;
        mainString = [NSString stringWithFormat:@" %@ is a %@ \n %@ birthday is %@ \n %@ hair color is %@ \n %@ is %@ \n %@ job is a %@ \n %@ location is next to the %@ \n %@ home is near the %@ \n %@ has a favorite %@ \n %@ likes %@ \n %@ hates %@s \n %@ goal is to learn %@",
                      theCharacter.name,theCharacter.whatSpecie.name,
                      possesive,[self dateStyle: theBirthday.date],
                      possesive,theCharacter.whatHairColor.name,
                      prounoun,theCharacter.whatGender.name,
                      possesive,mainJob.name,
                      possesive,mainCurrentLocation.name,
                      possesive,theHome.name,
                      prounoun,mainClothes.name,
                      prounoun,mainLikes.name,
                      prounoun,mainHates.name,
                      possesive, mainGoals.name];
        
        cell.detailTextLabel.text = mainString;

        cell.detailTextLabel.numberOfLines = 11;
        

        
        return cell;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

//
//
////////
//
////////
//
//

#pragma mark - DataLoad

- (NSArray*) myArraySetter {
    @try {
        NSArray*mine = [[self completeCharacterList:self.managedObjectContext]copy];
        LOG NSLog(@"%lu",(unsigned long)[mine count]);
        return mine;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark - Update UI

- (void) updateUI
{
    LOG NSLog(@"UI updated");
    self.fetchedRecordsArray = [[self myArraySetter] copy];
    [self.tableView reloadData];
    
    [self testx];
    //[self newtest];
}

//
//
////////
//
////////
//
//




- (void) newtest {
    
    //Character * theCharacter = [self.fetchedRecordsArray firstObject];

    /*
    NSSet*theSet = theCharacter.whatJob;
    NSArray*myArray = [theSet allObjects];
    NSString * entityName = [[[myArray firstObject] entity] name];
    Class arrayClass = NSClassFromString (entityName);
    if([arrayClass respondsToSelector:@selector(metaType)]) {
        NSString*mystring = [arrayClass metaType];
        NSLog(@"%@",mystring);
    }
    else {
        NSLog(@"ERROR");
    }
     */
}

- (void) testx {
    
    /*
    Character * theCharacter = [self.fetchedRecordsArray firstObject];
    NSLog(@"%@",theCharacter.name);

    if ([theCharacter.whatJob isKindOfClass:[NSSet class]]) {

    }
    
    NSSet*myobj = theCharacter.whatJob;
    NSArray* myJobArray = [myobj allObjects];
    //Job* mainJob = [myJobArray firstObject];
    
    NSString * entityName = [[[myJobArray firstObject] entity] name];
   
    if ([[myJobArray firstObject] isKindOfClass:[Job class]])
    {
        Job* mainJob = [myJobArray firstObject];
        NSString*mystring = [mainJob metaType];
        NSLog(mystring);
        
        NSString*secondString = [mainJob name];
        NSLog(secondString);
    }
   */
    
    
}


//
//
//////////
//
//////////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self viewStyleForLoad];
    //[self testx];
    //[self loadNotifications];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3f];
}


- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
}


@end
