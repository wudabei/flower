//
//  RightViewController.m
//  Qing
//
//  Created by cannaan on 14-1-8.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

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
- (IBAction)test:(UIButton *)sender {
    NSLog(@"right tapped");
    [self.drawerController toggleDrawerSide:XHDrawerSideRight animated:YES completion:NULL];
}

@end
