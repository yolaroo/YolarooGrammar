//
//  MainFoundation+WordTokenDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (WordTokenDataLoader)

- (NSArray*) simpleSentenceLoadForTokenType:(NSDictionary*) dictionaryData withContext:(NSManagedObjectContext*)context;
- (NSDictionary*) myDataForTokenType: (NSManagedObjectContext*)context;


@end
