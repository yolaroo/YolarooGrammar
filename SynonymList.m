//
//  SynonymList.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymList.h"


@implementation SynonymList

#define DK 2
#define LOG if(DK == 1)

+ (SynonymList*) newSynonymList: (NSString*) myClassName myModel: (SynonymModel*)myModel
{
    SynonymList * myAdjectiveList = [[SynonymList alloc] init];
    
    NSInteger theClassNumber = [myModel.theSynonymNameList indexOfObject:myClassName];
    NSDictionary* classDictionary = [myModel.theCompleteArray objectAtIndex:theClassNumber];
    NSArray *wordArray = [classDictionary objectForKey:@"list"]; //2nd level count
    NSUInteger wordArrayCount = [wordArray count];
    
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:wordArrayCount];
    for(int i=0;i<wordArrayCount;i++)
    {
        SynonymWord*theAdjective = [[SynonymWord alloc]init];
        
        theAdjective.name = [[[[[
                            myModel.theCompleteDictionary objectForKey:@"adjectives"]
                            objectAtIndex:theClassNumber]
                            objectForKey:@"list"]
                            objectAtIndex:i]
                            objectForKey: @"root"];
        
        [temparray addObject:theAdjective];
        theAdjective = nil;
    }
    
    myAdjectiveList.synonymName = myClassName;
    myAdjectiveList.antonymName = [myModel.theAntonymNameList objectAtIndex:theClassNumber];
    
    myAdjectiveList.list = [NSArray arrayWithArray:temparray];
    LOG NSLog(@"%@",[temparray firstObject]);
    return myAdjectiveList;
}

@end
