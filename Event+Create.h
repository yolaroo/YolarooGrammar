//
//  Event+Create.h
//  YolarooGrammar
//
//  Created by MGM on 5/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "Event.h"

#import "EventMaker.h"
@class EventMaker;

@interface Event (Create)

+ (Event *) eventWithTitle:(NSString *)title withArray: (NSArray*)eventArray withContext:(NSManagedObjectContext *)context;

+ (Event *) eventWithEventMaker:(EventMaker*)myEvent withContext:(NSManagedObjectContext *)context;


@end
