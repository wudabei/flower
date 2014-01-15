//
//  HomepageViewController.m
//  Qing
//
//  Created by cannaan on 14-1-13.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "HomepageViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface HomepageViewController ()

@end

@implementation HomepageViewController

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
    
    LoginViewController *longin = [[LoginViewController alloc] init];
    [self presentViewController:longin animated:YES completion:^{
    }];

}

- (IBAction)scan:(UIButton *)sender {
    
    AppDelegate *delegete = [UIApplication sharedApplication].delegate;
    [delegete lonin];
   
}

- (IBAction)person:(UIButton *)sender {
    
    AppDelegate *delegete = [UIApplication sharedApplication].delegate;
    [delegete lonin];}

@end
