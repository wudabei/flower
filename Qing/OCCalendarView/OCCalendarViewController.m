//
//  OCCalendarViewController.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/31/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCCalendarViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kCalenderViewWidth 320
#define kCalenderViewHeight 376
#define kBgColor(colorRGB) [UIColor colorWithRed:colorRGB/255.0 green:colorRGB/255.0 blue:colorRGB/255.0 alpha:0.3]

@interface OCCalendarViewController ()

@end

@implementation OCCalendarViewController
@synthesize delegate;

- (id)initAtPoint:(CGPoint)point inView:(UIView *)v arrowPosition:(OCArrowPosition)ap {
  self = [super initWithNibName:nil bundle:nil];
  if(self) {
    insertPoint = point;
    parentView = v;
    arrowPos = ap;
  }
  return self;
}

- (id)initAtPoint:(CGPoint)point inView:(UIView *)v {
  return [self initAtPoint:point inView:v arrowPosition:OCArrowPositionCentered];
}

- (void)loadView {
    [super loadView];
    self.view.frame = parentView.frame;
    
    
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    int width = kCalenderViewWidth;
    int height = kCalenderViewHeight;
    
    float arrowPosX = 400;
 // GARY Cancel the arrow
//    if(arrowPos == OCArrowPositionLeft) {
//        arrowPosX = 67;
//    } else if(arrowPos == OCArrowPositionRight) {
//        arrowPosX = 346;
//    }
    
    
    //this view sits behind the calendar and receives touches.  It tells the calendar view to disappear when tapped.
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    bgView.tag = 100;
    bgView.backgroundColor = kBgColor(20);
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] init];
    tapG.delegate = self;
    [bgView addGestureRecognizer:tapG ];
    [bgView setUserInteractionEnabled:YES];
    [self.view addSubview:bgView ];
    bgView.alpha = 0.0f;
    
    calView = [[OCCalendarView alloc] initAtPoint:insertPoint withFrame:CGRectMake(0, self.view.bottom - height, width, height) arrowPosition:arrowPos];
    [self.view addSubview:calView ];

    [UIView beginAnimations:@"animateOutCalendar" context:nil];
    [UIView setAnimationDuration:0.4f];
    bgView.alpha = 1.0f;
    [UIView commitAnimations];
    
    /*
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(320 - 50, calView.top, 50, 30)];
    [btn addTarget:self action:@selector(removeCalView) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor yellowColor];
    btn.titleLabel.text = @"确定";
//    [self.view addSubview:btn];
    */
}

- (void)removeCalView {
    NSDate *startDate = [calView getStartDate];
    NSDate *endDate = [calView getEndDate];
    
    [calView removeFromSuperview];
    [[self.view viewWithTag:100] removeFromSuperview];
    calView = nil;
    [self.delegate completedWithStartDate:startDate endDate:endDate];
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    //Animate out the calendar view if it already exists
    [UIView beginAnimations:@"animateOutCalendar" context:nil];
    [UIView setAnimationDuration:0.4f];
    calView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    calView.alpha = 0.0f;
    [UIView commitAnimations];
    [self performSelector:@selector(removeCalView) withObject:nil afterDelay:0.4f];
    
    if(calView) {
        
    } else {
        /*
        //Recreate the calendar if it doesn't exist.
        CGPoint point = [touch locationInView:self.view];

        //CGPoint insertPoint = CGPointMake(200+130*0.5, 200+10);
        int width = 390;
        int height = 300;
        
        calView = [[OCCalendarView alloc] initAtPoint:point withFrame:CGRectMake(point.x - width*0.5, point.y - 31.4, width, height)];
        [self.view addSubview:calView ];
         */
    }
    
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
