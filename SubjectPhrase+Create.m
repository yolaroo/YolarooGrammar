//
//  SubjectPhrase+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SubjectPhrase+Create.h"

@implementation SubjectPhrase (Create)

#define DK 2
#define LOG if(DK == 1)

+ (SubjectPhrase*) createSubject: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext* ) context
{
    SubjectPhrase*theSubject = nil;
    LOG NSLog(@"^^ Create Subject ^^");
    if (theSentence != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SubjectPhrase"];
        request.predicate = [NSPredicate predicateWithFormat:@"whatSentence = %@",theSentence];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];

        if (!matches || ([matches count] > 1)) {
            LOG NSLog(@"fetch match A");

        } else if (![matches count]) {
            LOG NSLog(@"Make Subject");
            theSubject = [NSEntityDescription insertNewObjectForEntityForName:@"SubjectPhrase"
                                                       inManagedObjectContext:context];
            
            theSubject.theWord = [dictionary objectForKey:@"word"];
        
            if([dictionary objectForKey:@"determiner"]){
                theSubject.whatDeterminer = [dictionary objectForKey:@"determiner"];
            }
            
            if ([dictionary objectForKey:@"adjective"]) {
                NSSet* adjectiveSet = [NSSet setWithObjects:[dictionary objectForKey:@"adjective"], nil];
                theSubject.whatAdjective = adjectiveSet;
            }
    
            if([dictionary objectForKey:@"possesive_object"]){
                theSubject.thePossesive = [dictionary objectForKey:@"possesive_object"];
            }
            
            theSubject.thePronoun = [dictionary objectForKey:@"pronoun"];
            
            NSSet* wordSet = [NSSet setWithObjects:[dictionary objectForKey:@"word_object"], nil];
            theSubject.whatWord = wordSet;

            NSSet* subjectSet = [NSSet setWithObjects:theSentence, nil];
            theSubject.whatSentence = subjectSet;
            
        }
        else {
            theSubject = [matches lastObject];
            LOG NSLog(@"fetch match B");

        }
    }
    return theSubject;
}

@end
