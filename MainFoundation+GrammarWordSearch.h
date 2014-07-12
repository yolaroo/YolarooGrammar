//
//  MainFoundation+GrammarWordSearch.h
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (GrammarWordSearch)

- (NSArray*) completeGrammarWordList: (NSManagedObjectContext*)newContext;
- (NSArray*) completeGrammarWordSemanticTypeList: (NSManagedObjectContext*)newContext;

- (NSArray*) grammarWordListFromSemanticType:(GrammarWordSemanticType*)mySemanticType withContext: (NSManagedObjectContext*)newContext;

- (NSArray*) grammarWordListFromSemanticTypeName:(NSString*)mySemanticTypeName withContext: (NSManagedObjectContext*)newContext;

@end
