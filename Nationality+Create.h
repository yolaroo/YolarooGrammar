//
//  Nationality+Create.h
//  YolarooGrammar
//
//  Created by MGM on 5/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Nationality.h"

@interface Nationality (Create)

+ (Nationality *) nationalityWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

@end
