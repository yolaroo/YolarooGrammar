//
//  MainFoundation+StoryQuestionsDataloader.h
//  YolarooGrammar
//
//  Created by MGM on 5/13/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (StoryQuestionsDataloader)

- (NSArray*) myMainStoryLoader: (NSInteger)myCount withContext: (NSManagedObjectContext*)context;

- (NSInteger) theStoryMax: (NSManagedObjectContext*)context;

- (void) resetStoryAction:(NSManagedObjectContext*)context;

- (void) storyCountCheckOnLoad:(NSManagedObjectContext*)context;


@end
