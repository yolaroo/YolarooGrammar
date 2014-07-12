//
//  Interests+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Likes+Create.h"

@implementation Likes (Create)

+ (Likes *)likesWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Likes *theLike = nil;
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Likes"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            theLike = [NSEntityDescription insertNewObjectForEntityForName:@"Likes"
                                                        inManagedObjectContext:context];
            theLike.name = name;
            theLike.metaType = @"like";

        }
        else {
            theLike = [matches lastObject];
        }
    }
    return theLike;
}

+ (Likes *)likesWithWordObject:(Word *)myWord withContext:(NSManagedObjectContext *)context
{
    Likes *theLike = nil;
    if ([myWord.english length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Likes"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", myWord.english];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            theLike = [NSEntityDescription insertNewObjectForEntityForName:@"Likes"
                                                    inManagedObjectContext:context];
            theLike.name = myWord.english;
            theLike.isPlural = myWord.isPlural;
            theLike.metaType = @"like";

            
        }
        else {
            theLike = [matches lastObject];
        }
    }
    return theLike;
}

@end
