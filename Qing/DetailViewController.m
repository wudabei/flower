//
//  DetailViewController.m
//  Qing
//
//  Created by cannaan on 14-1-7.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
//    self.views = [NSMutableArray arrayWithCapacity:8];
//    for (int i = ; i < 9; i++) {
//        
//        DetailView *view = [[DetailView alloc]initWithFrame:self.view.bounds];
//        view.pic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
//        [self.views addObject:view];
//    }
//   
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)book:(UIButton *)sender {
    
    
}
@end
