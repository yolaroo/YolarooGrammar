//
//  MainFoundation+MainOptionControl.m
//  YolarooGrammar
//
//  Created by MGM on 5/18/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+MainOptionControl.h"

#import "MainFoundation+DeleteAllWordRecords.h"
#import "MainFoundation+SaveDatabase.h"
#import "MainFoundation+CompleteDataLoadProcess.h"
#import "MainFoundation+SuperSearchForExtraObjects.h"

@implementation MainFoundation (MainOptionControl)

#define DK 2
#define LOG if(DK == 1)

//
////
//

- (void) deleteNormalRecords: (NSManagedObjectContext*)context
{
    [self deleteAllExtraData:context];
    
    [self smallSetOfSententialObjects:context];
}

#pragma mark - migrate action

//
////
//

- (void) mainMigrate
{
    NSLog(@"migrate action");
    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    @try {
        [appDelegate migrateFromSeed];
    }
    @catch (NSException *exception) {
        NSLog(@"migrate exception %@",exception);
    }
}

#pragma mark - delete action

- (void) deleteAction
{
    [self deleteForMenuAction];
}

#pragma mark - reload action

- (void) deleteDataAndReload: (NSManagedObjectContext*)context
{
    [self twoStepFunctionForData:^(void){
        LOG NSLog(@"3. migrate");
        [self performSelector:@selector(completeDataLoadForCoreData:) withObject:context afterDelay:0.3];
    }];
}

- (void) twoStepFunctionForData: (void (^)(void)) completionHandler {
    LOG NSLog(@"1. delete start");
    [self deleteForMenuAction];
    completionHandler();
};

- (void) deleteForMenuAction {
    GrammarDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [self deleteAllObjectsInContext:self.managedObjectContext usingModel:appDelegate.managedObjectModel];
    [self saveData:self.managedObjectContext];
    LOG NSLog(@"2. Delete end");
}

//
////
//

- (BOOL) checkContextForFullfillmentAction
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:self.managedObjectContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"whatSemanticType" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSInteger itemCount = [fetchedRecords count];
    LOG NSLog(@"item count %ld", (long)itemCount);
    if (itemCount > 0) {
        return false;
    }
    else {
        return true;
    }
}

#pragma mark - save action

- (void) saveAction
{
    [self saveToDesktop];
}

#pragma mark - LOAD JSON action

- (void) loadDataFromJSONAction: (NSManagedObjectContext*)context
{
    [self completeDataLoadForCoreData:context];
}

@end
