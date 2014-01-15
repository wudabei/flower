//
//  SelectShow.m
//  Qing
//
//  Created by cannaan on 14-1-15.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "SelectShow.h"

@implementation SelectShow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelectShow" owner:self options:nil] lastObject];
               [self addSubview:view];
        // Initialization code
    }
    return self;
}
- (void)selectShowReset {

    [self removeFromSuperview];
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
