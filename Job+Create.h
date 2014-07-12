//
//  Job+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Job.h"

@interface Job (Create)

+ (Job *) jobWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

@end
