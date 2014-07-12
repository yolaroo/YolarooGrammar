//
//  SynonymWordClass+Create.h
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymWordClass.h"

@interface SynonymWordClass (Create)


+ (SynonymWordClass *) synonymWordWithName: (NSString *) name withContext:(NSManagedObjectContext *) context;

@end
