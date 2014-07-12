//
//  Birthday+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Birthday+Create.h"

@implementation Birthday (Create)

+ (Birthday *)birthdayWithDate: (NSDate *) theDate withDateString: (NSString*) dateString  withContext:(NSManagedObjectContext *) context
{
    Birthday *theBirthday = nil;
    if (theDate != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Birthday"];
        request.predicate = [NSPredicate predicateWithFormat:@"date = %@", theDate];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theBirthday = [NSEntityDescription insertNewObjectForEntityForName:@"Birthday"
                                                    inManagedObjectContext:context];
            theBirthday.metaType = @"birthday";
            theBirthday.date = theDate;
            theBirthday.name = dateString;
        }
        else {
            theBirthday = [matches lastObject];
        }
    }
    return theBirthday;
}


@end
