//
//  ContentView.h
//  QingDemo
//
//  Created by cannaan on 14-1-7.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;
@interface ContentView : UIView

@property (nonatomic)ProductModel *productModel;

@property (strong, nonatomic) IBOutlet UIImageView *productPic;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@property (strong, nonatomic) IBOutlet UILabel *productDesc;

@end
