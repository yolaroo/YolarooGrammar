//
//  Specie+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Specie+Create.h"

@implementation Specie (Create)

+ (Specie *)specieWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Specie *theSpecie = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Specie"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theSpecie = [NSEntityDescription insertNewObjectForEntityForName:@"Specie"
                                                        inManagedObjectContext:context];
            theSpecie.name = name;
            theSpecie.metaType = @"specie";

        }
        else {
            theSpecie = [matches lastObject];
        }
    }
    return theSpecie;
}

@end
