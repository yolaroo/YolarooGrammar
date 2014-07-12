//
//  AppDelegate.h
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface GrammarDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSManagedObjectContext *seedManagedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *seedPersistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectModel *seedManagedObjectModel;

@property (strong, nonatomic) NSString* stringName;

@property (nonatomic) BOOL screenIsPortraitOnly;


- (void) migrateFromSeed;

- (BOOL) contextIsReset;
- (void) deleteSeed;

@property  (strong, nonatomic) NSURL* storeURL;

@end
