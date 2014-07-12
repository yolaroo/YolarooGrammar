//
//  UnderMenu.h
//  YolarooGrammar
//
//  Created by MGM on 5/26/14.
//  Copyright (c) 2014 Yolaroo. All rights reserved.
//

#import "MainFoundation.h"

#import "ECSlidingViewController.h"

@interface UnderMenu : MainFoundation <UITextFieldDelegate>
{
    IBOutlet UITextField *speechTextField;
}

@property (weak, nonatomic) IBOutlet UITextField *speechTextField;

@end
