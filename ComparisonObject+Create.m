//
//  ComparisonObject+Create.m
//  YolarooGrammar
//
//  Created by MGM on 5/9/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "ComparisonObject+Create.h"

@implementation ComparisonObject (Create)

+ (ComparisonObject *) comparisonWithName: (NSString *) name withContext:(NSManagedObjectContext *) context
{
    ComparisonObject *theComparison = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ComparisonObject"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theComparison = [NSEntityDescription insertNewObjectForEntityForName:@"ComparisonObject"
                                                           inManagedObjectContext:context];
            theComparison.name  = name;
        }
        else {
            theComparison = [matches lastObject];
        }
    }
    return theComparison;
}


@end
