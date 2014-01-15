//
//  OCDaysView.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCDaysView.h"
#define kdaysLaydown 14

#define kBgColor(colorRGB) [UIColor colorWithRed:colorRGB/255.0 green:colorRGB/255.0 blue:colorRGB/255.0 alpha:1.0]


@implementation OCDaysView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        startCellX = 3;
        startCellY = 0;
        endCellX = 3;
        endCellY = 0;
        
        hDiff = khDiff;
        vDiff = kvDiff;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
//    CGSize shadow2Offset = CGSizeMake(1, 1);
//    CGFloat shadow2BlurRadius = 1;
//    CGColorRef shadow2 = [UIColor blueColor].CGColor;
    //////////////
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    int month = currentMonth;
    int year = currentYear;
	
	//Get the first day of the month
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:month];
	[dateParts setYear:year];
	[dateParts setDay:1];
	NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:dateOnFirst];
	int weekdayOfFirst = [weekdayComponents weekday];	
    
    NSLog(@"weekdayOfFirst:%d", weekdayOfFirst);

	int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit 
										inUnit:NSMonthCalendarUnit 
                                       forDate:dateOnFirst].length;
    
    NSLog(@"month:%d, numDaysInMonth:%d", currentMonth, numDaysInMonth);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    didAddExtraRow = NO;
	
	int day = 1;
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			int dayNumber = i * 7 + j;
			
			if(dayNumber >= (weekdayOfFirst-1) && day <= numDaysInMonth) {
                NSString *str = [NSString stringWithFormat:@"%d", day];

                float x = j*hDiff + (320 - hDiff * 7)/2;
                float y = vDiff *i ;
                UIBezierPath* squre = [UIBezierPath bezierPath];
                [squre moveToPoint: CGPointMake(x, y)];
                [squre addLineToPoint: CGPointMake(x + hDiff, y)];
                [squre addLineToPoint: CGPointMake(x + hDiff, y + vDiff)];
                [squre addLineToPoint: CGPointMake(x , y + vDiff)];

                [squre closePath];
                [[UIColor whiteColor] setFill];
                [squre fill];
                
                CGContextSaveGState(context);
//                CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
                
                NSLog(@"daynumber %d---%@",dayNumber,str);
                CGRect dayHeader2Frame = CGRectMake( j*hDiff + (320 - hDiff * 7)/2 ,i*vDiff + 14, hDiff, vDiff);
                
                [[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0] setFill];
                
                [str drawInRect: dayHeader2Frame withFont: [UIFont fontWithName: @"HelveticaNeue-Thin" size: 20] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
                
                CGContextRestoreGState(context);
                
                if(i == 5) {
                    didAddExtraRow = YES;
                    NSLog(@"didAddExtraRow");
                }
				++day;
			}
		}
        
        
        // draw line
        float x = 0;
        float y = vDiff *i;
        
        UIBezierPath* line = [UIBezierPath bezierPath];
        [line moveToPoint: CGPointMake(x, y)];
        [line addLineToPoint: CGPointMake(320, y)];
        [line addLineToPoint: CGPointMake(320, y + 1)];
        [line addLineToPoint: CGPointMake(0, y + 1)];

        [line closePath];
        [kBgColor(210) setFill];
        [line fill];

        
	}
}

- (void)setMonth:(int)month {
    currentMonth = month;
    [self setNeedsDisplay];
}

- (void)setYear:(int)year {
    currentYear = year;
    [self setNeedsDisplay];
}

- (void)resetRows {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    int month = currentMonth;
    int year = currentYear;
	
	//Get the first day of the month
	NSDateComponents *dateParts = [[NSDateComponents alloc] init];
	[dateParts setMonth:month];
	[dateParts setYear:year];
	[dateParts setDay:1];
	NSDate *dateOnFirst = [calendar dateFromComponents:dateParts];

	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:dateOnFirst];
	int weekdayOfFirst = [weekdayComponents weekday];	
    
	int numDaysInMonth = [calendar rangeOfUnit:NSDayCalendarUnit 
										inUnit:NSMonthCalendarUnit 
                                       forDate:dateOnFirst].length;
    didAddExtraRow = NO;
	
	int day = 1;
	for (int i = 0; i < 6; i++) {
		for(int j = 0; j < 7; j++) {
			int dayNumber = i * 7 + j;
			if(dayNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
                if(i == 5) {
                    didAddExtraRow = YES;
                    NSLog(@"didAddExtraRow");
                }
				++day;
			}
		}
	}
}

- (BOOL)addExtraRow {
    return didAddExtraRow;
}


@end
