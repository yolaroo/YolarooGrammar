//
//  SyntacticType+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SyntacticType.h"

@interface SyntacticType (Create)

+ (SyntacticType *) syntacticTypeWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context;

@end
