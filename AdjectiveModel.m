//
//  AdjectiveModel.m
//  YolarooGrammar
//
//  Created by MGM on 4/21/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "AdjectiveModel.h"

@implementation AdjectiveModel

#define DICTIONARY_NAME @"MyJSONAdjectiveList"

#define DK 2
#define LOG if(DK == 1)

@synthesize theCompleteArray=_theCompleteArray,theCompleteDictionary=_theCompleteDictionary;

+ (AdjectiveModel*) newAdjectiveModel
{
    AdjectiveModel * dataModel = [[AdjectiveModel alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: DICTIONARY_NAME ofType:@"txt"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSError* error;
    dataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                      options:kNilOptions
                                                                        error:&error];
    
    dataModel.theCompleteArray = [dataModel.theCompleteDictionary objectForKey:@"adjectives"]; //1st level count
    
    NSUInteger classArrayCount = [dataModel.theCompleteArray count];
    
    NSString*classByType;
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:classArrayCount];
    for(int i=0;i<classArrayCount;i++)
    {
        classByType = [[[
                    dataModel.theCompleteDictionary objectForKey:@"adjectives"]
                    objectAtIndex:i]
                    objectForKey:@"type"];
        
        [temparray addObject:classByType];
    }
    dataModel.theCategoryNameList = [NSArray arrayWithArray:temparray];
    
    return dataModel;
}

@end
