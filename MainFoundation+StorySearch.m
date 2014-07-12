//
//  MainFoundation+StorySearch.m
//  YolarooGrammar
//
//  Created by MGM on 4/14/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+StorySearch.h"

@implementation MainFoundation (StorySearch)

- (NSArray*) completeStoryList: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"displayOrder" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"VerbList Fetch Count - %lu", (unsigned long)[fetchedRecords count]);
    return fetchedRecords;
}

- (NSInteger) completeStoryCount: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"VerbList Fetch Count - %lu", (unsigned long)[fetchedRecords count]);
    return [fetchedRecords count];
}

- (NSArray*) completeSentenceListForAStory: (Story*) theStory withContext: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Sentence" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"whatStory = %@", theStory];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;

    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    //NSLog(@"VerbList Fetch Count - %lu", (unsigned long)[fetchedRecords count]);
    return fetchedRecords;
}




@end
