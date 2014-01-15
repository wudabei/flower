//
//  DetailView.m
//  Qing
//
//  Created by cannaan on 14-1-8.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "DetailView.h"
#import "ProductModel.h"

#define kLabelHeight 168
@implementation DetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:self options:nil] lastObject];
        view.tag = 100;
        view.frame = self.bounds;
//        self.picView.height = self.height - kLabelHeight;
//        self.productLayout.bottom = self.scrollViewItem.bottom;
//        self.shadowImg.bottom = self.height - kLabelHeight;
        NSLog(@"detailView frame %f %f",view.height,view.width);
        [self addSubview:view];
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {

    self.price.text = self.productModel.price;
    self.description.text = self.productModel.description;
        self.details.text = self.productModel.details;
    self.productName.text = self.productModel.name;
    
     // to do  image download
//    self.picView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",rand()/5 + 3]];
    self.price.right = self.rmb.left;
    NSLog(@"detailView frame %f %f",[self viewWithTag:100 ].height,[self viewWithTag:100 ].width);
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
