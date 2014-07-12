//
//  MainFoundation+SentenceController.h
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (SentenceController)

- (void) buildTheStory: (NSManagedObjectContext*) context;

- (Story*) myStoryBuilder: (NSManagedObjectContext*) context;

- (void) buildTheStoryFromMaker:(Character*) theCharacter withContext: (NSManagedObjectContext*) context;


@end
