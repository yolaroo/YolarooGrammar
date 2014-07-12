//
//  SyntacticType+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SyntacticType+Create.h"

@implementation SyntacticType (Create)

+ (SyntacticType *) syntacticTypeWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context
{
    SyntacticType* theSyntacticType = nil;
    if ([name length]) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SyntacticType"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theSyntacticType = [NSEntityDescription insertNewObjectForEntityForName:@"SyntacticType"
                                                            inManagedObjectContext:context];
            theSyntacticType.name = name;
        }
        else {
            theSyntacticType = [matches lastObject];
        }
    }
    return theSyntacticType;
}

@end
