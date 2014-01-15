//
//  DetailViewController.h
//  Qing
//
//  Created by cannaan on 14-1-7.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic)NSMutableArray *views;
@property (strong, nonatomic)NSMutableArray *details;

- (IBAction)book:(UIButton *)sender;
@end
