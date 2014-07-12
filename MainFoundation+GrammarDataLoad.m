//
//  MainFoundation+GrammarDataLoad.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+GrammarDataLoad.h"

#import "GrammarWordSemanticType+Create.h"
#import "GrammarWord+Create.h"

@implementation MainFoundation (GrammarDataLoad)

#define DK 2
#define LOG if(DK == 1)

#pragma mark - Data Load on View Load

#pragma mark - Data Load

- (void) grammarDataLoaderIntoNSManagedObjectContext: (NSManagedObjectContext*)context
{
    GrammarWordDataModel* myWordModel  = [self setMyGrammarDataModel];
   
    NSArray* myGrammarWordArray = myWordModel.theCategoryNameList;
    LOG NSLog(@"** LIST **");
    
    for (NSString* gmw in myGrammarWordArray){
        
        NSArray*myWordList = [self getGrammarWordList:gmw withModel: myWordModel];
        
        GrammarWordSemanticType*myType = [GrammarWordSemanticType semanticTypeForGrammarWordWithName:gmw inManagedObjectContext:context];
        
        for (NSString* wrd in myWordList) {
            [GrammarWord grammarWordWithName:wrd withSemanticType:myType inManagedObjectContext:context];
        }
    }
    [self saveData:context];
}

- (NSArray*) getGrammarWordList: (NSString*)myCategoryName withModel: (GrammarWordDataModel*)theGrammarModel
{
    NSArray* myArray;
    GrammarWordList* myWordlist = [GrammarWordList newGrammarList:myCategoryName myModel:theGrammarModel];
    myArray = myWordlist.list;
    return myArray;
}

- (GrammarWordDataModel*) setMyGrammarDataModel
{
    GrammarWordDataModel* myDataModel = [GrammarWordDataModel newGrammarDataModel];
    LOG NSLog(@"dataSet");
    return myDataModel;
}



@end
