//
//  AdjectiveClass+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/24/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdjectiveClass+Create.h"

@implementation AdjectiveClass (Create)

+ (AdjectiveClass *) adjectiveWithName: (AdjectiveWordData *) theAdjective withSemanticType: (AdjectiveSemanticType *) mySemanticType inManagedObjectContext:(NSManagedObjectContext *) context
{
    AdjectiveClass* theAdjectiveClass = nil;
    if (theAdjective != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"AdjectiveClass"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"basic = %@", theAdjectiveClass.basic];
        NSPredicate *predicateSemanticType = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", mySemanticType];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicateSemanticType, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theAdjectiveClass = [NSEntityDescription insertNewObjectForEntityForName:@"AdjectiveClass"
                                                    inManagedObjectContext:context];
            
            theAdjectiveClass.basic = theAdjective.basic;
            theAdjectiveClass.name = theAdjective.basic;
            theAdjectiveClass.comparative = theAdjective.comparative;
            theAdjectiveClass.superlative = theAdjective.superlative;
            
            theAdjectiveClass.whatSemanticType = mySemanticType;
        }
        else {
            theAdjectiveClass = [matches lastObject];
        }
    }
    return theAdjectiveClass;
}

@end
