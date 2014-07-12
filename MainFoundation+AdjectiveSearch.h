//
//  MainFoundation+AdjectiveSearch.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (AdjectiveSearch)

- (NSArray*) completeAdjectiveList: (NSManagedObjectContext*) newContext;

- (NSArray*) completeAdjectiveSemanticTypeList: (NSManagedObjectContext*) newContext;

- (NSArray*) selectedAdjectiveListFromSemanticType:(AdjectiveSemanticType*)withType withContext:(NSManagedObjectContext*) newContext;

- (NSArray*) selectedAdjectiveListFromSemanticTypeWithName:(NSString*)withType withContext:(NSManagedObjectContext*) newContext;


@end
