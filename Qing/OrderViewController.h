//
//  OrderViewController.h
//  Qing
//
//  Created by cannaan on 14-1-13.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCCalendarViewController.h"

@interface OrderViewController : UIViewController<UIGestureRecognizerDelegate, OCCalendarDelegate,UITextFieldDelegate> {
    OCCalendarViewController *calVC;
    
    UILabel *toolTipLabel;
}
- (IBAction)TextFieldresign:(UIControl *)sender;
@property (strong, nonatomic) IBOutlet UILabel *resvieverTel;
@property (strong, nonatomic) IBOutlet UILabel *resvierName;
@property (strong, nonatomic) IBOutlet UILabel *ariveDate;
@property (strong, nonatomic) IBOutlet UILabel *reseverAdd;

@property (strong, nonatomic) IBOutlet UITextField *name;

@property (strong, nonatomic) IBOutlet UITextField *tel;
@property (strong, nonatomic) IBOutlet UITextField *add;
@property (strong, nonatomic) IBOutlet UIButton *changeDate;

- (IBAction)dateSelect:(UIButton *)sender;


@end
