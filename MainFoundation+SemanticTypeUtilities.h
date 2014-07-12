//
//  MainFoundation+SemanticTypeUtilities.h
//  YolarooGrammar
//
//  Created by MGM on 5/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SemanticTypeUtilities)

- (BOOL) simplePluralityTest: (Word*)theWord;
- (BOOL) simpleDeterminerTest: (Word*)theWord;

- (NSString*) theSimpleCopulaString: (BOOL)subjectIsPlural withContext: (NSManagedObjectContext*)context;

- (BOOL) hasInitialVowelForSemanticType: (NSString*)objectString;

- (NSDictionary*) simpleCategoryList: (NSManagedObjectContext*)context;

- (NSString*) setIndefiniteDeterminer: (Word*) myWord;

@end
