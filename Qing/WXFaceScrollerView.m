//
//  WXFaceScrollerView.m
//  WXWeibo
//
//  Created by cannaan on 13-7-28.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "WXFaceScrollerView.h"
#import "ProductModel.h"

#define heightDetails 168
@implementation WXFaceScrollerView

- (id)initWithFrame:(CGRect)frame views:(NSArray *)views isCust:(BOOL)custom
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = nil;
        
        if (!custom) {
            
            view = [[[NSBundle mainBundle] loadNibNamed:@"WXFaceScrollerView" owner:self options:nil] lastObject];

        }else {
            
            view = [[[NSBundle mainBundle] loadNibNamed:@"WXFaceScrollerViewCus" owner:self options:nil] lastObject];
        }
        
        [self addSubview:view];
        
        
        self.images = views;
        [self initViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)initViews {
    

//    scrollerView.height = self.height - heightDetails ;
    self.scrollVIEW.contentSize = CGSizeMake(self.frame.size.width * self.images.count, 0);
    self.scrollVIEW.pagingEnabled = YES;
    self.scrollVIEW.showsHorizontalScrollIndicator = NO;//禁止滚动条
    self.scrollVIEW.clipsToBounds = YES;//超出视图的部分是否被裁减
    self.scrollVIEW.showsVerticalScrollIndicator = NO;
    self.scrollVIEW.delegate = self;//监听偏移量
    self.scrollVIEW.alwaysBounceVertical = NO;
    self.scrollVIEW.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow.png"]];
    shadow.frame = CGRectMake(0, 0, 320, 88);
    shadow.bottom = self.scrollVIEW.bottom;
    for (int i = 0; i < self.images.count; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.scrollVIEW.width * i, 0, self.scrollVIEW.width, self.scrollVIEW.height )];
        NSLog(@"%f",self.scrollVIEW.height);
        NSLog(@"%f",[self viewWithTag:12].height);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[i]];
        imageView.frame = CGRectMake(0, 0, self.scrollVIEW.width, self.scrollVIEW.height );
        view.clipsToBounds = YES;
        [view addSubview:imageView];
//        [self.scrollVIEW addSubview:imageView];
        [self.scrollVIEW addSubview:view];

        [self.scrollVIEW addSubview:shadow];
    }
    
    self.pageController.numberOfPages = self.images.count;
    self.pageController.currentPage = 0;
    self.pageController.pageIndicatorTintColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1.0];
    self.pageController.currentPageIndicatorTintColor = [UIColor greenColor];


}
// get scrollView offset
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    int pageNumber = _scrollView.contentOffset.x/320;
    self.pageController.currentPage = pageNumber;
    
    if (pageNumber % 2 == 0) {
        
        self.price.text = @"500";
        self.description.text = @"描述1";
        self.details.text = @"详情1";
        self.name.text = @"名字1";
      
    }else {
        
        self.price.text = @"100";
        self.description.text = @"描述2222";
        self.details.text = @"详情111";
        self.name.text = @"名字1111";
    }
}
@end
