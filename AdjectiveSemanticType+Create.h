//
//  AdjectiveSemanticType+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/24/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdjectiveSemanticType.h"

@interface AdjectiveSemanticType (Create)

+ (AdjectiveSemanticType *) adjectiveSemanticTypeWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context;

@end
