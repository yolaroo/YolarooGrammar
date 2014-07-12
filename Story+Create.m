//
//  Story+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Story+Create.h"

@implementation Story (Create)

#define DK 2
#define LOG if(DK == 1)

+ (Story*) createStory: (NSString*) theUUID withContext: (NSManagedObjectContext* ) context
{
    Story*theStory = nil;
    LOG NSLog(@"** STORY CREATE **");
    if ([theUUID length]) {
                
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Story"];
        request.predicate = [NSPredicate predicateWithFormat:@"uuID = %@", theUUID];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theStory = [NSEntityDescription insertNewObjectForEntityForName:@"Story"
                                                        inManagedObjectContext:context];
            theStory.uuID = theUUID;
            
        }
        else {
            theStory = [matches lastObject];
        }
        
    }
    LOG NSLog(@"** STORY CREATE FINISH **");
    return theStory;
}


@end
