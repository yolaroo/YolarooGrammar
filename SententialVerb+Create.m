//
//  Verb+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SententialVerb+Create.h"

@implementation SententialVerb (Create)

+ (SententialVerb*) createSententialVerbForSentence: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext* ) context
{
    SententialVerb*theVerb = nil;
    
    if (theSentence != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SententialVerb"];
        request.predicate = [NSPredicate predicateWithFormat:@"whatSentence = %@", theSentence];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theVerb = [NSEntityDescription insertNewObjectForEntityForName:@"SententialVerb"
                                                    inManagedObjectContext:context];
            
            theVerb.theVerb = [dictionary objectForKey:@"theVerb"];
            theVerb.isCopula = [dictionary objectForKey:@"isCopula"];
            theVerb.sentenceTense = [dictionary objectForKey:@"sentenceTense"];
            theVerb.sentenceModal = [dictionary objectForKey:@"sentenceModal"];
            theVerb.isSubjectPlural = [dictionary objectForKey:@"isSubjectPlural"];
            
        }
        else {
            theVerb = [matches lastObject];
        }
    }
    return theVerb;
}

@end
