//
//  MainViewController.h
//  Qing
//
//  Created by cannaan on 14-1-8.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVTableView.h"

@interface MainViewController : UIViewController<HVTableViewDelegate, HVTableViewDataSource>
{
	HVTableView* myTable;
	NSArray* cellTitles;
}

@property (nonatomic,strong)NSMutableArray *products;

@end
