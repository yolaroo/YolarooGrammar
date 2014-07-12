//
//  Job+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Job+Create.h"

@implementation Job (Create)

+ (Job *)jobWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Job *theJob = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Job"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            theJob = [NSEntityDescription insertNewObjectForEntityForName:@"Job"
                                                      inManagedObjectContext:context];
            theJob.name = name;
            theJob.metaType = @"job";

        }
        else {
            theJob = [matches lastObject];
        }
    }
    return theJob;
}

@end
