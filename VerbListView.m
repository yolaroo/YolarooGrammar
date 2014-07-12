//
//  VerbListView.m
//  YolarooGrammar
//
//  Created by MGM on 4/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbListView.h"

#import "VerbListFromSemanticTypeView.h"

#import "MainFoundation+Notifications.h"
#import "MainFoundation+VerbSearch.h"

@interface VerbListView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VerbListView

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
    VerbSemanticType * theVerb = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if (theVerb != nil){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self sentenceSpaceFixer:theVerb.name withCaps:YES]];
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

#pragma mark - Table Action forSeque

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VerbListFromSemanticTypeView* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"VerbListFromSemanticTypeViewID"];
    detailController.selectedRecord = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
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
        NSArray*mine = [self completeVerbSemanticTypeList: self.managedObjectContext];
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
    for(UIButton* BTN in self.myButtonCollection){
        [self buttonShadow:BTN];
    }
}


@end
