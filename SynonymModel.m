//
//  SynonymModel.m
//  YolarooGrammar
//
//  Created by MGM on 5/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "SynonymModel.h"

@implementation SynonymModel

@synthesize theSynonymNameList=_theSynonymNameList,theAntonymNameList=_theAntonymNameList,theCompleteArray=_theCompleteArray,theCompleteDictionary=_theCompleteDictionary;

#define DICTIONARY_NAME @"SynonymData"

#define DK 2
#define LOG if(DK == 1)

+ (SynonymModel*) newSynonymModel
{
    SynonymModel * dataModel = [[SynonymModel alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: DICTIONARY_NAME ofType:@"txt"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    NSError* error;
    dataModel.theCompleteDictionary = [NSJSONSerialization JSONObjectWithData:myData
                                                                      options:kNilOptions
                                                                        error:&error];
    
    dataModel.theCompleteArray = [dataModel.theCompleteDictionary objectForKey:@"adjectives"]; //1st level count
    
    NSUInteger classArrayCount = [dataModel.theCompleteArray count];
    
    //
    
    NSMutableArray *antonymArray = [NSMutableArray arrayWithCapacity:classArrayCount];
    for(int i=0;i<classArrayCount;i++)
    {
        NSString*antonymByType;
        antonymByType = [[[
                        dataModel.theCompleteDictionary objectForKey:@"adjectives"]
                        objectAtIndex:i]
                        objectForKey:@"antonym"];
        
        [antonymArray addObject:antonymByType];
    }
    dataModel.theAntonymNameList = [NSArray arrayWithArray:antonymArray];

    //
    
    NSMutableArray *synonymArray = [NSMutableArray arrayWithCapacity:classArrayCount];
    for(int i=0;i<classArrayCount;i++)
    {
        NSString*synonymByType;
        synonymByType = [[[
                        dataModel.theCompleteDictionary objectForKey:@"adjectives"]
                        objectAtIndex:i]
                        objectForKey:@"synonym"];
        
        [synonymArray addObject:synonymByType];
    }
    dataModel.theSynonymNameList = [NSArray arrayWithArray:synonymArray];
    
    return dataModel;
}


@end
