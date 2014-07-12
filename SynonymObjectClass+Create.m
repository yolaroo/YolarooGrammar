//
//  SynonymObjectClass+Create.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymObjectClass+Create.h"

@implementation SynonymObjectClass (Create)

+ (SynonymObjectClass *) synonymClassWithName: (NSString *) name withAntonym: (NSString *) antonym withContext:(NSManagedObjectContext *) context
{
    SynonymObjectClass *theSynonymObject = nil;
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SynonymObjectClass"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            theSynonymObject = [NSEntityDescription insertNewObjectForEntityForName:@"SynonymObjectClass"
                                                          inManagedObjectContext:context];
            theSynonymObject.name  = name;
            theSynonymObject.antonym  = antonym;
        }
        else {
            theSynonymObject = [matches lastObject];
        }
    }
    return theSynonymObject;
}

@end
