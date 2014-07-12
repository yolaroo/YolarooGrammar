//
//  AdjectiveSemanticType+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/24/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdjectiveSemanticType+Create.h"

@implementation AdjectiveSemanticType (Create)

+ (AdjectiveSemanticType *) adjectiveSemanticTypeWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context
{
    AdjectiveSemanticType* theSemanticType = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"AdjectiveSemanticType"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theSemanticType = [NSEntityDescription insertNewObjectForEntityForName:@"AdjectiveSemanticType"
                                                            inManagedObjectContext:context];
            theSemanticType.name = name;
        }
        else {
            theSemanticType = [matches lastObject];
        }
    }
    return theSemanticType;
}

@end
