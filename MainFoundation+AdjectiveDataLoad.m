//
//  MainFoundation+AdjectiveDataLoad.m
//  YolarooGrammar
//
//  Created by MGM on 4/24/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+AdjectiveDataLoad.h"

#import "AdjectiveModel.h"
#import "AdjectiveList.h"

#import "AdjectiveClass+Create.h"
#import "AdjectiveSemanticType+Create.h"

@implementation MainFoundation (AdjectiveDataLoad)

#define DK 2
#define LOG if(DK == 1)

#pragma mark - Data Load

- (void) adjectiveDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*) context
{
    AdjectiveModel* myAdjectiveModel  = [self setMyAdjectiveModel];
    LOG NSLog(@"** MODEL **");
    NSArray* myAdjectiveClassArray = myAdjectiveModel.theCategoryNameList;
    LOG NSLog(@"** LIST **");

    for (NSString* ACA in myAdjectiveClassArray){

        NSArray*myAdjectiveList = [self getAdjectiveList:ACA withModel: myAdjectiveModel];
    
        AdjectiveSemanticType*mytype = [AdjectiveSemanticType adjectiveSemanticTypeWithName: ACA inManagedObjectContext:context];
    
        for (AdjectiveWordData* AWD in myAdjectiveList) {
            [AdjectiveClass adjectiveWithName:AWD withSemanticType: mytype inManagedObjectContext:context];
        }
        
        LOG NSLog(@"** Set of Adjectives Words Made **");

    }
    LOG NSLog(@"** Completed **");
    [self saveData:context];
}

- (NSArray*) getAdjectiveList:(NSString*)theType withModel: (AdjectiveModel*)theAdjectiveModel {
    NSArray* myArray;
    AdjectiveList* myVerbList = [AdjectiveList newList:theType myModel:theAdjectiveModel];
    LOG NSLog(@"-- Adjective List Getter: %@ --",myVerbList);
    
    myArray = myVerbList.list;
    return myArray;
}

- (AdjectiveModel*) setMyAdjectiveModel {
    AdjectiveModel* myDataModel = [AdjectiveModel newAdjectiveModel];
    LOG NSLog(@"Adjective Data Set - %@", myDataModel.theCompleteArray);
    return myDataModel;
}

@end
