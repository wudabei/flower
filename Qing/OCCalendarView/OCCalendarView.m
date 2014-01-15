//
//  OCCalendarView.m
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import "OCCalendarView.h"
#import "OCDaysView.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectShow.h"
#define kdaysViewX 0
#define kdaysViewY 82
#define kHeaderHeight 41

#define kBgColor(colorRGB) [UIColor colorWithRed:colorRGB/255.0 green:colorRGB/255.0 blue:colorRGB/255.0 alpha:1.0]

#define colorRGB 74
#define kColor [UIColor colorWithRed:colorRGB/255.0 green:colorRGB/255.0 blue:colorRGB/255.0 alpha:1.0]

@interface OCCalendarView ()

@property (nonatomic,strong)UILabel *circleLabel;
@property (nonatomic,strong)UIImageView *labelBG;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UIView *circleCon;

@property (nonatomic,strong)SelectShow *show;
@end

@implementation OCCalendarView

- (id)initAtPoint:(CGPoint)p withFrame:(CGRect)frame {
  return [self initAtPoint:p withFrame:frame arrowPosition:OCArrowPositionCentered];
}

// by gary
- (void)_initShowLabels {

    self.circleCon = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hDiff, vDiff)];
    self.circleCon.backgroundColor = [UIColor whiteColor];

    UIImageView *circle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dataSelectBG.png"]];
    circle.frame =  CGRectMake(hDiff /2 - 30/2,vDiff/2 - 30/2, 30, 30);
    circle.center = self.circleCon.center;
    self.circleLabel =[[UILabel alloc]initWithFrame:self.circleCon.bounds];
    self.circleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.circleLabel.textAlignment = NSTextAlignmentCenter;
    self.circleLabel.textColor = [UIColor whiteColor];
    self.circleLabel.text = @"10";
    self.labelBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dataSelectPop.png"]];
    
    self.labelBG.frame = CGRectMake(hDiff /2 - 31, circle.top - 1, 62, 47);
    
    self.label = [[UILabel alloc]initWithFrame:self.labelBG.bounds];
    [self.labelBG addSubview:self.label];
    
    [self.circleCon addSubview: circle];
    [self.circleCon addSubview: self.circleLabel];
    [self.circleCon addSubview:self.labelBG];
    
    self.circleCon.tag = 100;
    self.circleCon.clipsToBounds = NO;

}
- (id)initAtPoint:(CGPoint)p withFrame:(CGRect)frame arrowPosition:(OCArrowPosition)arrowPos {
  NSLog(@"Arrow Position: %u", arrowPos);
  
  //    CGRect frame = CGRectMake(p.x - 390*0.5, p.y - 31.4, 390, 270);
  self = [super initWithFrame:frame];
  if(self) {
      
      // init the
//      [self _initShowLabels];
      
      self.show = [[SelectShow alloc]initWithFrame:CGRectMake(0, 0, 62, 47)];
      
    self.backgroundColor = kBgColor(210);
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		
		NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
		NSDateComponents *dateParts = [calendar components:unitFlags fromDate:[NSDate date]];
		currentMonth = [dateParts month];
		currentYear = [dateParts year];
    
    arrowPosition = arrowPos;
    
    selected = NO;
    startCellX = -1;
    startCellY = -1;
    endCellX = -1;
    endCellY = -1;
    
    hDiff = khDiff;
    vDiff = kvDiff;
      daysView = [[OCDaysView alloc] initWithFrame:CGRectMake(kdaysViewX, kdaysViewY, 320, vDiff*6)];
      [daysView setYear:currentYear];
      [daysView setMonth:currentMonth];
      [daysView resetRows];
      [self addSubview:daysView];
      
      UIImageView *left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left.png"]];
      UIImageView *right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow.png"]];
      left.frame = CGRectMake(19, 16, 8, 13);
      right.frame = CGRectMake( 320 - 28, 16, 8, 13);
      [self addSubview:left];
      [self addSubview:right];
      selectionView = [[OCSelectionView alloc] initWithFrame:CGRectMake((320 - hDiff * 7)/2, kdaysViewY, hDiff*7, vDiff*6)];
    [self addSubview:selectionView];
    
    selectionView.frame = CGRectMake( (320 - hDiff * 7)/2, kdaysViewY, hDiff * 7, ([daysView addExtraRow] ? 6 : 5)*vDiff);
    
    // gary add
    selectionView.delegate = self;
      
    //Make the view really small and invisible
    CGAffineTransform tranny = CGAffineTransformMakeScale(0.1, 0.1);
    self.transform = tranny;
    self.alpha = 0.0f;
    
    //Animate in the view.
    [UIView beginAnimations:@"animateInCalendar" context:nil];
    [UIView setAnimationDuration:0.4f];
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.alpha = 1.0f;
    [UIView commitAnimations];
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(CGRectMake(0, 0, 60, 42), point)) {
        //User tapped the prevMonth button
        if(currentMonth == 1) {
            currentMonth = 12;
            currentYear--;
        } else {
            currentMonth--;
        }
        [UIView beginAnimations:@"fadeOutViews" context:nil];
        [UIView setAnimationDuration:0.1f];
        [daysView setAlpha:0.0f];
        [selectionView setAlpha:0.0f];
        [UIView commitAnimations];
        
        [self performSelector:@selector(resetViews) withObject:nil afterDelay:0.1f];
    } else if(CGRectContainsPoint(CGRectMake(260, 0, 60, 42), point)) {
        //User tapped the nextMonth button
        if(currentMonth == 12) {
            currentMonth = 1;
            currentYear++;
        } else {
            currentMonth++;
        }
        [UIView beginAnimations:@"fadeOutViews" context:nil];
        [UIView setAnimationDuration:0.1f];
        [daysView setAlpha:0.0f];
        [selectionView setAlpha:0.0f];
        [UIView commitAnimations];
        
        [self performSelector:@selector(resetViews) withObject:nil afterDelay:0.1f];
    }
}

