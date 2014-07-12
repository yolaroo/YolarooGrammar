//
//  MainFoundation+AddWordDataToCoreData.m
//  YolarooGrammar
//
//  Created by MGM on 4/29/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation+AddWordDataToCoreData.h"

#import "SyntacticType+Create.h"
#import "SemanticType+Create.h"

#import "Word+Create.h"

#import "DataModel.h"
#import "WordList.h"

@implementation MainFoundation (AddWordDataToCoreData)

#define DK 2
#define LOG if(DK == 1)

-(void) loadMyWordsIntoNSManagedObjectContext: (NSManagedObjectContext*)context
{
    DataModel*myModel = [self setMyDataModelForLoad];
    NSArray*myCategoryList = myModel.theCategoryNameList;
    NSArray*wordTypeList = myModel.theWordTypeNameList;
    NSArray*wordObjectList = myModel.theWordObjectList;
    
    for (NSUInteger i=0; i < [myCategoryList count]; i++) {
        NSString*wordObject = [wordObjectList objectAtIndex:i];
        
        SemanticType* mySemanticType = [SemanticType semanticTypeWithName:[myCategoryList objectAtIndex:i] withWordObject:wordObject inManagedObjectContext:context];
        
        SyntacticType* mySyntacticType = [SyntacticType syntacticTypeWithName:[wordTypeList objectAtIndex:i] inManagedObjectContext:context];
        
        WordList* myWordlist = [WordList newList:[myCategoryList objectAtIndex:i] myModel:myModel];
        NSArray* myWordArray = myWordlist.list;
        
        
        LOG NSLog(@"(wordObject)%@",wordObject);

        for (NSString*myWord in myWordArray) {
            [Word wordWithName:myWord withSemanticType:mySemanticType withSyntacticType:mySyntacticType withWordObject: wordObject inManagedObjectContext:context];
        }
    }
    [self saveData:context];
}

- (NSArray*) getWordListForCoreData: (NSString*)myCategoryName withModel: (DataModel*)myModel
{
    LOG NSLog(@"-- WORD LIST --");
    NSArray* myArray;
    WordList* myWordlist = [WordList newList:myCategoryName myModel:myModel];
    myArray = myWordlist.list;
    return myArray;
}

- (DataModel*) setMyDataModelForLoad
{
    DataModel* myDataModel = [DataModel newDataModel];
    LOG NSLog(@"dataSet");
    return myDataModel;
}

@end
