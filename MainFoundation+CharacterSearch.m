//
//  MainFoundation+CharacterSearch.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+CharacterSearch.h"

@implementation MainFoundation (CharacterSearch)


- (NSArray*) completeCharacterList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Character" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}


@end
