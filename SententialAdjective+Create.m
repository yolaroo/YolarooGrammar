//
//  SententialAdjective+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SententialAdjective+Create.h"
#import "AdjectiveClass.h"
#import "AdjectiveSemanticType.h"

@implementation SententialAdjective (Create)

#define DK 2
#define LOG if(DK == 1)

+ (SententialAdjective*) emptySententialAdjectiveFetch:(NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"SententialAdjective" inManagedObjectContext:newContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"theAdjective LIKE[cd] %@",@" "];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return [fetchedRecords firstObject];
}

+ (SententialAdjective*) createEmptySententialAdjective: (NSManagedObjectContext* ) context
{
    SententialAdjective*theSententialAdjective = nil;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SententialAdjective"];
    request.predicate = [NSPredicate predicateWithFormat:@"theAdjective LIKE[cd] %@",@" "];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        LOG NSLog(@"3.0 -- match error --");
    } else if (![matches count]) {
        LOG NSLog(@"3.0 -- write --");
        
        theSententialAdjective = [NSEntityDescription insertNewObjectForEntityForName:@"SententialAdjective"
                                                               inManagedObjectContext:context];
        theSententialAdjective.theAdjective = @" ";
    }
    else {
        LOG NSLog(@"3.0 -- return copy --");
        theSententialAdjective = [matches lastObject];
    }
    return theSententialAdjective;
}

+ (SententialAdjective*) createSententialAdjective: (NSString*) theString withAdjectiveClass: (AdjectiveClass*) theAdjectiveObject withContext: (NSManagedObjectContext* ) context
{
    SententialAdjective*theSententialAdjective = nil;
    LOG NSLog(@"adj string %@",theString);
    if ([theString length] && theAdjectiveObject != nil){
        LOG NSLog(@"1.0 adjective made with object --");

        theSententialAdjective = [NSEntityDescription insertNewObjectForEntityForName:@"SententialAdjective"
                                                  inManagedObjectContext:context];
        theSententialAdjective.theAdjective = theString;
        theSententialAdjective.whatMainAdjective = theAdjectiveObject;
    }
    else if ([theString length] && theAdjectiveObject == nil){
        LOG NSLog(@"2.0 adjective made with NO adjectiveObject --");

        theSententialAdjective = [NSEntityDescription insertNewObjectForEntityForName:@"SententialAdjective"
                                                               inManagedObjectContext:context];

        theSententialAdjective.theAdjective = theString;

        AdjectiveClass*newAdjective;
        newAdjective = [NSEntityDescription insertNewObjectForEntityForName:@"AdjectiveClass"
                                                     inManagedObjectContext:context];
        newAdjective.basic = theString;
        AdjectiveSemanticType*theSemanticType;
        
        NSFetchRequest *request01 = [NSFetchRequest fetchRequestWithEntityName:@"AdjectiveSemanticType"];
        request01.predicate = [NSPredicate predicateWithFormat:@"name LIKE[cd] %@",@"new"];
        NSError *errorforSematics;
        NSArray *matchesforSemantics = [context executeFetchRequest:request01 error:&errorforSematics];

        if (matchesforSemantics){
            theSemanticType = [matchesforSemantics firstObject];
        }
        else {
            theSemanticType = [NSEntityDescription insertNewObjectForEntityForName:@"AdjectiveSemanticType"
                                                         inManagedObjectContext:context];
            theSemanticType.name = @"new";
        }
        newAdjective.whatSemanticType = theSemanticType;
        theSententialAdjective.whatMainAdjective = newAdjective;
    }
    else {
        LOG NSLog(@"3.0 -- other adjective --");

        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SententialAdjective"];
        request.predicate = [NSPredicate predicateWithFormat:@"theAdjective LIKE[cd] %@",@" "];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            LOG NSLog(@"3.0 -- match error --");
        } else if (![matches count]) {
            LOG NSLog(@"3.0 -- write --");

            theSententialAdjective = [NSEntityDescription insertNewObjectForEntityForName:@"SententialAdjective"
                                                          inManagedObjectContext:context];
            theSententialAdjective.theAdjective = @" ";
        }
        else {
            LOG NSLog(@"3.0 -- return copy --");
            theSententialAdjective = [matches lastObject];
        }

    }
    //LOG (theSententialAdjective == nil)? NSLog(@"Adj+Create nil") : NSLog(@"Adj+Create NOT nil");

    return theSententialAdjective;
}

+ (SententialAdjective *) createRandomColorForSentence:(NSManagedObjectContext *) context
{
    SententialAdjective *theAdjective = nil;
    
    NSFetchRequest *firstRequest = [NSFetchRequest fetchRequestWithEntityName:@"AdjectiveClass"];
    firstRequest.predicate = [NSPredicate predicateWithFormat:@"whatSemanticType.name LIKE[cd] %@",@"color"];
    
    NSError *error;
    NSUInteger myEntityCount = [context countForFetchRequest:firstRequest error:&error];

    NSUInteger offset = myEntityCount - (arc4random() % myEntityCount);
    [firstRequest setFetchOffset:offset];
    [firstRequest setFetchLimit:1];
    NSArray *firstMatches = [context executeFetchRequest:firstRequest error:&error];
    
    AdjectiveClass*myColor = [firstMatches firstObject];
    LOG NSLog(@"%@",myColor.basic);
    
    if (myColor != nil) {
        
        NSFetchRequest *newrequest = [NSFetchRequest fetchRequestWithEntityName:@"SententialAdjective"];
        newrequest.predicate = [NSPredicate predicateWithFormat:@"whatMainAdjective = %@",myColor];
        NSError *newError;
        NSArray *newMatches = [context executeFetchRequest:newrequest error:&newError];

        if (!newMatches || ([newMatches count] > 1)) {
            // handle error
        } else if (![newMatches count]) {
            
            theAdjective = [NSEntityDescription insertNewObjectForEntityForName:@"SententialAdjective"
                                                         inManagedObjectContext:context];
            
            theAdjective.whatMainAdjective = myColor;
            theAdjective.theAdjective = myColor.basic;
        }
        else {
            theAdjective = [newMatches lastObject];
        }
        
    }
    return theAdjective;
}

@end
