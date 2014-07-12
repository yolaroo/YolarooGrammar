//
//  Specie+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Specie.h"

@interface Specie (Create)

+ (Specie *)specieWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

@end
