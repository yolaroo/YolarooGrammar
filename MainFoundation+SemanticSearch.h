//
//  MainFoundation+SemanticSearch.h
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SemanticSearch)

- (NSArray*) completeSemanticTypeList: (NSManagedObjectContext*)newContext;

- (NSArray*) semanticTypeListWithName: (NSString*)name withContext: (NSManagedObjectContext*)newContext;

- (NSArray*) completeModifiedSemanticTypeList: (NSManagedObjectContext*)newContext;

@end