- (void)resetViews {
    [selectionView resetSelection];
    [daysView setMonth:currentMonth];
    [daysView setYear:currentYear];
    [daysView resetRows];
    [daysView setNeedsDisplay];
    [self.show selectShowReset];
    [self setNeedsDisplay];
    
    selectionView.frame = CGRectMake((320 - hDiff * 7)/2, kdaysViewY, hDiff * 7, ([daysView addExtraRow] ? 6 : 5)*vDiff);

    [UIView beginAnimations:@"fadeInViews" context:nil];
    [UIView setAnimationDuration:0.1f];
    [daysView setAlpha:1.0f];
    [selectionView setAlpha:1.0f];
    [UIView commitAnimations];
}

- (void)setArrowPosition:(OCArrowPosition)pos {
    arrowPosition = pos;
}


- (NSDate *)getStartDate {
    
    NSDate *retDate = [calendar dateFromComponents:[self dateParts]];
    return retDate;
}

- (NSDateComponents *)dateParts {

    CGPoint startPoint = [selectionView startPoint];
    
    int day = 1;
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
    
    if(startPoint.y == 0 && startPoint.x+1 < weekdayOfFirst) {
        day = startPoint.x - weekdayOfFirst+2;
    } else {
        int countDays = 1;
        for (int i = 0; i < 6; i++) {
            for(int j = 0; j < 7; j++) {
                int dayNumber = i * 7 + j;
                if(dayNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
                    if(i == startPoint.y && j == startPoint.x) {
                        day = countDays;
                    }
                    ++countDays;
                }
            }
        }
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];

    return comps;
}


- (NSDate *)getEndDate {
    CGPoint endPoint = [selectionView endPoint];
    
    int day = 1;
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
	
    if(endPoint.y == 0 && endPoint.x+1 < weekdayOfFirst) {
        day = endPoint.x - weekdayOfFirst+2;
    } else {
        int countDays = 1;
        for (int i = 0; i < 6; i++) {
            for(int j = 0; j < 7; j++) {
                int dayNumber = i * 7 + j;
                if(dayNumber >= (weekdayOfFirst - 1) && day <= numDaysInMonth) {
                    if(i == endPoint.y && j == endPoint.x) {
                        day = countDays;
                    }
                    ++countDays;
                }
            }
        }
    }
        
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSDate *retDate = [calendar dateFromComponents:comps];
    
    return retDate;
}

