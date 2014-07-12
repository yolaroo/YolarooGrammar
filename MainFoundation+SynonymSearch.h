//
//  MainFoundation+SynonymSearch.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SynonymSearch)

- (NSArray*) completeSynonymClassList: (NSManagedObjectContext*)newContext;
- (NSArray*) selectSynonymClassfromName: (NSString*)className withContext: (NSManagedObjectContext*)newContext;

- (NSArray*) selectSynonymWordFromClassType: (SynonymObjectClass*) className withContext: (NSManagedObjectContext*) newContext;

- (NSArray*) selectSynonymWordFromClassName: (NSString*) className withContext: (NSManagedObjectContext*) newContext;

- (NSArray*) selectSynonymWordFromName: (NSString*) name withContext: (NSManagedObjectContext*) newContext;


@end
