//
//  OrderViewController.m
//  Qing
//
//  Created by cannaan on 14-1-13.
//  Copyright (c) 2014年 cannaan. All rights reserved.
//

#import "OrderViewController.h"

#import "OCCalendarViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface OrderViewController ()

@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startSunday];
//        calendar.frame = CGRectMake(10, self.view.height - 470, 300, 470);
//        [self.view addSubview:calendar];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //This view just detects touches, and then creates a new calendar
    
    
    //Here's where the magic happens
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark OCCalendarDelegate Methods

- (void)completedWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    self.ariveDate.text = [NSString stringWithFormat:@"%@",[df stringFromDate:startDate]];
    
//    [self showToolTip:[NSString stringWithFormat:@"%@ - %@", [df stringFromDate:startDate], [df stringFromDate:endDate]]];
    
    [calVC.view removeFromSuperview];
    calVC.delegate = nil;
    calVC = nil;
}


#pragma mark -
#pragma mark Prettifying Methods...



#pragma mark -
#pragma mark Gesture Recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint insertPoint = [touch locationInView:self.view];
    
    calVC = [[OCCalendarViewController alloc] initAtPoint:insertPoint inView:self.view arrowPosition:OCArrowPositionRight];
    calVC.delegate = self;
    [self.view addSubview:calVC.view];
    
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dateSelect:(UIButton *)sender {
    
    for (UITextField * field in [self.view subviews]) {
        if ([field isFirstResponder]) {
            [field resignFirstResponder];
        }
    }
    
    calVC = [[OCCalendarViewController alloc] initAtPoint:CGPointMake(150, 50) inView:self.view arrowPosition:OCArrowPositionLeft];
    calVC.delegate = self;
    [self.view addSubview:calVC.view];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"%d",textField.tag);
    switch (textField.tag) {
        case 1:
            [[self.view viewWithTag:2] becomeFirstResponder];
            return YES;
        case 2:
            [[self.view viewWithTag:3] becomeFirstResponder];
            return YES;
        case 3:
            [self resignResponder];
            return YES;
            default:
            return YES;
    }
}

- (IBAction)TextFieldresign:(UIControl *)sender {

    [self resignResponder];
}

- (void)resignResponder {
  [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
