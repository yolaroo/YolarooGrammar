//
//  Birthday+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/6/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Birthday.h"

@interface Birthday (Create)

+ (Birthday *)birthdayWithDate: (NSDate *) theDate withDateString: (NSString*) dateString  withContext:(NSManagedObjectContext *) context;

@end
