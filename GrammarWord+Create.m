//
//  GrammarWord+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "GrammarWord+Create.h"

@implementation GrammarWord (Create)

+ (GrammarWord *)grammarWordWithName:(NSString *)name withSemanticType: (GrammarWordSemanticType* )mySemanticType inManagedObjectContext:(NSManagedObjectContext *)context
{
    GrammarWord* theWord = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarWord"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSPredicate *predicateSemanticType = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", mySemanticType];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicateSemanticType, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theWord = [NSEntityDescription insertNewObjectForEntityForName:@"GrammarWord"
                                                    inManagedObjectContext:context];
            theWord.name = name;
            theWord.whatSemanticType = mySemanticType;
        }
        else {
            theWord = [matches lastObject];
        }
    }
    return theWord;
}

+ (GrammarWord *)grammarWordForNewName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    GrammarWord* theWord = nil;
    if ([name length]) {
        
        NSFetchRequest *semanticTypeRequest = [NSFetchRequest fetchRequestWithEntityName:@"GrammarWordSemanticType"];
        semanticTypeRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@", @"proper name"];
        NSError *semanticTypeError;
        NSArray *semanticTypeMatches = [context executeFetchRequest:semanticTypeRequest error:&semanticTypeError];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarWord"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSPredicate *predicateSemanticType = [NSPredicate predicateWithFormat:@"whatSemanticType.name = %@", @"proper name"];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicateSemanticType, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
                
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theWord = [NSEntityDescription insertNewObjectForEntityForName:@"GrammarWord"
                                                    inManagedObjectContext:context];
            theWord.name = name;
            theWord.whatSemanticType = [semanticTypeMatches firstObject];
            theWord.isUserGenerated = [NSNumber numberWithBool:true];
        }
        else {
            theWord = [matches lastObject];
        }
    }
    return theWord;
}

@end
