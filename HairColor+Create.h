//
//  HairColor+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "HairColor.h"

@interface HairColor (Create)

+ (HairColor *) hairColorWithColor: (NSString *) theColor withContext:(NSManagedObjectContext *) context;

@end
