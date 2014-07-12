//
//  MainFoundation+AntonymMatchDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (AntonymMatchDataLoader)

- (NSArray*) myDataLoaderForAntonym: (NSManagedObjectContext*) context;

@end
