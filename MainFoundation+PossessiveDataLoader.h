//
//  MainFoundation+PossessiveDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (PossessiveDataLoader)

- (NSArray*) buttonViewFromCaseForPossessive:(NSInteger)myNumber;

- (NSDictionary*) theDataSetFromCaseForPossessive:(NSInteger)myNumber withContext: (NSManagedObjectContext*) context;

- (NSArray*) dataTransformationForPossessive: (NSDictionary*) dictionary;

- (NSDictionary*) sentenceForPossessiveExercise: (NSInteger)number withContext: (NSManagedObjectContext*) context;



@end
