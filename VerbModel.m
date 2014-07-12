//
//  VerbModel.m
//  YolarooGrammar
//
//  Created by MGM on 4/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "VerbModel.h"

@implementation VerbModel

#define DICTIONARY_NAME @"MyJSONVerbList"

#define DK 2
#define LOG if(DK == 1)

@synthesize theCompleteArray=_theCompleteArray,theCompleteDictionary=_theCompleteDictionary;

+ (VerbModel*) newVerbModel
{
    VerbModel * dataModel = [[VerbModel alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: DICTIONARY_NAME ofType:@"txt"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSError* error;
    dataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                      options:kNilOptions
                                                                        error:&error];
    
    dataModel.theCompleteArray = [dataModel.theCompleteDictionary objectForKey:@"verbs"]; //1st level count
    
    NSUInteger classArrayCount = [dataModel.theCompleteArray count];
    
    NSString*classByType;
    NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:classArrayCount];
    for(int i=0;i<classArrayCount;i++)
    {
        classByType = [[[
                    dataModel.theCompleteDictionary objectForKey:@"verbs"]
                    objectAtIndex:i]
                    objectForKey:@"type"];
        
        [temparray addObject:classByType];
    }
    dataModel.theCategoryNameList = [NSArray arrayWithArray:temparray];
        
    return dataModel;
}

@end
