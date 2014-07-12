//
//  ObjectPhrase+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "ObjectPhrase+Create.h"

@implementation ObjectPhrase (Create)

+ (ObjectPhrase*) createObject: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext* ) context
{
    ObjectPhrase*theObject = nil;
    
    if (theSentence != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ObjectPhrase"];
        NSPredicate *predicateSentence = [NSPredicate predicateWithFormat:@"whatSentence = %@",theSentence];
        
        NSArray *subPredicates = [NSArray arrayWithObjects:predicateSentence, nil];
        NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        request.predicate = andPredicate;

        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            theObject = [NSEntityDescription insertNewObjectForEntityForName:@"ObjectPhrase"
                                                       inManagedObjectContext:context];
            
            theObject.theWord = [dictionary objectForKey:@"word"];
            theObject.theInfinitive = [dictionary objectForKey:@"word_infinitive"];
            
            if([dictionary objectForKey:@"isNumber"]){
                theObject.isNumber = [dictionary objectForKey:@"isNumber"];
            }
            
            if([dictionary objectForKey:@"determiner"]){
                theObject.whatDeterminer = [dictionary objectForKey:@"determiner"];
            }
            
            if ([dictionary objectForKey:@"adjective"]) {
                NSSet* adjectiveSet = [NSSet setWithObjects:[dictionary objectForKey:@"adjective"], nil];
                theObject.whatAdjective = adjectiveSet;
            }
            
            if ([dictionary objectForKey:@"isAnAdjective"]) {
                theObject.isAnAdjective = [dictionary objectForKey:@"isAnAdjective"];
            }
            
            if ([dictionary objectForKey:@"possesive_object"]) {
                theObject.thePossesive = [dictionary objectForKey:@"possesive_object"];
            }

            if ([dictionary objectForKey:@"word_object"]) {

                //NSSet* wordSet = [NSSet setWithObjects:[dictionary objectForKey:@"word_object"], nil];
                //theObject.whatWord = wordSet;
                if ([[dictionary objectForKey:@"word_object"] isKindOfClass:[NSArray class]]) {
                    // NSLog(@"-- finished making nsset from nsarray --");
                    NSSet* wordSet = [NSSet setWithArray:[dictionary objectForKey:@"word_object"]];
                    theObject.whatWord  = wordSet;
                }
                else {
                    // LOG NSLog(@"-- finished making nsset from OTHER --");
                    NSSet* wordSet = [NSSet setWithObjects:[dictionary objectForKey:@"word_object"], nil];
                    theObject.whatWord  = wordSet;
                }
                
            }
            
            NSSet* subjectSet = [NSSet setWithObjects:theSentence, nil];
            theObject.whatSentence = subjectSet;
            
        }
        else {
            theObject = [matches lastObject];
        }
    }
    return theObject;
}


@end
