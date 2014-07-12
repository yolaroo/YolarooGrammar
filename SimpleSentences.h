//
//  SimpleSentences.h
//  YolarooGrammar
//
//  Created by MGM on 2/25/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

#import "Animal.h"
#import "StorySentence.h"

#import "SimpleStory.h"
@class Animal;
@class Sentence;
@class MetaSentence;
@class Story;

#import "DataModel.h"
#import "WordList.h"
@class DataModel;
@class WordList;

#import "VerbModel.h"
#import "VerbWordData.h"
#import "VerbList.h"
@class VerbModel;
@class VerbList;
@class VerbWordData;

@interface SimpleSentences : MainFoundation

@property (strong, nonatomic) NSArray* theStoryArray;
@property (strong, nonatomic) Animal * myAnimal;
@property (strong, nonatomic) StorySentence * mySentence;
@property (strong, nonatomic) DataModel * DataModel;
@property (strong, nonatomic) WordList * myWordList;
@property (strong, nonatomic) SimpleStory * myStory;

@property (strong, nonatomic) NSArray* theCategoryNameList;
@property (strong, nonatomic) NSArray* theFinalStoryArray;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end
