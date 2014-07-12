//
//  Age+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Age+Create.h"

@implementation Age (Create)

+ (Age*) ageWithNumber:(NSNumber*)age withContext:(NSManagedObjectContext *)context
{
    Age *theAge = nil;
    if (age != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Age"];
        request.predicate = [NSPredicate predicateWithFormat:@"age = %@", age];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theAge = [NSEntityDescription insertNewObjectForEntityForName:@"Age"
                                                      inManagedObjectContext:context];
            theAge.age = age;
            if ([age integerValue] == 1){
                theAge.name = [NSString stringWithFormat:@"%@ year old",[age stringValue]];
            }
            else {
                theAge.name = [NSString stringWithFormat:@"%@ years old",[age stringValue]];
            }
            theAge.metaType = @"age";
            theAge.objectType = @"years old";
            
        }
        else {
            theAge = [matches lastObject];
        }
    }
    return theAge;
}

+ (Age*) ageWithString:(NSString*)age withContext:(NSManagedObjectContext *)context
{
    Age *theAge = nil;
    if (age != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Age"];
        request.predicate = [NSPredicate predicateWithFormat:@"age = %@", @([age integerValue])];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theAge = [NSEntityDescription insertNewObjectForEntityForName:@"Age"
                                                   inManagedObjectContext:context];
            theAge.age = @([age integerValue]);
            theAge.name = age;

            theAge.metaType = @"age";
            theAge.objectType = @"years old";
        }
        else {
            theAge = [matches lastObject];
        }
    }
    return theAge;
}




@end
