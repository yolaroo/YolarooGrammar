//
//  MainFoundation+SynonymDataLoad.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SynonymDataLoad)

- (void) synonymDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*) context;

@end
