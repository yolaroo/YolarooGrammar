//
//  SemanticType+Create.h
//  YolarooGrammar
//
//  Created by MGM on 3/31/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SemanticType.h"

@interface SemanticType (Create)

+ (SemanticType *) semanticTypeWithName: (NSString *) name withWordObject: (NSString*) wordObject inManagedObjectContext:(NSManagedObjectContext *) context;

@end
