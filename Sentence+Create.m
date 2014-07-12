//
//  Sentence+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Sentence+Create.h"

@implementation Sentence (Create)

+ (Sentence*) createSentenceWithUUID: (NSString*) theUUID withContext: (NSManagedObjectContext* ) context
{
    Sentence*theSentence = nil;
    
    if ([theUUID length]) {
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Sentence"];
        request.predicate = [NSPredicate predicateWithFormat:@"uuID = %@", theUUID];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];

        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
    
            theSentence = [NSEntityDescription insertNewObjectForEntityForName:@"Sentence"
                                                     inManagedObjectContext:context];
            theSentence.uuID = theUUID;
            
        }
        else {
            theSentence = [matches lastObject];
        }

    }
    return theSentence;
}

@end
