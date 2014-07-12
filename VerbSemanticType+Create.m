//
//  VerbSemanticType+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbSemanticType+Create.h"

@implementation VerbSemanticType (Create)

+ (VerbSemanticType *) semanticTypeForGrammarWordWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context
{
    VerbSemanticType* theSemanticType = nil;
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VerbSemanticType"];
        request.predicate = [NSPredicate predicateWithFormat:@"name LIKE[cd] %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theSemanticType = [NSEntityDescription insertNewObjectForEntityForName:@"VerbSemanticType"
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
