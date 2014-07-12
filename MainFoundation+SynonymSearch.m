//
//  MainFoundation+SynonymSearch.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SynonymSearch.h"

@implementation MainFoundation (SynonymSearch)

- (NSArray*) completeSynonymClassList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SynonymObjectClass" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) selectSynonymClassfromName: (NSString*)className withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SynonymObjectClass" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"name LIKE [cd] %@", className];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) selectSynonymWordFromClassType: (SynonymObjectClass*) className withContext: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SynonymWordClass" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"ANY whatType = %@", className];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) selectSynonymWordFromClassName: (NSString*) className withContext: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SynonymWordClass" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"ANY whatType.name = %@", className];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}

- (NSArray*) selectSynonymWordFromName: (NSString*) name withContext: (NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SynonymWordClass" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedRecords;
}


@end
