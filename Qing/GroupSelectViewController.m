//
//  GroupSelectViewController.m
//  Qing
//
//  Created by cannaan on 14-1-13.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "GroupSelectViewController.h"
#import "GroupBookViewController.h"
@interface GroupSelectViewController ()

@end

@implementation GroupSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[UINavigationBar appearance] setTintColor:[UIColor grayColor]];
        // Custom initialization
    }
    return self;
}

- (IBAction)select:(UIButton *)sender {
    
    GroupBookViewController *vc = [[GroupBookViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
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

@end
