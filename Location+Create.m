//
//  Location+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Location+Create.h"

@implementation Location (Create)


+ (Location *)locationWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Location *theLocation = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Location"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theLocation = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                      inManagedObjectContext:context];
            theLocation.name = name;
            theLocation.metaType = @"location";

        }
        else {
            theLocation = [matches lastObject];
        }
    }
    return theLocation;
}

@end
