//
//  VerbWord+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/12/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbWord+Create.h"

@implementation VerbWord (Create)

+ (VerbWord*) createVerbWord: (VerbWordData*) myVerbWord withSemanticType:(VerbSemanticType*) mySemanticType withContext: (NSManagedObjectContext* ) context
{
    VerbWord* theVerbWord = nil;
    
    if (myVerbWord != nil) {

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"VerbWord"];
        NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"infinitive LIKE[cd] %@", myVerbWord.infinitive];
        NSPredicate *predicateSemanticType = [NSPredicate predicateWithFormat:@"whatSemanticType = %@", mySemanticType];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateName,predicateSemanticType, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theVerbWord = [NSEntityDescription insertNewObjectForEntityForName:@"VerbWord"
                                                        inManagedObjectContext:context];

            theVerbWord.infinitive = myVerbWord.infinitive;
            theVerbWord.past = myVerbWord.past;
            theVerbWord.perfect = myVerbWord.perfect;
            theVerbWord.simple = myVerbWord.simple;
            theVerbWord.thirdPersonSingular = myVerbWord.thirdPersonSingular;
            theVerbWord.gerund = myVerbWord.gerund;
            theVerbWord.whatSemanticType = mySemanticType;
            
        }
        else {
            theVerbWord = [matches lastObject];
        }
        
    }
    return theVerbWord;
}

@end
