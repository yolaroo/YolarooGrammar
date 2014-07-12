//
//  VerbModel.h
//  YolarooGrammar
//
//  Created by MGM on 4/11/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerbModel : NSObject

+ (VerbModel*) newVerbModel;

@property (strong, nonatomic) NSArray* theCompleteArray;
@property (strong, nonatomic) NSDictionary* theCompleteDictionary;
@property (strong, nonatomic) NSArray* theCategoryNameList;

@end
