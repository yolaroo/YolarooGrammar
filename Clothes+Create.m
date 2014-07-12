//
//  Clothes+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Clothes+Create.h"

@implementation Clothes (Create)

+ (Clothes *)clothesWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Clothes *theClothes = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Clothes"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theClothes = [NSEntityDescription insertNewObjectForEntityForName:@"Clothes"
                                                        inManagedObjectContext:context];
            theClothes.name = name;
            theClothes.metaType = @"clothes";

        }
        else {
            theClothes = [matches lastObject];
        }
    }
    return theClothes;
}

+ (Clothes *)clothesWithWordObject: (Word *)myWord withContext:(NSManagedObjectContext *)context
{
    Clothes *theClothes = nil;
    if ([myWord.english length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Clothes"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", myWord.english];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theClothes = [NSEntityDescription insertNewObjectForEntityForName:@"Clothes"
                                                       inManagedObjectContext:context];
            theClothes.name = myWord.english;
            theClothes.isPlural = myWord.isPlural;
            theClothes.metaType = @"clothes";

            
        }
        else {
            theClothes = [matches lastObject];
        }
    }
    return theClothes;
}

@end
