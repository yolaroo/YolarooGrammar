//
//  Weight+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Weight.h"

@interface Weight (Create)

+ (Weight *) weightWithNumber: (NSNumber *) theNumber withContext:(NSManagedObjectContext *) context;
+ (Weight *) weightWithString: (NSString *) theNumber withContext:(NSManagedObjectContext *) context;

@end
