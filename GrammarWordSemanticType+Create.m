//
//  GrammarWordSemanticType+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "GrammarWordSemanticType+Create.h"

@implementation GrammarWordSemanticType (Create)


+ (GrammarWordSemanticType *) semanticTypeForGrammarWordWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context
{
    GrammarWordSemanticType* theSemanticType = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GrammarWordSemanticType"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theSemanticType = [NSEntityDescription insertNewObjectForEntityForName:@"GrammarWordSemanticType"
                                                            inManagedObjectContext:context];
            theSemanticType.name = name;
        }
        else {
            theSemanticType = [matches lastObject];
        }
    }
    return theSemanticType;
}

@end
