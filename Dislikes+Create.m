//
//  Interests+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Dislikes+Create.h"

@implementation Dislikes (Create)

+ (Dislikes *)dislikesWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Dislikes *theDislike = nil;
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Dislikes"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            theDislike = [NSEntityDescription insertNewObjectForEntityForName:@"Dislikes"
                                                        inManagedObjectContext:context];
            theDislike.name = name;
            theDislike.metaType = @"dislike";

        }
        else {
            theDislike = [matches lastObject];
        }
    }
    return theDislike;
}

+ (Dislikes *)dislikesWithWordObject:(Word *)myWord withContext:(NSManagedObjectContext *)context
{
    Dislikes *theDislike = nil;
    if ([myWord.english length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Dislikes"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", myWord.english];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            theDislike = [NSEntityDescription insertNewObjectForEntityForName:@"Dislikes"
                                                    inManagedObjectContext:context];
            theDislike.name = myWord.english;
            theDislike.isPlural = myWord.isPlural;
            theDislike.metaType = @"dislike";

            
        }
        else {
            theDislike = [matches lastObject];
        }
    }
    return theDislike;
}
@end
