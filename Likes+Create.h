//
//  Interests+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Likes.h"
#import "Word.h"

@interface Likes (Create)

+ (Likes *)likesWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

+ (Likes *)likesWithWordObject:(Word *)myWord withContext:(NSManagedObjectContext *)context;

@end
