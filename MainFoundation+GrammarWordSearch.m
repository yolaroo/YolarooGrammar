//
//  MainFoundation+GrammarWordSearch.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+GrammarWordSearch.h"

@implementation MainFoundation (GrammarWordSearch)

- (NSArray*) completeGrammarWordList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"GrammarWord" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"GrammarWordSemanticType" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeGrammarWordSemanticTypeList: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"GrammarWordSemanticType" inManagedObjectContext:newContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) grammarWordListFromSemanticType:(GrammarWordSemanticType*)mySemanticType withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"GrammarWord" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", mySemanticType];
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

- (NSArray*) grammarWordListFromSemanticTypeName:(NSString*)mySemanticTypeName withContext: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"GrammarWord" inManagedObjectContext:newContext];
    
    NSPredicate *predicateUser  = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", mySemanticTypeName];
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

@end
