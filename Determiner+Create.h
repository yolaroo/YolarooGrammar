//
//  Determiner+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Determiner.h"

@interface Determiner (Create)

+ (Determiner*) createDeterminer: (NSString*) theString withContext: (NSManagedObjectContext* ) context;

+ (Determiner*) createEmptyDeterminer: (NSManagedObjectContext* ) context;

+ (Determiner*) emptyDeterminerFetch:(NSManagedObjectContext*) newContext;


@end
