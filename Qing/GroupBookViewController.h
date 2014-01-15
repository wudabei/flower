//
//  GroupBookViewController.h
//  Qing
//
//  Created by cannaan on 14-1-10.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface GroupBookViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) IBOutlet iCarousel *iCarousel;

@end
