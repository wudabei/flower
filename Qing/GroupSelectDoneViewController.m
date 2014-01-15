//
//  GroupSelectDoneViewController.m
//  Qing
//
//  Created by cannaan on 14-1-13.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "GroupSelectDoneViewController.h"
#import "OrderViewController.h"

@interface GroupSelectDoneViewController ()

@end

@implementation GroupSelectDoneViewController

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
    for (UIView *view in [self.selectBgView subviews]) {
        if (view.tag > 0) {
            
        view.layer.cornerRadius = 58;
        view.layer.masksToBounds = YES;
    }    
}
    
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)next:(UIButton *)sender {
    
    OrderViewController *or = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:or animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
