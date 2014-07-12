//
//  GrammarWordDataModel.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "GrammarWordDataModel.h"

@implementation GrammarWordDataModel

@synthesize theCompleteArray=_theCompleteArray,theCompleteDictionary=_theCompleteDictionary,theCategoryNameList=_theCategoryNameList,theWordTypeNameList=_theWordTypeNameList;

#define DICTIONARY_NAME @"grammardata"

#define DK 2
#define LOG if(DK == 1)

+ (GrammarWordDataModel*) newGrammarDataModel
{
    GrammarWordDataModel * dataModel = [[GrammarWordDataModel alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: DICTIONARY_NAME ofType:@"txt"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSError* error;
    dataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                      options:kNilOptions
                                                                        error:&error];
    
    dataModel.theCompleteArray = [dataModel.theCompleteDictionary objectForKey:@"dictionary"]; //1st level count
    
    NSUInteger classArrayCount = [dataModel.theCompleteArray count];
    
    NSString*classByType;
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:classArrayCount];
    for(int i=0;i<classArrayCount;i++)
    {
        classByType = [[[
                    dataModel.theCompleteDictionary objectForKey:@"dictionary"]
                    objectAtIndex:i]
                    objectForKey:@"type"];
        [temparray addObject:classByType];
    }
    dataModel.theCategoryNameList = [NSArray arrayWithArray:temparray];
    
    NSString*sytnaxByType;
    NSMutableArray *tempSyntaxArray = [NSMutableArray arrayWithCapacity:classArrayCount];
    for(int i=0;i<classArrayCount;i++)
    {
        sytnaxByType = [[[
                    dataModel.theCompleteDictionary objectForKey:@"dictionary"]
                    objectAtIndex:i]
                    objectForKey:@"wordtype"];
        [tempSyntaxArray addObject:sytnaxByType];
    }
    dataModel.theWordTypeNameList = [NSArray arrayWithArray:tempSyntaxArray];
    
    return dataModel;
}

@end
