//
//  MainFoundation+StorySearch.h
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (StorySearch)

- (NSArray*) completeStoryList: (NSManagedObjectContext*) newContext;

- (NSArray*) completeSentenceListForAStory: (Story*) theStory withContext: (NSManagedObjectContext*) newContext;

- (NSInteger) completeStoryCount: (NSManagedObjectContext*) newContext;


@end
