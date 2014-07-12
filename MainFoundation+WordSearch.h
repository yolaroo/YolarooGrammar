//
//  MainFoundation+WordSearch.h
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (WordSearch)

- (NSArray*) completeWordList: (NSManagedObjectContext*)newContext;

- (NSArray*) wordListFromSemanticType: (SemanticType*)mySemanticType withContext: (NSManagedObjectContext*)newContext;

- (NSArray*) wordListFromSemanticTypeName:(NSString*)mySemanticTypeName withContext: (NSManagedObjectContext*)newContext;

- (NSArray*) wordListFromName:(NSString*)name withContext: (NSManagedObjectContext*)newContext;


@end



