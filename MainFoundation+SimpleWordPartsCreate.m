//
//  MainFoundation+SimpleWordPartsCreate.m
//  YolarooGrammar
//
//  Created by MGM on 4/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SimpleWordPartsCreate.h"

#import "SententialAdjective+Create.h"

@implementation MainFoundation (SimpleWordPartsCreate)

#define DK 2
#define LOG if(DK == 1)

- (NSString*)newAdjForSimpleWordPart : (NSManagedObjectContext*) context
{
    SententialAdjective*mine = [SententialAdjective createRandomColorForSentence:context];
    LOG NSLog(@"-- color: %@ -- ",mine.theAdjective);
    return mine.theAdjective;
}

@end
