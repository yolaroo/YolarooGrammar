//
//  Height+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Height.h"

@interface Height (Create)

+ (Height *) heightWithNumber: (NSNumber *) theNumber withContext:(NSManagedObjectContext *) context;

+ (Height *) heightWithString: (NSString *) theNumber withContext:(NSManagedObjectContext *) context;

@end
