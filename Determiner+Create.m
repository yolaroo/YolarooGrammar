//
//  Determiner+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Determiner+Create.h"

@implementation Determiner (Create)

#define DK 2
#define LOG if(DK == 1)

+ (Determiner*) emptyDeterminerFetch:(NSManagedObjectContext*) newContext
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Determiner" inManagedObjectContext:newContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"theDeterminer = %@",@" "];
    
    NSError* error;
    NSArray *fetchedRecords = [newContext executeFetchRequest:fetchRequest error:&error];
    
    return [fetchedRecords firstObject];
}

+ (Determiner*) createEmptyDeterminer: (NSManagedObjectContext* ) context {
    
    Determiner* theDeterminer = nil;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Determiner"];
    request.predicate = [NSPredicate predicateWithFormat:@"theDeterminer = %@",@" "];
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
    } else if (![matches count]) {
        LOG NSLog(@"** empty determiner made **");
        
        theDeterminer = [NSEntityDescription insertNewObjectForEntityForName:@"Determiner"
                                                      inManagedObjectContext:context];
        theDeterminer.theDeterminer = @" ";
        
    }
    else {
        LOG NSLog(@"** returned empty determiner **");
        
        theDeterminer = [matches lastObject];
    }
    return theDeterminer;
}

+ (Determiner*) createDeterminer: (NSString*) theString withContext: (NSManagedObjectContext* ) context
{
    Determiner* theDeterminer = nil;

    if ([theString length]){
        NSFetchRequest *firstRequest = [NSFetchRequest fetchRequestWithEntityName:@"Determiner"];
        firstRequest.predicate = [NSPredicate predicateWithFormat:@"theDeterminer = %@",theString];
        NSError *firstError;
        NSArray *firstMatches = [context executeFetchRequest:firstRequest error:&firstError];
        if (!firstMatches || ([firstMatches count] > 1)) {
            LOG NSLog(@"-- determiner error on match --");
            
        } else if (![firstMatches count]) {
            theDeterminer = [NSEntityDescription insertNewObjectForEntityForName:@"Determiner"
                                                          inManagedObjectContext:context];
            theDeterminer.theDeterminer = theString;
            LOG NSLog(@"-- (wrote) %@ --",theString);
        }
        else {
            LOG NSLog(@"-- (returned) %@ --",theString);
            theDeterminer = [firstMatches lastObject];
        }
    }
    else {
        LOG NSLog(@"Det+Create - empty");
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Determiner"];
        request.predicate = [NSPredicate predicateWithFormat:@"theDeterminer = %@",@" "];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
        } else if (![matches count]) {
            LOG NSLog(@"** empty determiner made **");

            theDeterminer = [NSEntityDescription insertNewObjectForEntityForName:@"Determiner"
                                                          inManagedObjectContext:context];
            theDeterminer.theDeterminer = @" ";
            
        }
        else {
            LOG NSLog(@"** returned empty determiner **");

            theDeterminer = [matches lastObject];
        }
    }
    LOG (theDeterminer == nil) ? NSLog(@"Det+Creete nil") :  NSLog(@"Det+Create NOT nil");
    return theDeterminer;
}

@end
