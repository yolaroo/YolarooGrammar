//
//  Disposition+Create.h
//  YolarooGrammar
//
//  Created by MGM on 5/8/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Disposition.h"

@interface Disposition (Create)

+ (Disposition *) dispositionWithName: (NSString *) name withContext:(NSManagedObjectContext *) context;

@end
