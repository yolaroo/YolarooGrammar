//
//  MainFoundation+ComparisonSearch.m
//  YolarooGrammar
//
//  Created by MGM on 5/9/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+ComparisonSearch.h"

@implementation MainFoundation (ComparisonSearch)

- (NSArray*) completeComparisonList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ComparisonObject" inManagedObjectContext:newContext];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"adjective" ascending:YES];
    NSSortDescriptor *sortDescriptorTwo = [[NSSortDescriptor alloc] initWithKey:@"sentence" ascending:YES];

    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor,sortDescriptorTwo, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

@end
