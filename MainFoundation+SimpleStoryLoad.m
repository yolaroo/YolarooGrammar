//
//  MainFoundation+SimpleStoryLoad.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+SimpleStoryLoad.h"

@implementation MainFoundation (SimpleStoryLoad)

#define DK 2
#define LOG if(DK == 1)

- (SimpleStory*) setMyStoryForStoryLoad: (DataModel*)myModel
{
    SimpleStory* myStory = [[SimpleStory alloc] initStory:myModel];
    LOG NSLog(@"story set");
    return myStory;
}


- (DataModel*) setMyDataModelForSimpleStory
{
    DataModel* myDataModel = [DataModel newDataModel];
    LOG NSLog(@"dataSet");
    return myDataModel;
}

@end
