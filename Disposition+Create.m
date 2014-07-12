//
//  Disposition+Create.m
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Disposition+Create.h"

@implementation Disposition (Create)

+ (Disposition *) dispositionWithName: (NSString *) name withContext:(NSManagedObjectContext *) context
{
    Disposition *theDisposition = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Disposition"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theDisposition = [NSEntityDescription insertNewObjectForEntityForName:@"Disposition"
                                                      inManagedObjectContext:context];
            theDisposition.name = name;

        }
        else {
            theDisposition = [matches lastObject];
        }
    }
    return theDisposition;
}

@end
