//
//  VerbSemanticType+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbSemanticType.h"

@interface VerbSemanticType (Create)

+ (VerbSemanticType *) semanticTypeForGrammarWordWithName: (NSString *) name inManagedObjectContext:(NSManagedObjectContext *) context;

@end
