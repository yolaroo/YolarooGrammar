//
//  MainFoundation+StoryQuestionUtilities.h
//  YolarooGrammar
//
//  Created by MGM on 5/22/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (StoryQuestionUtilities)

- (NSArray*) storyList: (NSManagedObjectContext*)context;

- (NSArray*) sentenceOrder: (NSArray*)sentenceArrayInput;


@end
