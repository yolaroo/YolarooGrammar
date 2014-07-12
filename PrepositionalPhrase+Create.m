//
//  PrepositionalPhrase+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "PrepositionalPhrase+Create.h"

@implementation PrepositionalPhrase (Create)

+ (PrepositionalPhrase*) createEmptyPrepositionalPhrase: (NSManagedObjectContext* ) context
{
    PrepositionalPhrase*thePrepositionalPhrase = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PrepositionalPhrase"];
    request.predicate = [NSPredicate predicateWithFormat:@"emptyName = %@",@"empty"];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];

    if (!matches || ([matches count] > 1)) {
    } else if (![matches count]) {
        thePrepositionalPhrase = [NSEntityDescription insertNewObjectForEntityForName:@"PrepositionalPhrase"
                                                               inManagedObjectContext:context];
        
        thePrepositionalPhrase.isAnEmptyObject = [NSNumber numberWithBool:YES];
        thePrepositionalPhrase.emptyName= @"empty";
    }
    else {
        thePrepositionalPhrase = [matches lastObject];
    }
    return thePrepositionalPhrase;
}

+ (PrepositionalPhrase*) createPrepositionalPhrase: (Sentence*) theSentence withDictionary: (NSDictionary*) dictionary withContext: (NSManagedObjectContext* ) context
{
    PrepositionalPhrase*thePrepositionalPhrase = nil;
    if (theSentence != nil) {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PrepositionalPhrase"];
        request.predicate = [NSPredicate predicateWithFormat:@"whatSentence = %@",theSentence];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        NSLog(@"perposition");
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            
            thePrepositionalPhrase = [NSEntityDescription insertNewObjectForEntityForName:@"PrepositionalPhrase"
                                                       inManagedObjectContext:context];
            

            
            if([dictionary objectForKey:@"preposition"]){
                NSLog(@"(preposition) %@",[dictionary objectForKey:@"preposition"]);

                thePrepositionalPhrase.preposition = [dictionary objectForKey:@"preposition"];
            }
            
            if([dictionary objectForKey:@"word_infinitive"]){
                thePrepositionalPhrase.preposition = [dictionary objectForKey:@"word_infinitive"];
            }
            
            if([dictionary objectForKey:@"word"]){
                NSLog(@"(word) %@",[dictionary objectForKey:@"word"]);

                thePrepositionalPhrase.theWord = [dictionary objectForKey:@"word"];
            }
            
            if([dictionary objectForKey:@"determiner"]){
                thePrepositionalPhrase.whatDeterminer = [dictionary objectForKey:@"determiner"];
            }
            
            if ([dictionary objectForKey:@"adjective"]) {
                NSSet* adjectiveSet = [NSSet setWithObjects:[dictionary objectForKey:@"adjective"], nil];
                thePrepositionalPhrase.whatAdjective = adjectiveSet;
            }
            
            if([dictionary objectForKey:@"possesive_object"]){
                thePrepositionalPhrase.thePossesive = [dictionary objectForKey:@"possesive_object"];
            }
            
            NSSet* wordSet = [NSSet setWithObjects:[dictionary objectForKey:@"word_object"], nil];
            thePrepositionalPhrase.whatWord = wordSet;
            
            NSSet* subjectSet = [NSSet setWithObjects:theSentence, nil];
            thePrepositionalPhrase.whatSentence = subjectSet;
            
        }
        else {
            thePrepositionalPhrase = [matches lastObject];
        }
    }
    return thePrepositionalPhrase;
}

@end

