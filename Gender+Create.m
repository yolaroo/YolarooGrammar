//
//  Gender+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Gender+Create.h"

@implementation Gender (Create)

+ (Gender *) genderWithName: (NSString *) theName withContext:(NSManagedObjectContext *) context
{
    Gender *theGender = nil;
    if ([theName length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Gender"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", theName];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theGender = [NSEntityDescription insertNewObjectForEntityForName:@"Gender"
                                                         inManagedObjectContext:context];
            theGender.name = theName;
            theGender.metaType = @"gender";
        }
        else {
            theGender = [matches lastObject];
        }
    }
    return theGender;
}

@end
