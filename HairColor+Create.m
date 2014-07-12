//
//  HairColor+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "HairColor+Create.h"

@implementation HairColor (Create)

+ (HairColor *) hairColorWithColor: (NSString *) theColor withContext:(NSManagedObjectContext *) context
{
    HairColor *theHairColor = nil;
    if ([theColor length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HairColor"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", theColor];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theHairColor = [NSEntityDescription insertNewObjectForEntityForName:@"HairColor"
                                                    inManagedObjectContext:context];
            theHairColor.name = theColor;
            theHairColor.metaType = @"hair color";
        }
        else {
            theHairColor = [matches lastObject];
        }
    }
    return theHairColor;
}

@end
