//
//  Goal+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Goal+Create.h"

@implementation Goal (Create)


+ (Goal *) goalWithNameandInfinitiveForGoalMaker:(GoalMaker*) myGoal withContext:(NSManagedObjectContext *)context
{
    Goal *theGoal = nil;
    if ([myGoal.name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Goal"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", myGoal.name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theGoal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                    inManagedObjectContext:context];
            theGoal.name = myGoal.name;
            theGoal.infinitive = myGoal.infinitive;
            theGoal.metaType = @"goal";
        }
        else {
            theGoal = [matches lastObject];
        }
    }
    return theGoal;
}


//
////
//

+ (Goal *) goalWithNameandInfinitive:(NSString *)name withInfinitive: (NSString*)infinitive withContext:(NSManagedObjectContext *)context
{
    Goal *theGoal = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Goal"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theGoal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                    inManagedObjectContext:context];
            theGoal.name = name;
            theGoal.infinitive = infinitive;
            theGoal.metaType = @"goal";
            
        }
        else {
            theGoal = [matches lastObject];
        }
    }
    return theGoal;
}


+ (Goal *) goalWithName:(NSString *)name withContext:(NSManagedObjectContext *)context
{
    Goal *theGoal = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Goal"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theGoal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                       inManagedObjectContext:context];
            theGoal.name = name;
            theGoal.metaType = @"goal";

        }
        else {
            theGoal = [matches lastObject];
        }
    }
    return theGoal;
}

+ (Goal *) goalWithWordObject:(Word *)myWord withContext:(NSManagedObjectContext *)context
{
    Goal *theGoal = nil;
    if ([myWord.english length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Goal"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", myWord.english];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theGoal = [NSEntityDescription insertNewObjectForEntityForName:@"Goal"
                                                    inManagedObjectContext:context];
            theGoal.name = myWord.english;
            theGoal.isPlural = myWord.isPlural;
            theGoal.metaType = @"goal";

        }
        else {
            theGoal = [matches lastObject];
        }
    }
    return theGoal;
}

@end
