//
//  GroupBookViewController.m
//  Qing
//
//  Created by cannaan on 14-1-10.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "GroupBookViewController.h"
#import "WXFaceScrollerView.h"
#import "GroupSelectDoneViewController.h"



#define NUMBER_OF_ITEMS (IS_IPAD? 19: 12)
#define NUMBER_OF_VISIBLE_ITEMS 10
#define ITEM_SPACING 50.0f
#define INCLUDE_PLACEHOLDERS YES

@interface GroupBookViewController ()

@end

@implementation GroupBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.iCarousel.decelerationRate = 0.5;
    self.iCarousel.type = iCarouselTypeTimeMachine;
    self.iCarousel.vertical = YES;
    // Do any additional setup after loading the view from its nib.
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 4;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	//create new view if no view is available for recycling
	if (view == nil)
	{
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg"]];
		
        NSMutableArray *views = [NSMutableArray arrayWithCapacity:8];
        
        for (int i = 3; i < 9; i++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
            [views addObject:image];
        }
        
        view =  [[WXFaceScrollerView alloc] initWithFrame:CGRectMake(35, 350, 260, 350) views:views isCust:YES];
    
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectBtn setFrame:CGRectMake(view.width / 2 - 45, view.height - 200, 90, 90)];
   
    [selectBtn setImage:[UIImage imageNamed:@"unselectCricle.png"] forState:UIControlStateNormal];
        selectBtn.tag = 10;
    [selectBtn setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateSelected];
        [selectBtn addTarget:self action:@selector(productSelect:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:selectBtn];
        [view setNeedsDisplay];
        NSLog(@"%@",[view subviews]);
    }else{
	}
    //set label
    if ([view viewWithTag:9]) {
        [view viewWithTag:9].tag = 10;
    }
    
	return view;
}

- (void)productSelect:(UIButton *)sender {

    if (sender.tag == 10) {
        sender.tag = 9;
        [sender setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];
        
    }else {
        sender.tag = 10;

        [sender setImage:[UIImage imageNamed:@"right.png"] forState:UIControlStateNormal];

    }

}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed on some carousels if wrapping is disabled
	return INCLUDE_PLACEHOLDERS? 2: 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
        
		view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg"]];
		
        NSMutableArray *views = [NSMutableArray arrayWithCapacity:8];
        
        for (int i = 3; i < 9; i++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
            [views addObject:image];
        }
        
        view =  [[WXFaceScrollerView alloc] initWithFrame:CGRectMake(35, 350, 260, 350) views:views isCust:YES];
    }
	else
	{
	}
	   
    //set label
	
	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return ITEM_SPACING;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselTranformOptionTilt:
        {
            return 0.7;
        }
        case iCarouselTranformOptionSpacing:
        {
            return 0.9;
        }
        default:
        {
            return value;
        }
    }
}
- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 20.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.iCarousel.itemWidth);
}

#pragma mark - action
- (IBAction)next:(UIButton *)sender {
    
    GroupSelectDoneViewController *done = [[GroupSelectDoneViewController alloc] init];
    [self.navigationController pushViewController:done animated:YES];
    
}



@end
