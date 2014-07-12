//
//  DataModel.m
//  YolarooGrammar
//
//  Created by MGM on 3/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

@synthesize theCompleteArray=_theCompleteArray,theCompleteDictionary=_theCompleteDictionary,theCategoryNameList=_theCategoryNameList,theWordTypeNameList=_theWordTypeNameList,theWordObjectList=_theWordObjectList;

#define DICTIONARY_NAME @"dictionarydata"

#define DK 2
#define LOG if(DK == 1)

+ (DataModel*) newDataModel
{
    DataModel * dataModel = [[DataModel alloc] init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource: DICTIONARY_NAME ofType:@"txt"];
        NSData *myData = [NSData dataWithContentsOfFile:filePath];
        
        NSError* error;
        dataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                     options:kNilOptions
                                                                       error:&error];

        dataModel.theCompleteArray = [dataModel.theCompleteDictionary objectForKey:@"dictionary"]; //1st level count
        
        NSUInteger classArrayCount = [dataModel.theCompleteArray count];
    
        NSString*wordObjectByType;
        NSMutableArray *tempWordObjectArray = [NSMutableArray arrayWithCapacity:classArrayCount];
        for(int i=0;i<classArrayCount;i++)
        {
            wordObjectByType = [[[
                                dataModel.theCompleteDictionary objectForKey:@"dictionary"]
                                objectAtIndex:i]
                                objectForKey:@"objectname"];
            [tempWordObjectArray addObject:wordObjectByType];
        }
        dataModel.theWordObjectList = [NSArray arrayWithArray:tempWordObjectArray];

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
