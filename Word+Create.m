//
//  Word+Create.m
//  YolarooGrammar
//
//  Created by MGM on 3/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Word+Create.h"
#import "SemanticType.h"

@implementation Word (Create)

#define DK 2
#define LOG if(DK == 1)


+ (Word *) emptyWordFetch:(NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:newContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"english LIKE[cd] %@", @" "];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return [fetchedRecords firstObject];
}

+ (Word *) wordCreateThatIsEmpty:(NSManagedObjectContext *)context
{
    Word* theWord = nil;
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Word"];
        request.predicate = [NSPredicate predicateWithFormat:@"english LIKE[cd] %@", @" "];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            theWord = [NSEntityDescription insertNewObjectForEntityForName:@"Word"
                                                    inManagedObjectContext:context];
            theWord.english = @" ";
            theWord.name = @" ";

            
        }
        else {
            theWord = [matches lastObject];
        }
    return theWord;
}

+ (Word *)wordWithName:(NSString *)name withSemanticType: (SemanticType* )mySemanticType withSyntacticType: (SyntacticType*) mySyntacticType withWordObject: (NSString*) wordObject inManagedObjectContext:(NSManagedObjectContext *)context
{
    Word* theWord = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Word"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"english = %@", name];
        NSPredicate *predicateSemanticType = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", mySemanticType];
        NSPredicate *predicateSyntacticType = [NSPredicate predicateWithFormat:@"whatSyntacticType = %@", mySyntacticType];

        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicateSemanticType,predicateSyntacticType, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theWord = [NSEntityDescription insertNewObjectForEntityForName:@"Word"
                                                    inManagedObjectContext:context];
            theWord.english = name;
            theWord.name    = name;
            theWord.whatSemanticType = mySemanticType;
            theWord.whatSyntacticType = mySyntacticType;
            theWord.wordObject = wordObject;

        }
        else {
            theWord = [matches lastObject];
        }
    }
    return theWord;
}

+ (Word *)wordWithNameFromNil:(NSString *)name withContext: (NSManagedObjectContext *)context
{
    Word* theWord = nil;
    if ([name length]) {
        LOG NSLog(@"0");
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Word"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"english = %@", name];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            LOG NSLog(@"1");
            theWord = [NSEntityDescription insertNewObjectForEntityForName:@"Word"
                                                    inManagedObjectContext:context];
            theWord.english = name;
            theWord.name    = name;
            
            NSFetchRequest *semanticRequest = [NSFetchRequest fetchRequestWithEntityName:@"SemanticType"];
            semanticRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"new"];
            NSError *newError;
            NSArray *newMatches = [context executeFetchRequest:semanticRequest error:&newError];

            if ([newMatches count]) {
                LOG NSLog(@"2");
                SemanticType*theSemanticType;
                theSemanticType = [newMatches firstObject];
                theWord.whatSemanticType = theSemanticType;
            }
            else {
                LOG NSLog(@"3");
                SemanticType*theSemanticType;
                theSemanticType = [NSEntityDescription insertNewObjectForEntityForName:@"SemanticType"
                                                                inManagedObjectContext:context];
                
                theSemanticType.name = @"new";
                theWord.whatSemanticType = theSemanticType;
            }
        }
        else {
            LOG NSLog(@"4");
            theWord = [matches lastObject];
        }
    }
    LOG NSLog(@"5");
    return theWord;
}

@end
