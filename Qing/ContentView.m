//
//  ContentView.m
//  QingDemo
//
//  Created by cannaan on 14-1-7.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "ContentView.h"
#import "ProductModel.h"

@implementation ContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        /*
        UIImageView *view = [[UIImageView alloc] initWithFrame:self.bounds];
        view.image = [UIImage imageNamed:@"3.jpg"];
        
        view.clipsToBounds = YES;

        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 100,100 , 20)];
        name.text = @"暮色";
        name.textColor = [UIColor whiteColor];
        name.font = [UIFont systemFontOfSize:25];
        
        UILabel *descriptin = [[UILabel alloc] initWithFrame:CGRectMake(20, 130,150 , 20)];
        descriptin.text = @"梦是柔软的东西";
        descriptin.textColor = [UIColor whiteColor];
        descriptin.font = [UIFont systemFontOfSize:20];
        
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(20, 150,150 , 30)];
        price.text = @"200RMB";
        price.textColor = [UIColor whiteColor];
        price.font = [UIFont systemFontOfSize:25];
        [self addSubview:view];
        [self addSubview:price];
        [self addSubview:descriptin];
        [self addSubview:name];
         */
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"ContentView" owner:self options:nil] lastObject];
        
        [self addSubview:view];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.productPic.image = [UIImage imageNamed:self.productModel.image];
    self.productName.text = @"白群";
    self.productDesc.text = @"梦是柔软的东西";
    self.productPrice.text = @"500";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
