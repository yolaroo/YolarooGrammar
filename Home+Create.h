//
//  Home+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/5/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Home.h"
#import "Word.h"

@interface Home (Create)

+ (Home *)homeWithString: (NSString *) myWord withContext:(NSManagedObjectContext *) context;

@end
