//
//  MakeAStoryView.h
//  YolarooGrammar
//
//  Created by MGM on 5/28/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

@interface MakeAStoryView : MainFoundation  <UITextFieldDelegate>
{
    IBOutlet UITextField *speechTextField;
}

@property (weak, nonatomic) IBOutlet UITextField *speechTextField;

@end

