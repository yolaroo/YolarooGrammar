//
//  WordList.m
//  YolarooGrammar
//
//  Created by MGM on 3/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "WordList.h"

@implementation WordList

#define DK 2
#define LOG if(DK == 1)

+ (WordList*) newList: (NSString*)myClassName myModel: (DataModel*)myModel
{
    WordList * myWordList = [[WordList alloc] init];
    LOG NSLog(@"wordlist: %@",myClassName);
    NSInteger theClassNumber = [myModel.theCategoryNameList indexOfObject:myClassName];
    NSDictionary* classDictionary = [myModel.theCompleteArray objectAtIndex:theClassNumber];
    NSArray *wordArray = [classDictionary objectForKey:@"list"]; //2nd level count
    NSUInteger wordArrayCount = [wordArray count];
    
    NSString*theWord;
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:wordArrayCount];
    for(int i=0;i<wordArrayCount;i++)
    {
        theWord = [[[[[
                        myModel.theCompleteDictionary objectForKey:@"dictionary"]
                        objectAtIndex:theClassNumber]
                        objectForKey:@"list"]
                        objectAtIndex:i]
                        objectForKey: @"root"];
        
        [temparray addObject:theWord];
    }
    
    myWordList.list = [NSArray arrayWithArray:temparray];
    LOG NSLog(@"%@",[temparray firstObject]);
    return myWordList;
}

@end
