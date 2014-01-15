//
//  DetailViewsController.m
//  Qing
//
//  Created by cannaan on 14-1-9.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "DetailViewsController.h"
#import "DetailView.h"
#import "WXFaceScrollerView.h"
#import "AppDelegate.h"
#import "GroupSelectViewController.h"


@interface DetailViewsController ()

@end

@implementation DetailViewsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        AppDelegate *delegete = [UIApplication sharedApplication].delegate;
        NSLog(@"delegete frame %f",delegete.window.height);
        
        if (delegete.window.height == 480) {
            self.view.height = delegete.window.height;
        }else {
            self.view.height = delegete.window.height;
        }
        
        
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    AppDelegate *delegete = [UIApplication sharedApplication].delegate;
    NSLog(@"delegete frame %f",delegete.window.height);

    if (delegete.window.height == 480) {
        self.view.height = delegete.window.height;
    }else {
        self.view.height = delegete.window.height;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        self.views = [NSMutableArray arrayWithCapacity:8];
    
    
        for (int i = 3; i < 9; i++) {
    
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
            [self.views addObject:image];
        }
    
   
    NSLog(@"self.view frame %f",self.view.height);
    WXFaceScrollerView *view =  [[WXFaceScrollerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) views:self.views isCust:NO];
    
    NSLog(@"WXFaceScrollerView frame %f",view.height);

    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"book.png"] forState:UIControlStateNormal];
    
    [btn setFrame:CGRectMake(320/2 - 222/2, 800 - 100, 222, 86)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(book) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)book {
    NSLog(@"book touched");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
