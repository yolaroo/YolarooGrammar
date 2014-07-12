//
//  MainFoundation+PronounDataLoaders.h
//  YolarooGrammar
//
//  Created by MGM on 5/2/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (PronounDataLoaders)

- (NSString*) dataTransformationForPronoun: (NSDictionary*) dictionary;

- (NSDictionary*) theDataSetFromCaseForPronoun:(NSInteger)myNumber withContext: (NSManagedObjectContext*) context;

- (NSArray*) buttonViewFromCaseForPronoun:(NSInteger)myNumber;

@end
