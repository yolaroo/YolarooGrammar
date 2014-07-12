//
//  Age+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Age.h"

@interface Age (Create)

+ (Age*) ageWithNumber:(NSNumber*)age withContext:(NSManagedObjectContext *)context;
+ (Age*) ageWithString:(NSString*)age withContext:(NSManagedObjectContext *)context;

@end
