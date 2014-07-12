//
//  Goal+Create.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Goal.h"
#import "Word.h"
#import "GoalMaker.h"

@interface Goal (Create)

+ (Goal *) goalWithName:(NSString *)name withContext:(NSManagedObjectContext *)context;

+ (Goal *) goalWithNameandInfinitive:(NSString *)name withInfinitive: (NSString*)infinitive withContext:(NSManagedObjectContext *)context;

+ (Goal *) goalWithNameandInfinitiveForGoalMaker:(GoalMaker*)myGoal withContext:(NSManagedObjectContext *)context;


@end
