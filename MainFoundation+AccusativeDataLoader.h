//
//  MainFoundation+AccusativeDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (AccusativeDataLoader)

- (NSArray*) buttonViewFromCaseForAccusative:(NSInteger)myNumber;

- (NSDictionary*) theDataSetFromCaseForAccusative:(NSInteger)myNumber withContext: (NSManagedObjectContext*) context;

- (NSArray*) dataTransformationForAccusative: (NSDictionary*) dictionary;

- (NSDictionary*) sentenceForAccusativeExercise: (NSInteger)number withContext: (NSManagedObjectContext*) context;

@end
