//
//  MainFoundation+SuperSearchForExtraObjects.h
//  YolarooGrammar
//
//  Created by MGM on 5/15/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SuperSearchForExtraObjects)

- (NSArray*) completeCharacterPropertiesList: (NSManagedObjectContext*)context;

- (NSArray*) completeStoryPropertiesList: (NSManagedObjectContext*)context;

- (void) deleteAllExtraData: (NSManagedObjectContext*)newContext;

@end
