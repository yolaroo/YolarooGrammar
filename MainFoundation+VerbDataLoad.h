//
//  MainFoundation+VerbDataLoad.h
//  YolarooGrammar
//
//  Created by MGM on 4/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (VerbDataLoad)

- (void) verbDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*)context;

@end
