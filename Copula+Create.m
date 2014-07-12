//
//  Copula+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/7/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Copula+Create.h"

@implementation Copula (Create)

+ (Copula *) getCopula:(NSManagedObjectContext *) context
{
    Copula *theCopula = nil;
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Copula"];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theCopula = [NSEntityDescription insertNewObjectForEntityForName:@"Copula"
                                                      inManagedObjectContext:context];
            
            
            theCopula.infinitive = @"to be";
            theCopula.pastPlural = @"were";
            theCopula.pastSingular = @"was";
            theCopula.presentPlural = @"are";
            theCopula.firstPersonSingular = @"am";
            theCopula.secondPersonSingular = @"are";
            theCopula.thirdPersonSingular = @"is";
            theCopula.future = @"be";

        }
        else {
            theCopula = [matches lastObject];
        }
    return theCopula;
}

@end
