//
//  WXFaceScrollerView.h
//  WXWeibo
//
//  Created by cannaan on 13-7-28.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;

@interface WXFaceScrollerView : UIView<UIScrollViewDelegate>



@property (strong, nonatomic) IBOutlet UIPageControl *pageController;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic)  ProductModel *productModel;
@property (strong, nonatomic) IBOutlet UILabel *description;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollVIEW;

@property (nonatomic,strong)NSArray *images;
@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *details;
@property (strong, nonatomic) IBOutlet UILabel *typy;

- (id)initWithFrame:(CGRect)frame views:(NSArray *)views isCust:(BOOL)custom;

@end
