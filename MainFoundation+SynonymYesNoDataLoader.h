//
//  MainFoundation+SynonymYesNoDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SynonymYesNoDataLoader)

- (NSArray*) myDataLoaderForSynonyms:(NSString*)synonymType withContext: (NSManagedObjectContext*) context;

- (NSArray*) setAdjectiveGroupName: (NSManagedObjectContext*) context;

@end
