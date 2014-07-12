//
//  MainFoundation+EventOptionsDataForCharacter.h
//  YolarooGrammar
//
//  Created by MGM on 5/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MainFoundation (EventOptionsDataForCharacter)

- (Event*) myEventReturn: (EventDefine)value withTitle: (NSString*)title withContext: (NSManagedObjectContext*) context;

- (EventDefine) returnRandomEvent;

@end
