//
//  LoginViewController.m
//  Qing
//
//  Created by cannaan on 14-1-13.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        AppDelegate *delegete = [UIApplication sharedApplication].delegate;
        [delegete lonin];
    }];
}
- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
