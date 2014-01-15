//
//  OCSelectionView.h
//  OCCalendar
//
//  Created by Oliver Rickard on 3/30/12.
//  Copyright (c) 2012 UC Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>


// gary add select
@class OCSelectionView;


@protocol SelectDelegate <NSObject>

-(void)selectDate:(OCSelectionView *)view  ;

@end


@interface OCSelectionView : UIView {
    
    BOOL selected;
    int startCellX;
    int startCellY;
    int endCellX;
    int endCellY;
    
    float xOffset;
    float yOffset;
    
    float hDiff;
    float vDiff;
}

@property (nonatomic, assign) id <SelectDelegate> delegate;

- (void)resetSelection;
-(CGPoint)startPoint;
-(CGPoint)endPoint;
@end
