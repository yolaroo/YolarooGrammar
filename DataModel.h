//
//  DataModel.h
//  YolarooGrammar
//
//  Created by MGM on 3/1/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

+ (DataModel*) newDataModel;

@property (strong, nonatomic) NSArray* theCompleteArray;
@property (strong, nonatomic) NSDictionary* theCompleteDictionary;
@property (strong, nonatomic) NSArray* theCategoryNameList;
@property (strong, nonatomic) NSArray* theWordTypeNameList;
@property (strong, nonatomic) NSArray* theWordObjectList;

@end
