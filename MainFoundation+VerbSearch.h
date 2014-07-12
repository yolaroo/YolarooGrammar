//
//  MainFoundation+VerbSearch.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (VerbSearch)

- (NSArray*) completeVerbList: (NSManagedObjectContext*) newContext;

- (NSArray*) selectedVerbListFromSemanticType:(VerbSemanticType*)withType withContext:(NSManagedObjectContext*) newContext;

- (NSArray*) completeVerbSemanticTypeList: (NSManagedObjectContext*) newContext;

- (NSArray*) verbClassFromName:(NSString*) name withContext: (NSManagedObjectContext*) newContext;

@end
