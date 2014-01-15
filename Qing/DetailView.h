//
//  DetailView.h
//  Qing
//
//  Created by cannaan on 14-1-8.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;


@interface DetailView : UIView

@property (strong, nonatomic)  ProductModel *productModel;

@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UILabel *description;

@property (strong, nonatomic) IBOutlet UILabel *details;
//@property (strong, nonatomic) IBOutlet UIImageView *shadowImg;

@property (strong, nonatomic) IBOutlet UILabel *productName;
//@property (strong, nonatomic) IBOutlet UIView *scrollViewItem;

@property (strong, nonatomic) IBOutlet UILabel *rmb;

@property (strong, nonatomic) IBOutlet UIView *productLayout;

//@property (strong, nonatomic) IBOutlet UIImageView *picView;

@end
