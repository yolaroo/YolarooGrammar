//
//  SynonymObjectClass+Create.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymObjectClass.h"

@interface SynonymObjectClass (Create)

+ (SynonymObjectClass *) synonymClassWithName: (NSString *) name withAntonym: (NSString *) antonym withContext:(NSManagedObjectContext *) context;

@end
