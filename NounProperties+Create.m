//
//  NounProperties+Create.m
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "NounProperties+Create.h"

@implementation NounProperties (Create)

+ (NounProperties*) createNounPropertiesForSubject: (SubjectPhrase*) subject withDictionary: (NSDictionary*)dictionary withContext: (NSManagedObjectContext* ) context
{
    NounProperties*theNounProperties = nil;

    if (subject != nil){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NounProperties"];
        request.predicate = [NSPredicate predicateWithFormat:@"whatSubject = %@", subject];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];

        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theNounProperties = [NSEntityDescription insertNewObjectForEntityForName:@"NounProperties"
                                                              inManagedObjectContext:context];
            
            theNounProperties.isPlural = [dictionary objectForKey:@"isPlural"];
            theNounProperties.hasAdjective = [dictionary objectForKey:@"hasAdjective"];
            theNounProperties.hasPossesive = [dictionary objectForKey:@"hasPossesive"];
            theNounProperties.hasPronoun = [dictionary objectForKey:@"hasPronoun"];
            theNounProperties.isDate = [dictionary objectForKey:@"subjectIsDate"];
            theNounProperties.isLocation = [dictionary objectForKey:@"subjectIsLocation"];
            theNounProperties.isTime = [dictionary objectForKey:@"subjectIsTime"];
            theNounProperties.hasSuffix = [dictionary objectForKey:@"subjectHasSuffix"];

            if ([[dictionary objectForKey:@"subjectIsDate"] boolValue]) {
                theNounProperties.semanticType = @"time";
            }
            
        }
        else {
            theNounProperties = [matches lastObject];
        }
    }
    return theNounProperties;
}

+ (NounProperties*) createNounPropertiesForObject: (ObjectPhrase*) object withDictionary: (NSDictionary*)dictionary withContext: (NSManagedObjectContext* ) context
{
    NounProperties*theNounProperties = nil;
    
    if (object != nil){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NounProperties"];
        request.predicate = [NSPredicate predicateWithFormat:@"whatObject = %@", object];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theNounProperties = [NSEntityDescription insertNewObjectForEntityForName:@"NounProperties"
                                                              inManagedObjectContext:context];
            
            theNounProperties.isPlural = [dictionary objectForKey:@"isPlural"];
            theNounProperties.hasAdjective = [dictionary objectForKey:@"hasAdjective"];
            theNounProperties.hasPossesive = [dictionary objectForKey:@"isPlural"];
            theNounProperties.hasPronoun = [dictionary objectForKey:@"hasPronoun"];
            theNounProperties.isGeneralization = [dictionary objectForKey:@"isGeneralization"];
            theNounProperties.isDate = [dictionary objectForKey:@"objectIsDate"];
            theNounProperties.isLocation = [dictionary objectForKey:@"objectIsLocation"];
            theNounProperties.isTime = [dictionary objectForKey:@"objectIsTime"];
            theNounProperties.hasSuffix = [dictionary objectForKey:@"objectHasSuffix"];
            
            if ([[dictionary objectForKey:@"objectIsDate"] boolValue]) {
                theNounProperties.semanticType = @"time";
            }
            
        }
        else {
            theNounProperties = [matches lastObject];
        }
    }
    return theNounProperties;
}

+ (NounProperties*) createNounPropertiesForPreposition: (PrepositionalPhrase*) preposition withDictionary: (NSDictionary*)dictionary withContext: (NSManagedObjectContext* ) context
{
    NounProperties*theNounProperties = nil;
    
    if (preposition != nil){
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NounProperties"];
        request.predicate = [NSPredicate predicateWithFormat:@"whatPreposition = %@", preposition];
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            
            theNounProperties = [NSEntityDescription insertNewObjectForEntityForName:@"NounProperties"
                                                              inManagedObjectContext:context];
            
            theNounProperties.isPlural = [dictionary objectForKey:@"isPlural"];
            theNounProperties.hasAdjective = [dictionary objectForKey:@"hasAdjective"];
            theNounProperties.hasPossesive = [dictionary objectForKey:@"isPlural"];
            theNounProperties.hasPronoun = [dictionary objectForKey:@"hasPronoun"];
            theNounProperties.isDate = [dictionary objectForKey:@"prepositionIsDate"];
            theNounProperties.isLocation = [dictionary objectForKey:@"prepositionIsLocation"];
            theNounProperties.isTime = [dictionary objectForKey:@"prepositionIsTime"];
            theNounProperties.hasSuffix = [dictionary objectForKey:@"prepositionHasSuffix"];

            if ([[dictionary objectForKey:@"prepositionIsDate"] boolValue]) {
                theNounProperties.semanticType = @"time";
            }
            
            if ([[dictionary objectForKey:@"prepositionIsTime"] boolValue]) {
                theNounProperties.semanticType = @"time";
            }
            
            if ([[dictionary objectForKey:@"prepositionIsLocation"] boolValue]) {
                theNounProperties.semanticType = @"location";
            }
            
        }
        else {
            theNounProperties = [matches lastObject];
        }
    }
    return theNounProperties;
}
@end
