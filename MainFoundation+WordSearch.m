//
//  MainFoundation+WordSearch.m
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+WordSearch.h"

@implementation MainFoundation (WordSearch)

- (NSArray*) completeWordList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"whatSemanticType" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];

    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) wordListFromSemanticType:(SemanticType*)mySemanticType withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", mySemanticType];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"english" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) wordListFromSemanticTypeName:(NSString*)mySemanticTypeName withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", mySemanticTypeName];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"english" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) wordListFromName:(NSString*)name withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"english LIKE [cd] %@", name];
    NSArray *subPredicates = [NSArray arrayWithObjects:predicateUser, nil];
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    fetchRequest.predicate = andPredicate;
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}


@end
