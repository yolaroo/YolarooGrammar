//
//  MainFoundation+MainOptionControl.h
//  YolarooGrammar
//
//  Created by MGM on 5/18/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (MainOptionControl)

- (void) mainMigrate;
- (void) deleteDataAndReload: (NSManagedObjectContext*)context;
- (void) saveAction;
- (void) deleteAction;

- (void) loadDataFromJSONAction: (NSManagedObjectContext*)context;
- (BOOL) checkContextForFullfillmentAction;
- (void) deleteNormalRecords: (NSManagedObjectContext*)context;

@end
