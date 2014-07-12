//
//  MainFoundation+DeleteAllWordRecords.h
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (DeleteAllWordRecords)

- (void) masterWordDataDelete: (NSManagedObjectContext*) newContext;

- (void) deleteAllObjectsInContext: (NSManagedObjectContext *) context usingModel:(NSManagedObjectModel *)model;

- (void) deleteStoryList: (NSManagedObjectContext*)newContext;

@end
