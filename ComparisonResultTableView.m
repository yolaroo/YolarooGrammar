//
//  ComparisonResultTableView.m
//  YolarooGrammar
//
//  Created by MGM on 5/9/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "ComparisonResultTableView.h"
#import "MainFoundation+Notifications.h"

#import "MainFoundation+ComparisonSearch.h"
//completeComparisonList

@interface ComparisonResultTableView ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@end

@implementation ComparisonResultTableView

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

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComparisonObject * theComparisonObject = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if (theComparisonObject != nil){
        cell.textLabel.text = theComparisonObject.sentence;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"(count - %@)", [theComparisonObject.count stringValue]];
        return cell;
    }
    else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.managedObjectContext deleteObject:[self.fetchedRecordsArray objectAtIndex:indexPath.row]];
        [self saveData:self.managedObjectContext];
        self.fetchedRecordsArray = [[self myArraySetter] copy];
        [tableView endUpdates];
        if ([self.fetchedRecordsArray count] == 0) {
            [self.tableView setEditing:NO animated:YES];
        }
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
        NSArray*mine = [self completeComparisonList: self.managedObjectContext];
        LOG NSLog(@" Verb Count - %lu",(unsigned long)[mine count]);
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
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:0.3];
}

- (void) viewStyleForLoad {
    for(UIView* UIV in self.myViewCollection){
        [self viewShadow:UIV];
    }
}

@end
