//
//  Interests+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Dislikes.h"
#import "Word.h"

@interface Dislikes (Create)

+ (Dislikes *) dislikesWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

+ (Dislikes *) dislikesWithWordObject:(Word *)myWord withContext:(NSManagedObjectContext *)context;

@end
