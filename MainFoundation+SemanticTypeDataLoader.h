//
//  MainFoundation+SemanticTypeDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SemanticTypeDataLoader)

- (NSArray*) simpleSentenceLoadForSemanticType:(NSDictionary*) dictionaryData withContext:(NSManagedObjectContext*)context;

- (NSDictionary*) myDataForSemanticType: (NSManagedObjectContext*)context;

@end
