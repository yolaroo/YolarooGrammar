//
//  MainFoundation+AdjectiveDataLoad.h
//  YolarooGrammar
//
//  Created by MGM on 4/24/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (AdjectiveDataLoad)

- (void) adjectiveDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*) context;

@end
