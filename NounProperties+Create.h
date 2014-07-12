//
//  NounProperties+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/4/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "NounProperties.h"

@interface NounProperties (Create)

+ (NounProperties*) createNounPropertiesForSubject: (SubjectPhrase*) subject withDictionary: (NSDictionary*)dictionary withContext: (NSManagedObjectContext* ) context;

+ (NounProperties*) createNounPropertiesForObject: (ObjectPhrase*) object withDictionary: (NSDictionary*)dictionary withContext: (NSManagedObjectContext* ) context;

+ (NounProperties*) createNounPropertiesForPreposition: (PrepositionalPhrase*) preposition withDictionary: (NSDictionary*)dictionary withContext: (NSManagedObjectContext* ) context;

@end
