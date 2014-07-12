//
//  AppDelegate.m
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "GrammarDelegate.h"

@implementation GrammarDelegate

@synthesize managedObjectModel = _managedObjectModel;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

@synthesize seedManagedObjectContext = _seedManagedObjectContext;
@synthesize seedPersistentStoreCoordinator = _seedPersistentStoreCoordinator;
@synthesize seedManagedObjectModel = _seedManagedObjectModel;

#define NILLOG 2
#define LOG if(NILLOG == 1) //one is pass - two is normal

#define NILSEED 2
#define DOG if(NILSEED == 1) //one is pass - two is normal

#pragma mark - Basic Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

//
//
//////////
#pragma mark - View Orientation
//////////
//
//

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    NSUInteger orientations = UIInterfaceOrientationMaskPortrait;
    if (self.screenIsPortraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    }
    else {
        if(self.window.rootViewController){
            UIViewController *presentedViewController = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
            orientations = [presentedViewController supportedInterfaceOrientations];
        }
        return orientations;
    }
}

//
//
//////////
#pragma mark - First load check
//////////
//
//

- (BOOL) theFirstLoadCheckForSeed {
    LOG NSLog(@"default loaded");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"firstLoad"] == TRUE) {
        return true;
    }
    else {
        return false;
    }
}

//
//
//////////
#pragma mark - Seed Data Stack
//////////
//
//

- (NSManagedObjectContext *) seedManagedObjectContext
{
    DOG return nil;
    if ([self theFirstLoadCheckForSeed])return nil;
    if (_seedManagedObjectContext != nil) {
        return _seedManagedObjectContext;
    }
    NSLog(@"seed loaded");
    NSPersistentStoreCoordinator *coordinator = [self seedPersistentStoreCoordinator];
    if (coordinator != nil) {
        _seedManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_seedManagedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _seedManagedObjectContext;
}


- (NSPersistentStoreCoordinator *)seedPersistentStoreCoordinator
{
    if (_seedPersistentStoreCoordinator != nil) {
        return _seedPersistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self seedApplicationDocumentsDirectory] URLByAppendingPathComponent:@"x20.CDBStore"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        if (![fileManager fileExistsAtPath:[storeURL path]]) {
            NSURL *defaultStoreURL = [[NSBundle mainBundle] URLForResource:@"x20" withExtension:@"CDBStore"];
            if (defaultStoreURL) {
                [fileManager copyItemAtURL:defaultStoreURL toURL:storeURL error:NULL];
            }
        }
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
        _seedPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self seedManagedObjectModel]];
        
        NSError *error;
        if (![_seedPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"UserConf" URL:storeURL options:options error:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            LOG NSLog(@"Persistent Store Added");
        });
    });
    return _seedPersistentStoreCoordinator;
}

- (NSURL *)seedApplicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//
//
//////////
#pragma mark - delete attempt Feature (doesnt work)
//////////
//
//

-(void) deleteSeed
{
    LOG NSLog(@"-- delete seed --");

    NSPersistentStore *newStore = [[self.persistentStoreCoordinator persistentStores] lastObject];
    

    NSArray*xxx = [self.persistentStoreCoordinator persistentStores];
    NSLog(@"main store count %lu",(unsigned long)[xxx count]);

    
    
    if(!newStore) {
       LOG  NSLog(@"-- no store --");
        return;
    }
    
//    NSPersistentStore *newStore = [pscNew persistentStoreForURL:newURL];
    LOG NSLog(@"deleted?");
    NSError *newError = nil;
    if(![[self.managedObjectContext persistentStoreCoordinator] removePersistentStore:newStore error:&newError]){
        LOG NSLog(@"-- delete store error: %@ --",newError);
        abort();
    };
    
}

//
//
//////////
#pragma mark - store set
//////////
//
//

