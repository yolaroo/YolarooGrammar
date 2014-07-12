//
//  Character+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Character.h"

@interface Character (Create)

+ (Character*) createCharacter: (NSArray*) dataArray withContext: (NSManagedObjectContext* ) context;

@end
