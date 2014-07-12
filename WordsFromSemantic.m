//
//  WordsFromSemantic.m
//  YolarooGrammar
//
//  Created by MGM on 4/2/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "WordsFromSemantic.h"

#import "MainFoundation+WordSearch.h"

#import "MainFoundation+Notifications.h"

@interface WordsFromSemantic ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WordsFromSemantic

#define DK 2
#define LOG if(DK == 1)

#pragma mark - Table view data source

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
    return cell;
}

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Word * theWord = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if (theWord != nil){
        NSString*plural = ([theWord.isPlural boolValue]) ? @"plural" : @"not plural";
        NSString*countable = ([theWord.isUncountable boolValue]) ? @"uncountable" : @"countable";
        NSString*definite = ([theWord.hasDefiniteDeterminer boolValue]) ? @"definite" : @"indefinite";
        NSString*properName = ([theWord.isProperName boolValue]) ? @"proper name" : @"non proper";
        NSString*gender = (theWord.gender);
        if ([gender length] == 0) {
            gender = @" ";
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ ",[self sentenceSpaceFixer:theWord.english withCaps:YES]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %@ - %@ (%@)",theWord.whatSyntacticType.name,plural,countable,definite,properName,gender,theWord.wordObject];
        return cell;
    }
    else {
        return nil;
    }
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
        LOG NSLog(@"word test");
        NSArray*mine = [[self wordListFromSemanticType:self.selectedRecord withContext: self.managedObjectContext]copy];
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
    LOG NSLog(@"here %@",[self.fetchedRecordsArray firstObject]);
}

//
//
////////
//
////////
//
//

#pragma mark - Life Cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self loadNotifications];
    [self viewStyleForLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    
    //[[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"taco"];
    //[[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:@"taco"];

    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3];
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
