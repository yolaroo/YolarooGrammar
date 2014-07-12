//
//  AdjectiveList.m
//  YolarooGrammar
//
//  Created by MGM on 4/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdjectiveList.h"
#import "AdjectiveWordData.h"

@implementation AdjectiveList

#define DK 2
#define LOG if(DK == 1)

+ (AdjectiveList*) newList: (NSString*) myClassName myModel: (AdjectiveModel*)myModel
{
    AdjectiveList * myAdjectiveList = [[AdjectiveList alloc] init];

    NSInteger theClassNumber = [myModel.theCategoryNameList indexOfObject:myClassName];
    NSDictionary* classDictionary = [myModel.theCompleteArray objectAtIndex:theClassNumber];
    NSArray *wordArray = [classDictionary objectForKey:@"list"]; //2nd level count
    NSUInteger wordArrayCount = [wordArray count];
    
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:wordArrayCount];
    for(int i=0;i<wordArrayCount;i++)
    {
        AdjectiveWordData*theAdjective = [[AdjectiveWordData alloc]init];
        
        theAdjective.basic = [[[[[
                    myModel.theCompleteDictionary objectForKey:@"adjectives"]
                    objectAtIndex:theClassNumber]
                    objectForKey:@"list"]
                    objectAtIndex:i]
                    objectForKey: @"root"];
        
        theAdjective.comparative = [[[[[[[
                    myModel.theCompleteDictionary objectForKey:@"adjectives"]
                    objectAtIndex:theClassNumber]
                    objectForKey:@"list"]
                    objectAtIndex:i]
                    objectForKey: @"forms"]
                    objectAtIndex:0]
                    objectForKey:@"comparative"];
        
        theAdjective.superlative = [[[[[[[
                    myModel.theCompleteDictionary objectForKey:@"adjectives"]
                    objectAtIndex:theClassNumber]
                    objectForKey:@"list"]
                    objectAtIndex:i]
                    objectForKey: @"forms"]
                    objectAtIndex:0]
                    objectForKey:@"superlative"];
        
        theAdjective.semanticType = myClassName;
        
        [temparray addObject:theAdjective];
        theAdjective = nil;
    }
    
    myAdjectiveList.list = [NSArray arrayWithArray:temparray];
    LOG NSLog(@"%@",[temparray firstObject]);
    return myAdjectiveList;
}

@end
