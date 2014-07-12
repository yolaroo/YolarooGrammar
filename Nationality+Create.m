//
//  Nationality+Create.m
//  YolarooGrammar
//
//  Created by MGM on 5/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Nationality+Create.h"

@implementation Nationality (Create)

+ (Nationality *) nationalityWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Nationality *theNationality = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Nationality"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theNationality = [NSEntityDescription insertNewObjectForEntityForName:@"Nationality"
                                                    inManagedObjectContext:context];
            theNationality.name = name;
            
        }
        else {
            theNationality = [matches lastObject];
        }
    }
    return theNationality;
}

@end
