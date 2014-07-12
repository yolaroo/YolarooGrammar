//
//  MainFoundation+WordComparisonDataLoader.h
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (WordComparisonDataLoader)



- (void) setMyComparisonDataClass: (NSArray*)myComparisonClassData withWinnerString: (NSString*)theWinner withSentenceString:(NSString*) fullString withContext:(NSManagedObjectContext*) context;

- (NSArray*) myDataLoaderForComparisons: (NSArray*) myAdjective withContext:(NSManagedObjectContext*) context;

- (NSArray*) setAdjectiveGroup: (NSManagedObjectContext*) context;

@end
