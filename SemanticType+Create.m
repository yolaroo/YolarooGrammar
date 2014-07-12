//
//  SemanticType+Create.m
//  YolarooGrammar
//
//  Created by MGM on 3/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SemanticType+Create.h"

@implementation SemanticType (Create)

+ (SemanticType *) semanticTypeWithName: (NSString *) name withWordObject: (NSString*) wordObject inManagedObjectContext:(NSManagedObjectContext *) context
{
    SemanticType* theSemanticType = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SemanticType"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theSemanticType = [NSEntityDescription insertNewObjectForEntityForName:@"SemanticType"
                                                    inManagedObjectContext:context];
            theSemanticType.name = name;
            theSemanticType.wordObject = wordObject;
        }
        else {
            theSemanticType = [matches lastObject];
        }
    }
    return theSemanticType;
}

@end
