//
//  EyeColor+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "EyeColor.h"

@interface EyeColor (Create)

+ (EyeColor *) eyeColorWithColor: (NSString *) theColor withContext:(NSManagedObjectContext *) context;

@end
