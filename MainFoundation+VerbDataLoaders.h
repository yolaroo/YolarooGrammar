//
//  MainFoundation+VerbDataLoaders.h
//  YolarooGrammar
//
//  Created by MGM on 5/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (VerbDataLoaders)


- (NSArray*) buttonViewFromCaseForVerbs:(NSInteger)myNumber;

- (NSDictionary*) theDataSetFromCaseForVerb:(NSInteger)myNumber withContext: (NSManagedObjectContext*)context;

- (NSArray*) dataTransformationForVerb: (NSDictionary*) dictionary;

@end
