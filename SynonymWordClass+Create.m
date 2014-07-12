//
//  SynonymWordClass+Create.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymWordClass+Create.h"

@implementation SynonymWordClass (Create)

+ (SynonymWordClass *) synonymWordWithName: (NSString *) name withContext:(NSManagedObjectContext *) context
{
    SynonymWordClass *theSynonymWord = nil;
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SynonymWordClass"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            theSynonymWord = [NSEntityDescription insertNewObjectForEntityForName:@"SynonymWordClass"
                                                             inManagedObjectContext:context];
            theSynonymWord.name  = name;
        }
        else {
            theSynonymWord = [matches lastObject];
        }
    }
    return theSynonymWord;
}

@end
