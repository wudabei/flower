//
//  CustomCell.m
//  QingDemo
//
//  Created by cannaan on 14-1-7.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "CustomCell.h"
#import "ContentView.h"
@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        ContentView *contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
        contentView.tag = 100;
        [self.contentView addSubview:contentView];
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    ContentView *contentView = (ContentView *)[self.contentView viewWithTag:100];
    contentView.productModel = self.productModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    self.highlighted = NO;
    
    if(selected) {
        for (UIView *view in  [self.contentView subviews]) {
            if ([view isKindOfClass:[UIButton class]]) {
                [(UIButton *)view setHighlighted:NO];
            }
            // Configure the view for the selected state
        }
    }
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    if(highlighted) {
        
        for (UIView *view in  [self.contentView subviews]) {
            if ([view isKindOfClass:[UIButton class]]) {
                [(UIButton *)view setHighlighted:NO];
            }
        }
    }
}

@end
