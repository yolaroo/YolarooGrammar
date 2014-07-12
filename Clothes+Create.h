//
//  Clothes+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Clothes.h"
#import "Word.h"

@interface Clothes (Create)

+ (Clothes *) clothesWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

+ (Clothes *) clothesWithWordObject: (Word *)myWord withContext:(NSManagedObjectContext *)context;

@end
