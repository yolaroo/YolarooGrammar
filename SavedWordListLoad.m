//
//  SaveWordListLoad.m
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SavedWordListLoad.h"

#import "SyntacticType+Create.h"
#import "SemanticType+Create.h"
#import "Word+Create.h"
#import "MainFoundation+WordSearch.h"

#import "MainFoundation+DeleteAllWordRecords.h"

#import "MainFoundation+Notifications.h"
@interface SavedWordListLoad ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SavedWordListLoad

#define DK 2
#define LOG if(DK == 1)

#pragma mark - Button Press

- (IBAction)loadDataPress:(UIButton *)sender {
    [self loadTheSeed];
    [self myNotifications];
}

- (void) loadTheSeed {
    @try {
        LOG LOG NSLog(@"Foundation - Data Load");
        GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        self.seedManagedObjectContext = nil;
        self.seedManagedObjectContext = appDelegate.seedManagedObjectContext;
        
        LOG NSLog(@"Foundation String Name: %@",appDelegate.stringName);
    }
    @catch (NSException *exception) {
        LOG NSLog(@"Delegate Error");
        //[self myAlert:@"Could Not Load Delegate"];
    }
    @finally {
    }
}

//
//
////////
//
////////
//
//

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
        cell.textLabel.text = [NSString stringWithFormat:@"%@",theWord.english ];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",theWord.whatSemanticType.name,theWord.whatSyntacticType.name];
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
        NSArray*mine = [[self completeWordList:self.seedManagedObjectContext]copy];
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
    //[self loadNotifications];
}

- (void) myNotifications {
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (NSPersistentStoreCoordinatorStoresDidChangeNotification:)
     name: NSPersistentStoreCoordinatorStoresDidChangeNotification
     object: nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (NSPersistentStoreCoordinatorStoresWillChangeNotification:)
     name: NSPersistentStoreCoordinatorStoresWillChangeNotification
     object: nil];
}

-(void) NSPersistentStoreCoordinatorStoresDidChangeNotification:(NSNotification *)notification {
    NSLog(@"did");
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:.3];
}

-(void) NSPersistentStoreCoordinatorStoresWillChangeNotification:(NSNotification *)notification {
    NSLog(@"will");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    self.navigationController.navigationBarHidden = false;
    
    [self performSelector:@selector(updateUI) withObject:nil afterDelay:1];
}

@end
