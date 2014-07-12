//
//  MainFoundation+Notifications.m
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+Notifications.h"

@implementation MainFoundation (Notifications)

#define DK 2
#define LOG if(DK == 1)

- (void) loadNotifications
{
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(contextDidSave:)
     name:NSManagedObjectContextDidSaveNotification
     object:nil];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(persistentStoreDidImportUbiquitiousContentChanges:)
     name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(storesWillChange:)
     name:NSPersistentStoreCoordinatorStoresWillChangeNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(storesDidChange:)
     name:NSPersistentStoreCoordinatorStoresDidChangeNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (iCloudAccountAvailabilityChanged:)
     name: NSUbiquityIdentityDidChangeNotification
     object: nil];
    

     [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (iCloudChangesImported:)
     name: NSPersistentStoreDidImportUbiquitousContentChangesNotification
     object: nil];
     */
    
}

- (void)contextDidSave:(NSNotification *)notification
{
    LOG NSLog(@"Context Did Save");
    
    [self updateUI];
}

-(void) updateUI {
    NSLog(@"wrong update");
}

#pragma mark - iCloud

-(void) iCloudChangesImported:(NSNotification *)notification {
    LOG NSLog(@"iCloud changes have been imported=%@",@"YES");
    //NSError *error;
    //[[self fetchedResultsController] performFetch:&error];
    //[self saveData];
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        LOG NSLog(@"Edited");
    });
}

- (void)persistentStoreDidImportUbiquitiousContentChanges:(NSNotification*)changeNotification{
    LOG NSLog(@"persistentStoreDidImportUbiquitiousContentChanges");
    NSManagedObjectContext *moc = [self managedObjectContext];
    [moc performBlock:^{
        [moc mergeChangesFromContextDidSaveNotification:changeNotification];
    }];
}

- (void)storesWillChange:(NSNotification *)n {
    LOG NSLog(@"storesWillChange");
    NSLog(@"storesWillChange");
    NSManagedObjectContext *moc = [self managedObjectContext];
    [moc performBlockAndWait:^{
        NSError *error = nil;
        if ([moc hasChanges]) {
            [moc save:&error];
        }
        [moc reset];
    }];
}

- (void)storesDidChange:(NSNotification *)n {
    LOG NSLog(@"storesDidChange");
}

-(void)iCloudAccountAvailabilityChanged:(NSNotification*)note{
    LOG NSLog(@"**** iCloud Status Changed ****");
    NSNotification* refreshNotification = [NSNotification notificationWithName:@"iCloud" object:self  userInfo:[note userInfo]];
    [[NSNotificationCenter defaultCenter] postNotification:refreshNotification];
}


@end
