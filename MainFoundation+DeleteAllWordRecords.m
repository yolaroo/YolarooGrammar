//
//  MainFoundation+DeleteAllWordRecords.m
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+DeleteAllWordRecords.h"

#import "Word.h"
#import "SemanticType.h"
#import "SyntacticType.h"

@implementation MainFoundation (DeleteAllWordRecords)

#define DK 2
#define LOG if(DK == 1)

- (void) masterWordDataDelete:(NSManagedObjectContext*)newContext
{
    NSArray* wordArray = [[self completeWordListForDelete:newContext]copy];
    for (Word* wrd in wordArray) {
        [newContext deleteObject:wrd];
    }
    
    NSArray* semanticArray = [[self completeSemanticTypeListForDelete:newContext]copy];
    for (SemanticType* smt in semanticArray) {
        [newContext deleteObject:smt];
    }
    
    NSArray* syntacticArray = [[self completeSyntacticTypeListForDelete:newContext]copy];
    for (SyntacticType* snt in syntacticArray) {
        [newContext deleteObject:snt];
    }
 
    wordArray = nil;
    semanticArray = nil;
    syntacticArray = nil;
    
    LOG NSLog(@"** Word Data Deleted **");
}

- (NSArray*) completeSyntacticTypeListForDelete: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SyntacticType" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeSemanticTypeListForDelete: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SemanticType" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

- (NSArray*) completeWordListForDelete: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

#pragma mark - Mass Deletion

- (void)deleteAllObjectsInContext:(NSManagedObjectContext *)context usingModel:(NSManagedObjectModel *)model
{
    NSArray *entities = model.entities;
    for (NSEntityDescription *entityDescription in entities) {
        [self deleteAllObjectsWithEntityName:entityDescription.name
                                   inContext:context];
    }
}

- (void)deleteAllObjectsWithEntityName:(NSString *)entityName
                             inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest =
    [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.includesPropertyValues = NO;
    fetchRequest.includesSubentities = NO;
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [context deleteObject:managedObject];
        LOG NSLog(@"Deleted %@", entityName);
    }
}

//
////
//

- (NSArray*) completeStoryListForDelete: (NSManagedObjectContext*)newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:newContext];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}


- (void) deleteStoryList: (NSManagedObjectContext*)newContext
{
    NSArray* wordArray = [self completeStoryListForDelete:newContext];
    for (Story* STR in wordArray) {
        [newContext deleteObject:STR];
    }
    [self saveData:newContext];
}




@end
