//
//  Location+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Location.h"

@interface Location (Create)

+ (Location *)locationWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

@end
