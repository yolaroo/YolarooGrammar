//
//  Gender+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Gender.h"

@interface Gender (Create)

+ (Gender *) genderWithName: (NSString *) theName withContext:(NSManagedObjectContext *) context;

@end
