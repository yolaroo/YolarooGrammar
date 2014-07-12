//
//  MainFoundation+AdjectiveSearch.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+AdjectiveSearch.h"

@implementation MainFoundation (AdjectiveSearch)

- (NSArray*) completeAdjectiveList: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"whatSemanticType" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];

    return fetchedRecords;
}

- (NSArray*) completeAdjectiveSemanticTypeList: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveSemanticType" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


- (NSArray*) selectedAdjectiveListFromSemanticType:(AdjectiveSemanticType*)withType withContext:(NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:newContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", withType];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"basic" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];

    return fetchedRecords;
}

- (NSArray*) selectedAdjectiveListForName:(NSString*)name withContext:(NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:newContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"basic = %@", name];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"basic" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) selectedAdjectiveListFromSemanticTypeWithName:(NSString*)withType withContext:(NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"AdjectiveClass" inManagedObjectContext:newContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", withType];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"basic" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

@end