- (void)drawRect:(CGRect)rect
{
    NSArray *dayTitles = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    
    
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Color Declarations
    UIColor* bigBoxInnerShadowColor = [UIColor colorWithRed: 0 green: 1 blue: 1 alpha: 0.26];
    UIColor* backgroundLightColor = [UIColor colorWithWhite:0.2 alpha: 1];
    UIColor* lineLightColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 0.27];
    UIColor* lightColor = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 0.15];
    UIColor* darkColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.72];
    UIColor* boxStroke = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 0.59];
    
    //// Gradient Declarations
    NSArray* gradient2Colors = [NSArray arrayWithObjects: 
                                (id)darkColor.CGColor, 
                                (id)lightColor.CGColor, nil];
    CGFloat gradient2Locations[] = {0, 1};
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradient2Colors, gradient2Locations);
    
    //// Shadow Declarations
    CGColorRef bigBoxInnerShadow = bigBoxInnerShadowColor.CGColor;
    CGSize bigBoxInnerShadowOffset = CGSizeMake(0, 1);
    CGFloat bigBoxInnerShadowBlurRadius = 1;
    CGColorRef shadow = [UIColor blackColor].CGColor;
    CGSize shadowOffset = CGSizeMake(-1, -0);
    CGFloat shadowBlurRadius = 0;
    CGColorRef shadow2 = [UIColor blackColor].CGColor;
    CGSize shadow2Offset = CGSizeMake(1, 1);
    CGFloat shadow2BlurRadius = 1;
    CGColorRef backgroundShadow = [UIColor whiteColor].CGColor;
    CGSize backgroundShadowOffset = CGSizeMake(2, 3);
    CGFloat backgroundShadowBlurRadius = 5;
    
    
    /*
    //////// Draw background of popover
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPath];
    
    float arrowPosX = 208;
    
    if(arrowPosition == OCArrowPositionLeft) {
        arrowPosX = 67;
    } else if(arrowPosition == OCArrowPositionRight) {
        arrowPosX = 346;
    }
    
    if([daysView addExtraRow]) {
        NSLog(@"Added extra row");
        [roundedRectanglePath moveToPoint: CGPointMake(42, 267.42)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(52, 278.4) controlPoint1: CGPointMake(42, 273.49) controlPoint2: CGPointMake(46.48, 278.4)];
        [roundedRectanglePath addLineToPoint: CGPointMake(361.5, 278.4)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(371.5, 267.42) controlPoint1: CGPointMake(367.02, 278.4) controlPoint2: CGPointMake(371.5, 273.49)];
        [roundedRectanglePath addLineToPoint: CGPointMake(371.5, 53.9)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(361.5, 43.9) controlPoint1: CGPointMake(371.5, 48.38) controlPoint2: CGPointMake(367.02, 43.9)];
//        [roundedRectanglePath addLineToPoint: CGPointMake(arrowPosX+13.5, 43.9)];
//        [roundedRectanglePath addLineToPoint: CGPointMake(arrowPosX, 31.4)];
//        [roundedRectanglePath addLineToPoint: CGPointMake(arrowPosX-13.5, 43.9)];
        [roundedRectanglePath addLineToPoint: CGPointMake(52, 0)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(42, 53.9) controlPoint1: CGPointMake(46.48, 43.9) controlPoint2: CGPointMake(42, 48.38)];
        [roundedRectanglePath addLineToPoint: CGPointMake(42, 267.42)];
    } else {
        
        [roundedRectanglePath moveToPoint: CGPointMake(42, 246.4)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(52, 256.4) controlPoint1: CGPointMake(42, 251.92) controlPoint2: CGPointMake(46.48, 256.4)];
        [roundedRectanglePath addLineToPoint: CGPointMake(361.5, 256.4)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(371.5, 246.4) controlPoint1: CGPointMake(367.02, 256.4) controlPoint2: CGPointMake(371.5, 251.92)];
        [roundedRectanglePath addLineToPoint: CGPointMake(371.5, 53.9)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(361.5, 43.9) controlPoint1: CGPointMake(371.5, 48.38) controlPoint2: CGPointMake(367.02, 43.9)];
        [roundedRectanglePath addLineToPoint: CGPointMake(arrowPosX+13.5, 43.9)];
        [roundedRectanglePath addLineToPoint: CGPointMake(arrowPosX, 31.4)];
        [roundedRectanglePath addLineToPoint: CGPointMake(arrowPosX-13.5, 43.9)];
        [roundedRectanglePath addLineToPoint: CGPointMake(52, 43.9)];
        [roundedRectanglePath addCurveToPoint: CGPointMake(42, 53.9) controlPoint1: CGPointMake(46.48, 43.9) controlPoint2: CGPointMake(42, 48.38)];
        [roundedRectanglePath addLineToPoint: CGPointMake(42, 246.4)];
        NSLog(@"did not add extra row");
    }
    
    [roundedRectanglePath closePath];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, backgroundShadowOffset, backgroundShadowBlurRadius, backgroundShadow);
    [backgroundLightColor setFill];
    [roundedRectanglePath fill];
    
    ////// background Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -bigBoxInnerShadowBlurRadius, -bigBoxInnerShadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -bigBoxInnerShadowOffset.width, -bigBoxInnerShadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = bigBoxInnerShadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = bigBoxInnerShadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    bigBoxInnerShadowBlurRadius,
                                    bigBoxInnerShadow);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    CGContextRestoreGState(context);
    
    [boxStroke setStroke];
    roundedRectanglePath.lineWidth = 0.5;
    [roundedRectanglePath stroke];
    
    
    //Dividers
    float addedHeight = ([daysView addExtraRow] ? 24 : 0);
    for(int i = 0; i < dayTitles.count-1; i++) {
        //// divider Drawing
        UIBezierPath* dividerPath = [UIBezierPath bezierPathWithRect: CGRectMake(96+i*hDiff, 73.5, 0.5, 168+addedHeight)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow);
        [lineLightColor setFill];
        [dividerPath fill];
        CGContextRestoreGState(context);
    }
    
    
    //// Rounded Rectangle 2 Drawing
    UIBezierPath* roundedRectangle2Path = [UIBezierPath bezierPath];
    if([daysView addExtraRow]) {
        [roundedRectangle2Path moveToPoint: CGPointMake(42, 267.42)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(52, 278.4) controlPoint1: CGPointMake(42, 273.49) controlPoint2: CGPointMake(46.48, 278.4)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(361.5, 278.4)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(371.5, 267.42) controlPoint1: CGPointMake(367.02, 278.4) controlPoint2: CGPointMake(371.5, 273.49)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(371.5, 53.9)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(361.5, 43.9) controlPoint1: CGPointMake(371.5, 48.38) controlPoint2: CGPointMake(367.02, 43.9)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(arrowPosX+13.5, 43.9)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(arrowPosX, 31.4)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(arrowPosX-13.5, 43.9)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(52, 43.9)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(42, 53.9) controlPoint1: CGPointMake(46.48, 43.9) controlPoint2: CGPointMake(42, 48.38)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(42, 267.42)];
    } else {
        [roundedRectangle2Path moveToPoint: CGPointMake(42, 246.4)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(52, 256.4) controlPoint1: CGPointMake(42, 251.92) controlPoint2: CGPointMake(46.48, 256.4)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(361.5, 256.4)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(371.5, 246.4) controlPoint1: CGPointMake(367.02, 256.4) controlPoint2: CGPointMake(371.5, 251.92)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(371.5, 53.9)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(361.5, 43.9) controlPoint1: CGPointMake(371.5, 48.38) controlPoint2: CGPointMake(367.02, 43.9)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(arrowPosX+13.5, 43.9)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(arrowPosX, 31.4)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(arrowPosX-13.5, 43.9)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(52, 43.9)];
        [roundedRectangle2Path addCurveToPoint: CGPointMake(42, 53.9) controlPoint1: CGPointMake(46.48, 43.9) controlPoint2: CGPointMake(42, 48.38)];
        [roundedRectangle2Path addLineToPoint: CGPointMake(42, 246.4)];
    }
    [roundedRectangle2Path closePath];
    CGContextSaveGState(context);
    [roundedRectangle2Path addClip];
    float endPoint = ([daysView addExtraRow] ? 278.4 : 256.4);
    CGContextDrawLinearGradient(context, gradient2, CGPointMake(206.75, endPoint), CGPointMake(206.75, 31.4), 0);
    CGContextRestoreGState(context);
    */
    
    
    for(int i = 0; i < dayTitles.count; i++) {
        //// dayHeader Drawing
        CGContextSaveGState(context);
//        CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
        
        CGRect dayHeaderFrame = CGRectMake( i*hDiff + (320 - hDiff * 7 )/2 , vDiff - 3, hDiff, vDiff);
        
        [kColor setFill];
        [((NSString *)[dayTitles objectAtIndex:i]) drawInRect: dayHeaderFrame withFont: [UIFont fontWithName: @"Heiti TC" size: 12] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
        CGContextRestoreGState(context);
    }
    
    int month = currentMonth;
    int year = currentYear;
    char *months[12] = {"1", "2", "3", "4", "5", "6",
		"7", "8", "9", "10", "11", "12"};
	NSString *monthTitle = [NSString stringWithFormat:@"%d年%s月",year, months[month - 1]];

    //// Month Header Drawing
    CGContextSaveGState(context);
    // GARY CANEL THE SHADOW
//    CGContextSetShadowWithColor(context, shadow2Offset, shadow2BlurRadius, shadow2);
    CGRect textFrame = CGRectMake(0, 12, 320, kHeaderHeight );
    [kColor setFill];
    
    [monthTitle drawInRect: textFrame withFont: [UIFont fontWithName: @"HeiTi TC" size: 18] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    CGContextRestoreGState(context);
    
    /*
    //// backArrow Drawing
    UIBezierPath* backArrowPath = [UIBezierPath bezierPath];
    [backArrowPath moveToPoint: CGPointMake(66, 58.5)];
    [backArrowPath addLineToPoint: CGPointMake(60, 62.5)];
    [backArrowPath addCurveToPoint: CGPointMake(66, 65.5) controlPoint1: CGPointMake(60, 62.5) controlPoint2: CGPointMake(66, 65.43)];
    [backArrowPath addCurveToPoint: CGPointMake(66, 58.5) controlPoint1: CGPointMake(66, 65.57) controlPoint2: CGPointMake(66, 58.5)];
    [backArrowPath closePath];
    [[UIColor whiteColor] setFill];
    [backArrowPath fill];
    
    //// forwardArrow Drawing
    UIBezierPath* forwardArrowPath = [UIBezierPath bezierPath];
    [forwardArrowPath moveToPoint: CGPointMake(349.5, 58.5)];
    [forwardArrowPath addLineToPoint: CGPointMake(355.5, 62)];
    [forwardArrowPath addCurveToPoint: CGPointMake(349.5, 65.5) controlPoint1: CGPointMake(355.5, 62) controlPoint2: CGPointMake(349.5, 65.43)];
    [forwardArrowPath addCurveToPoint: CGPointMake(349.5, 58.5) controlPoint1: CGPointMake(349.5, 65.57) controlPoint2: CGPointMake(349.5, 58.5)];
    [forwardArrowPath closePath];
    [[UIColor whiteColor] setFill];
    [forwardArrowPath fill];
    */
    //// Cleanup
    CGGradientRelease(gradient2);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark -select delegate
// gary add delegte
-(void)selectDate:(OCSelectionView *)view   {

    NSDateComponents *parts = [self dateParts];
    
    int day = 1;
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
	
    if(view.startPoint.y == 0 && view.startPoint.x+1 < weekdayOfFirst) {
        
    } else {
        
        int dayNumber = [view startPoint].y * 7 + [view startPoint].x;

        if(dayNumber >= (weekdayOfFirst - 1) && day < numDaysInMonth) {
            
            float x =([view startPoint].x )*hDiff;
            float y =([view startPoint].y )*vDiff;
            NSLog(@"x  y : %f  %f",x,hDiff);
            self.show.origin = CGPointMake(x, y);
            self.show.dataNumber.text = [NSString stringWithFormat:@"%d",parts.day];
            
             self.show.dateTip.text = [NSString stringWithFormat:@"%d月%d日",parts.month,parts.day];
            [view addSubview:self.show];
        }
    }
}



@end
