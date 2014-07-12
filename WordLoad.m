//
//  WordLoad.m
//  YolarooGrammar
//
//  Created by MGM on 3/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "WordLoad.h"

#import "MainFoundation+CompleteDataLoadProcess.h"

#import "MainFoundation+SaveDatabase.h"

#import "MainFoundation+WordSearch.h"
#import "MainFoundation+SemanticSearch.h"

#import "MainFoundation+DeleteAllWordRecords.h"

#import "MainFoundation+Notifications.h"

#import "MainFoundation+AddExtraDataToWordList.h"

@interface WordLoad ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WordLoad

#define DK 2
#define LOG if(DK == 1)


#pragma mark - SAVE Button

- (IBAction)transferPress:(UIButton *)sender {

}

#pragma mark - DELETE Button

- (IBAction)deleteDataPress:(UIButton *)sender {
    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self deleteAllObjectsInContext:self.managedObjectContext usingModel:appDelegate.managedObjectModel];
    [self saveData:self.managedObjectContext];
}

#pragma mark - LOAD Button

- (IBAction)loadDataPress:(UIButton *)sender {
    [self completeDataLoadForCoreData:self.managedObjectContext];
    
    //[self dataLoader];
}

#pragma mark - SAVE Button

- (IBAction)saveDataPress:(UIButton *)sender {
    [self saveToDesktop];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedRecordsArray count] ? [self.fetchedRecordsArray count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",theWord.english,theWord.whatSemanticType.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@",theWord.whatSyntacticType.name,plural,countable];
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

-(NSArray*) myArraySetter {
    @try {
        NSArray*mine = [[self completeWordList:self.managedObjectContext]copy];
        LOG NSLog(@"%lu",(unsigned long)[mine count]);
        return mine;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark - Update UI

-(void) updateUI
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self performSelectorInBackground:@selector(dataLoader) withObject:nil];
    
    [self loadNotifications];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;

    [self performSelector:@selector(updateUI) withObject:nil afterDelay:1];
}



@end
