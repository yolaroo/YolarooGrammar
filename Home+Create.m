//
//  Home+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/5/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Home+Create.h"

@implementation Home (Create)

+ (Home *)homeWithString: (NSString *) myWord withContext:(NSManagedObjectContext *) context
{
    Home *theHome = nil;
    if ([myWord length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Home"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", myWord];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theHome = [NSEntityDescription insertNewObjectForEntityForName:@"Home"
                                                       inManagedObjectContext:context];
            theHome.name = myWord;
            theHome.metaType = @"home";
        }
        else {
            theHome = [matches lastObject];
        }
    }
    return theHome;
}

@end
