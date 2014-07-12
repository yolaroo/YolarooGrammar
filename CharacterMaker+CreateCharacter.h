//
//  CharacterMaker+CreateCharacter.h
//  YolarooGrammar
//
//  Created by MGM on 5/30/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "CharacterMaker.h"

@interface CharacterMaker (CreateCharacter)

- (Character*) writeAdvancedCharacterForMaker: (CharacterMaker*)theCharacter withContext: (NSManagedObjectContext*) context;


@end
