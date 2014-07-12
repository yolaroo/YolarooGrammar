//
//  ComparisonObject+Create.h
//  YolarooGrammar
//
//  Created by MGM on 5/9/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "ComparisonObject.h"

@interface ComparisonObject (Create)

+ (ComparisonObject *) comparisonWithName: (NSString *) name withContext:(NSManagedObjectContext *) context;


@end
