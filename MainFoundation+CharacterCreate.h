//
//  MainFoundation+CharacterCreate.h
//  YolarooGrammar
//
//  Created by MGM on 4/3/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"
#import "Character+Create.h"

@interface MainFoundation (CharacterCreate)

- (Character*) writeCharacter: (NSManagedObjectContext*) context;

@end
