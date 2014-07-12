//
//  Weight+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Weight+Create.h"

@implementation Weight (Create)


+ (Weight *) weightWithNumber: (NSNumber *) theNumber withContext:(NSManagedObjectContext *) context
{
    Weight *theWeight = nil;
    if (theNumber) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Weight"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", theNumber];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Weight"
                                                      inManagedObjectContext:context];
            
            NSNumber * mylb =  [NSNumber numberWithInteger:(NSInteger)[theNumber integerValue]*1.5085509];
            theWeight.name = [NSString stringWithFormat:@"%@kg (%@lb)", [theNumber stringValue], [mylb stringValue]];
            theWeight.metaType = @"weight";
            theWeight.weight = theNumber;
        }
        else {
            theWeight = [matches lastObject];
        }
    }
    return theWeight;
}

+ (Weight *) weightWithString: (NSString *) theNumber withContext:(NSManagedObjectContext *) context
{
    Weight *theWeight = nil;
    if (theNumber) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Weight"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", @([theNumber integerValue])];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theWeight = [NSEntityDescription insertNewObjectForEntityForName:@"Weight"
                                                      inManagedObjectContext:context];
            
            theWeight.name = theNumber;
            theWeight.metaType = @"weight";
            theWeight.weight = @([theNumber integerValue]);
        }
        else {
            theWeight = [matches lastObject];
        }
    }
    return theWeight;
}

@end