- (NSURL*)storeURL {
    self.stringName = @"basic";
    NSString* myStringName = [NSString stringWithFormat:@"%@.sqlite",self.stringName];
    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:myStringName];
    LOG NSLog(@"--here--");
    return [NSURL fileURLWithPath:storePath];
}

//
//
//////////
#pragma mark - Migrate
//////////
//
//

-(void) migrateFromSeed
{
    NSPersistentStoreCoordinator *psc = [self.seedManagedObjectContext persistentStoreCoordinator];
    NSURL *oldURL = [psc URLForPersistentStore:[[psc persistentStores]objectAtIndex:0]];
//    
//    self.stringName = @"basic";
//    NSString* myStringName = [NSString stringWithFormat:@"%@.sqlite",self.stringName];
//    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:myStringName];
//    NSURL *newURL = [NSURL fileURLWithPath:storePath];
//    
    NSError *error = nil;
    NSPersistentStore *oldStore = [psc persistentStoreForURL:oldURL];
    
    if (![psc migratePersistentStore:oldStore
                               toURL:self.storeURL
                             options:nil
                            withType:NSSQLiteStoreType
                               error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(BOOL)contextIsReset
{
    LOG NSLog(@"**Reset**");
    NSError *error = nil;

    if (![[_managedObjectContext persistentStoreCoordinator] removePersistentStore:[[[_managedObjectContext persistentStoreCoordinator] persistentStores] firstObject] error:&error]){
       LOG  NSLog(@"** %@ **",error);
    }
    
    [_managedObjectContext reset];
    _managedObjectContext = nil;

    _persistentStoreCoordinator = nil;
    _managedObjectContext = self.managedObjectContext;
    return true;
}

//
//
//////////
#pragma mark - Core Data stack
//////////
//
//

- (NSManagedObjectContext *) managedObjectContext {
    LOG NSLog(@"**MANAGED ATTEMPT**");
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    LOG NSLog(@"**MANAGED SUCCESS**");
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc]
                                       initWithConcurrencyType:
                                       NSMainQueueConcurrencyType];
        [moc performBlockAndWait:^{
            [moc setPersistentStoreCoordinator: coordinator];

        }];
        _managedObjectContext = moc;
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    LOG NSLog(@"**PERS ATTEMPT**");
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    LOG NSLog(@"**PERS SUCCESS**");
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:
                                   [self managedObjectModel]];
    
    NSPersistentStoreCoordinator* psc = _persistentStoreCoordinator;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        self.stringName = @"basic";
        NSString* myStringName = [NSString stringWithFormat:@"%@.sqlite",self.stringName];
        NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:myStringName];
        NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
        
        NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
        [pragmaOptions setObject:@"DELETE" forKey:@"journal_mode"];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                                 pragmaOptions, NSSQLitePragmasOption,
                                 nil];
        
        /*
        NSDictionary *options = @{
                                  NSMigratePersistentStoresAutomaticallyOption : @YES,
                                  NSInferMappingModelAutomaticallyOption : @YES,
                                  };
        */
        
        [psc lock];
        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                         URL:storeUrl
                                     options:options
                                       error:&error]) {
            NSLog(@"Core data error %@, %@", error, [error userInfo]);
        }
        [psc unlock];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            LOG NSLog(@"Persistent Store Added");
            
        });
    });
    return _persistentStoreCoordinator;
}

//
//
//////////
#pragma mark - Model
//////////
//
//

- (NSManagedObjectModel *) managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSManagedObjectModel *) seedManagedObjectModel {
    if (_seedManagedObjectModel != nil) {
        return _seedManagedObjectModel;
    }
    _seedManagedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _seedManagedObjectModel;
}

//
//
//////////
#pragma mark - Core Data Utilities
//////////
//
//

- (NSString *) applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
}

//
//
//////////
//
//////////
//
//

/*
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 
 dispatch_async(dispatch_get_main_queue(), ^{
 LOG NSLog(@"Persistent Store Added");
 });
 });
 
 */


@end
