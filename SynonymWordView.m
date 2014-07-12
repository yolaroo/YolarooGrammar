//
//  SynonymWordView.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymWordView.h"

#import "MainFoundation+Notifications.h"
#import "MainFoundation+SynonymSearch.h"

@interface SynonymWordView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SynonymWordView

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
    SynonymWordClass * theWord = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if (theWord != nil){
        cell.textLabel.text = [self sentenceSpaceFixer:theWord.name withCaps:YES];
        NSArray*typeArray = [theWord.whatType allObjects];
        SynonymObjectClass* myType = [typeArray firstObject];
        cell.detailTextLabel.text = myType.name;
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
        NSArray*mine = [[self selectSynonymWordFromClassType:self.selectedRecord withContext: self.managedObjectContext]copy];
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
