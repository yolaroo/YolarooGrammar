//
//  MainFoundation+GrammarDataLoad.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (GrammarDataLoad)

- (void) grammarDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*)context;

@end
