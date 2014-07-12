//
//  ExtraObjectView.m
//  YolarooGrammar
//
//  Created by MGM on 5/15/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "ExtraObjectView.h"
#import "MainFoundation+Notifications.h"

#import "MainFoundation+SuperSearchForExtraObjects.h"

@interface ExtraObjectView ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic)  BOOL typeOne;

@end

@implementation ExtraObjectView

#define DK 2
#define LOG if(DK == 1)

- (IBAction)typeSwitchPress:(UIButton *)sender {
    self.typeOne = !self.typeOne;
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3];
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
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell = [self setMyCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * theString = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
    if (self.typeOne){
        NSManagedObject * theObject = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
        if (theObject != nil){
            cell.textLabel.text = [self objectName:theObject];
            return cell;
        }
        else {
            return nil;
        }
    }
    else {
        if ([theString length]){
            cell.textLabel.text = theString;
            return cell;
        }
        else {
            return nil;
        }
    }

}

/*
- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject * theObject = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if (theObject != nil){
        cell.textLabel.text = [self objectName:theObject];
        return cell;
    }
    else {
        return nil;
    }
}
*/

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
        NSArray*mine;
        if (self.typeOne){
            mine = [self completeCharacterPropertiesList:self.managedObjectContext];
        }
        else {
            mine = [self completeStoryPropertiesList:self.managedObjectContext];
        }
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
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3];
}

@end
