//
//  DatabaseStory.m
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "DatabaseStory.h"
#import "MainFoundation+SentenceController.h"

#import "MainFoundation+StorySearch.h"
#import "MainFoundation+Notifications.h"
#import "Character.h"

@interface DatabaseStory ()
{
    NSInteger heightCount;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *myViewCollection;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *expandedCellMutableArray;
@property (nonatomic)BOOL hasTappedCell;
@property (nonatomic)BOOL tableIsEditing;

@end

@implementation DatabaseStory

@synthesize expandedCellMutableArray=_expandedCellMutableArray;

#define DK 2
#define LOG if(DK == 1)

#define isDeviceIPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad
#define isDeviceIPhone UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

#define LINE_COUNT 30
#define HEIGHT_COUNT_TO_SIZE_IPHONE (LINE_COUNT-1)*20
#define HEIGHT_COUNT_TO_SIZE_IPAD (LINE_COUNT-1)*20*1.33

#define LARGE_HEIGHT_COUNT_TO_SIZE_IPHONE (LINE_COUNT-1)*20*1.5
#define LARGE_HEIGHT_COUNT_TO_SIZE_IPAD (LINE_COUNT-1)*20*1.65

#define IPHONE_FONT [UIFont systemFontOfSize:18.0]
#define IPAD_FONT [UIFont systemFontOfSize:24.0]
#define IPHONE_LARGE_FONT [UIFont systemFontOfSize:24.0]
#define IPAD_LARGE_FONT [UIFont systemFontOfSize:30.0]

-(NSMutableArray*) expandedCellMutableArray {
    if (_expandedCellMutableArray != nil) {
        return _expandedCellMutableArray;
    }
    _expandedCellMutableArray = [[NSMutableArray alloc]init];
    return _expandedCellMutableArray;
}

- (IBAction)buttonPress:(UIButton *)sender {
    [self myButtonPress];
}

- (void) myButtonPress {
    @try {
        [self buildTheStory:self.managedObjectContext];
    }
    @catch (NSException *exception) {
        NSLog(@"DBS %@",exception);
    }
}

#define TESTNUMBER 10

- (void) createTimeTest {
    
    ////
    //test
    NSLog(@"Time Start");
    [self timeTestStart];
    //test
    ////
    
    for (int i=0; i < TESTNUMBER; i++) {
        [self buildTheStory:self.managedObjectContext];
    }
    
    ////
    //test
    NSLog(@"Story Done");
    [self timeTestUpdate];
    //test
    ////
    
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
    cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

    return cell;
}

- (UITableViewCell *) setMyCell: (UITableViewCell*) cell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    Story * theStory = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
    if (theStory) {
        cell.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;

        NSArray*SentenceFetch = [theStory.whatSentences allObjects];
    
        NSMutableArray* sentenceArray = [[NSMutableArray alloc]init];
        NSMutableString* theString = [[NSMutableString alloc]init];

        Character* theCharacter = [[theStory.whatCharacter allObjects] firstObject];
        NSString* name;
        
        name =  theCharacter.name;
        if ([name length]){
            [theString appendString: name];
        }
        else {
        }
        [theString appendString: @" \n"];
        [theString appendString: @" \n"];

        for (int i = 0; i < [SentenceFetch count]; i++) {
            for (int j = 0; j < [SentenceFetch count]; j++) {
                Sentence *mySentence = [SentenceFetch objectAtIndex:j];
                if ([mySentence.displayOrder integerValue] == i){
                    LOG NSLog(@" - Display Order - %@",mySentence.displayOrder);
                    [sentenceArray addObject:mySentence.theSentence];
                }
            }
        }
        
        //heightCount = ([SentenceFetch count]-1)*20;
        for (NSString* str in [sentenceArray copy]){
            [theString appendString:str];
            [theString appendString:@"\n"];
        }
        
        if (![self.expandedCellMutableArray containsObject:indexPath]){
            isDeviceIPad ? (cell.textLabel.font = IPAD_FONT) : (cell.textLabel.font = IPHONE_FONT);
        }
        else {
            isDeviceIPad ? (cell.textLabel.font = IPAD_LARGE_FONT) : (cell.textLabel.font = IPHONE_LARGE_FONT);
        }
        
        cell.textLabel.text = [theString copy];
        cell.textLabel.numberOfLines = [sentenceArray count]+4;
        return cell;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing) {
        return 44;
    }
    else {
        if (isDeviceIPad) {
            if ([self.expandedCellMutableArray containsObject:indexPath]) {
                return (HEIGHT_COUNT_TO_SIZE_IPAD <= 44)?44:LARGE_HEIGHT_COUNT_TO_SIZE_IPAD ;
            }
            else {
                return (HEIGHT_COUNT_TO_SIZE_IPAD <= 44)?44:HEIGHT_COUNT_TO_SIZE_IPAD ;
            }
        }
        else {
            if ([self.expandedCellMutableArray containsObject:indexPath]) {
                return (HEIGHT_COUNT_TO_SIZE_IPHONE <= 44)?44:LARGE_HEIGHT_COUNT_TO_SIZE_IPHONE ;
            }
            else {
                return (HEIGHT_COUNT_TO_SIZE_IPHONE <= 44)?44:HEIGHT_COUNT_TO_SIZE_IPHONE ;
            }
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

#pragma mark - Table Action forSeque

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.hasTappedCell){
        self.hasTappedCell = !self.hasTappedCell;
        if (![self.expandedCellMutableArray containsObject:indexPath]){
            [self.expandedCellMutableArray addObject:indexPath];
        }
    }
    else {
        self.hasTappedCell = !self.hasTappedCell;
        if ([self.expandedCellMutableArray containsObject:indexPath]){
            [self.expandedCellMutableArray removeObject:indexPath];
        }
    }
    [self.tableView reloadData];

}

#pragma mark - Edit Position

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//
////
//
- (IBAction)doubleTapPress:(UITapGestureRecognizer *)sender {
    if (!self.tableView.editing && !self.tableIsEditing){
        self.tableIsEditing = true;
        [self performSelector:@selector(start) withObject:nil afterDelay:.3];
        
    }
    else if (self.tableView.editing && !self.tableIsEditing){
        self.tableIsEditing = true;
        [self performSelector:@selector(stop) withObject:nil afterDelay:.3];
    }
}

- (IBAction)editLongPress:(UILongPressGestureRecognizer *)sender {

}

- (void) start{
    self.tableIsEditing = false;
    self.tableView.editing = true;
    [self.tableView reloadData];

}

- (void) stop{
    self.tableIsEditing = false;
    self.tableView.editing = false;
    [self.tableView reloadData];

}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"moveRowAtIndexPath");

    if (self.tableView.editing){
        
        NSLog(@"moveRowAtIndexPath");
        NSUInteger fromIndex = fromIndexPath.row;
        NSUInteger toIndex = toIndexPath.row;
        
        if (fromIndex == toIndex) return;
        
        NSUInteger count = [self.fetchedRecordsArray count];
        
        NSManagedObject *movingObject = [self.fetchedRecordsArray objectAtIndex:fromIndex];
        NSManagedObject *toObject  = [self.fetchedRecordsArray objectAtIndex:toIndex];
        
        double toObjectDisplayOrder =  [[toObject valueForKey:@"displayOrder"] doubleValue];
        
        double newIndex;
        if ( fromIndex < toIndex ) {
            if (toIndex == count-1) {
                newIndex = toObjectDisplayOrder + 1.0;
            } else  {
                NSManagedObject *object = [self.fetchedRecordsArray objectAtIndex:toIndex+1];
                double objectDisplayOrder = [[object valueForKey:@"displayOrder"] doubleValue];
                newIndex = toObjectDisplayOrder + (objectDisplayOrder - toObjectDisplayOrder) / 2.0;
            }
        } else {
            if ( toIndex == 0) {
                newIndex = toObjectDisplayOrder - 1.0;
            } else {
                NSManagedObject *object = [self.fetchedRecordsArray objectAtIndex:toIndex-1];
                double objectDisplayOrder = [[object valueForKey:@"displayOrder"] doubleValue];
                newIndex = objectDisplayOrder + (toObjectDisplayOrder - objectDisplayOrder) / 2.0;
            }
        }
        [movingObject setValue:[NSNumber numberWithDouble:newIndex] forKey:@"displayOrder"];
        
        [self saveData:self.managedObjectContext];
        
        self.tableView.editing = false;;
        [self performSelector:@selector(updateUI) withObject:nil afterDelay:1];
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
        NSArray*mine = [[self completeStoryList:self.managedObjectContext]copy];
        LOG NSLog(@"-- Count -- %lu",(unsigned long)[mine count]);
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
    [self loadNotifications];
    [self viewStyleForLoad];
    self.navigationItem.rightBarButtonItem = [self editButtonItem];

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
