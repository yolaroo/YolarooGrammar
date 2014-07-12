//
//  Event+Create.m
//  YolarooGrammar
//
//  Created by MGM on 5/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Event+Create.h"

@implementation Event (Create)

+ (Event *) eventWithTitle:(NSString *)title withArray: (NSArray*)eventArray withContext:(NSManagedObjectContext *)context
{
    Event *theEvent = nil;
    if ([title length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event"
                                                    inManagedObjectContext:context];
            theEvent.title = title;
            if ([eventArray count] >= 3){
                theEvent.name  = [eventArray lastObject];
                theEvent.verb  = [eventArray firstObject];
                theEvent.object  = [eventArray objectAtIndex:1];
            }
            
        }
        else {
            theEvent = [matches lastObject];
        }
    }
    return theEvent;
}

+ (Event *) eventWithEventMaker:(EventMaker*)myEvent withContext:(NSManagedObjectContext *)context
{
    Event *theEvent = nil;
    if ([myEvent.name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", myEvent.title];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theEvent = [NSEntityDescription insertNewObjectForEntityForName:@"Event"
                                                     inManagedObjectContext:context];
            theEvent.title = myEvent.title;
            theEvent.name  = myEvent.name;
            theEvent.verb  = myEvent.verb;
            theEvent.object  = myEvent.object;
        }
        else {
            theEvent = [matches lastObject];
        }
    }
    return theEvent;
}




@end
