//
//  EyeColor+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "EyeColor+Create.h"

@implementation EyeColor (Create)

+ (EyeColor *) eyeColorWithColor: (NSString *) theColor withContext:(NSManagedObjectContext *) context
{
    EyeColor *theEyeColor = nil;
    if ([theColor length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"EyeColor"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", theColor];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theEyeColor = [NSEntityDescription insertNewObjectForEntityForName:@"EyeColor"
                                                         inManagedObjectContext:context];
            theEyeColor.name = theColor;
            theEyeColor.metaType = @"eye color";
        }
        else {
            theEyeColor = [matches lastObject];
        }
    }
    return theEyeColor;
}

@end
