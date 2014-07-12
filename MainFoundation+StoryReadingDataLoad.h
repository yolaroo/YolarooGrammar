//
//  MainFoundation+StoryReadingDataLoad.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (StoryReadingDataLoad)


- (NSString*) titleString: (Story*)myStory;

- (Story*) myStoryLoader: (NSInteger)myIndex withContext:(NSManagedObjectContext*)context;

- (NSArray*) storySentencesDataLoad:(Story*)myStory withContext:(NSManagedObjectContext*)context;

- (NSArray*) loadSentencesToString: (NSArray*) sentenceArray;

- (NSInteger) myStoryIndexMax: (NSManagedObjectContext*)context;

@end
