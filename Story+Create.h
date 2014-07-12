//
//  Story+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Story.h"

@interface Story (Create)

+ (Story*) createStory: (NSString*) theUUID withContext: (NSManagedObjectContext* ) context;

@end
