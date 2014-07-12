//
//  MainFoundation+MakeACharacterSearches.h
//  YolarooGrammar
//
//  Created by MGM on 5/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (MakeACharacterSearches)

- (NSArray*) AgeMACS;
- (NSArray*) DateMACS;

- (NSArray*) weightMACS;
- (NSArray*) heightMACS;

- (NSArray*) characterTypesMACS: (NSManagedObjectContext*)newContext;
- (NSArray*) clothesListMACS: (NSManagedObjectContext*)newContext;
- (NSArray*) foodListMACS: (NSManagedObjectContext*)newContext;
- (NSArray*) dislikeListMACS: (NSManagedObjectContext*)newContext;

- (NSArray*) locationListMACS: (NSManagedObjectContext*)newContext;

- (NSArray*) dispositionListMACS:(NSManagedObjectContext*) context;
- (NSArray*) descriptionListMACS:(NSManagedObjectContext*) context;

- (NSArray*) eventTypeList;
- (NSArray*) eventCategoryListForSemanticSearch;
- (NSArray*) eventObjectList;

- (NSArray*) goalInfinitiveList;
- (NSArray*) goalCategoryListForSemanticSearch;


//
////
//

- (NSArray*) adjectListMACS:(AdjectiveValue)myAdjectiveValue withContext: (NSManagedObjectContext*) context;
- (NSArray*) wordListMACS:(WordValue)myWordValue withContext: (NSManagedObjectContext*) context;


@end
