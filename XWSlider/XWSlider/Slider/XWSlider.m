//
//  CXWLightProcessView.m
//  voiceAIApp
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import "XWSlider.h"
#import "UIColor+HEXString.h"
#import "UIFont+CXWFont.h"
#import "Masonry.h"

NSString *const CXWThemeColorStr = @"#FF6A6E";
NSString *const CXWWriteColorStr = @"#FFFFFF";
NSString *const CXWPingFang_SC_Regular = @"PingFang-SC-Regular";
#define leftMargin 20
#define rightMargin  55
#define backViewHeight  15

@interface XWSlider ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *processView;

@property (nonatomic, strong) UIView *showView;

@property (nonatomic, strong) UILabel *percentLabel;

@property (nonatomic, assign) NSInteger currentValue;
@end

@implementation XWSlider


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self CXWAddSubviews];
    }
    return self;
}
- (void)CXWAddSubviews {
    
    

    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    backView.layer.cornerRadius = backViewHeight*0.5;
    backView.layer.masksToBounds = YES;
    backView.userInteractionEnabled = NO;
    self.backView = backView;
    
    UIView *processView = [[UIView alloc] init];
    processView.backgroundColor = [UIColor colorWithHexString:CXWThemeColorStr];
    processView.layer.cornerRadius = backViewHeight*0.5;
    processView.layer.masksToBounds = YES;
    processView.userInteractionEnabled = NO;
    self.processView = processView;
    
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = [UIColor colorWithHexString:CXWWriteColorStr];
    showView.layer.cornerRadius = 12;
    showView.layer.shadowColor = [UIColor colorWithHexString:@"#666666"].CGColor;

    showView.layer.shadowOffset = CGSizeMake(0, 0.5);
    showView.layer.shadowOpacity = 1.0;
    showView.userInteractionEnabled = NO;
    self.showView = showView;
    
    UILabel *percentLabel = [[UILabel alloc] init];
    percentLabel.font = [UIFont CXWFontWithName:CXWPingFang_SC_Regular size:13];
    percentLabel.textColor = [UIColor colorWithHexString:@"#668544"];
    percentLabel.textAlignment = NSTextAlignmentRight;
    percentLabel.userInteractionEnabled = NO;
    self.percentLabel = percentLabel;
    

    [self addSubview:self.backView];
    [self addSubview:self.processView];
    [self addSubview:self.showView];
    [self addSubview:self.percentLabel];
    
    
    self.scale = 5.0;
    self.minimumValue = 0;
    self.maximumValue = 20;

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(leftMargin);
        make.right.equalTo(self).with.offset(-rightMargin);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(backViewHeight);
    }];
    
    [self.processView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backView);
        make.right.equalTo(self.showView.mas_centerX);
    }];
    
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(45);
        make.right.equalTo(self).with.offset(-10);
    }];

}


#pragma mark  ======Touch======

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {

    CGPoint currentPoint = [touch locationInView:self];
    [self changeShowIMGVXWithPoint:currentPoint];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentPoint = [touch locationInView:self];
    [self changeShowIMGVXWithPoint:currentPoint];
    if (self.isAnimalShow) {
        [self changeShowWithPoint:currentPoint];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentPoint = [touch locationInView:self];
    [self changeShowIMGVXWithPoint:currentPoint];
    
    [self changeShowWithPoint:currentPoint];
}

- (void)changeShowWithPoint:(CGPoint)currentPoint {
    CGFloat percent = (self.maximumValue - self.minimumValue)/self.scale;
    if (percent<=0) {
        percent = 1.0;
    }
    
    CGFloat sectionLength = (self.frame.size.width-leftMargin-rightMargin)/percent;
    NSInteger currentIndex  =(int)roundf((currentPoint.x-leftMargin)/sectionLength)*self.scale+self.minimumValue;
    if (currentIndex>self.maximumValue) {
        currentIndex = self.maximumValue;
    }
    if (currentIndex<=self.minimumValue) {
        currentIndex = self.minimumValue;
    }
    
    self.currenIndex = currentIndex;
    if (self.valueBlock) {
        self.valueBlock([NSNumber numberWithInteger:(self.currenIndex)]);
    }
}



- (void)changeShowIMGVXWithPoint:(CGPoint)point {
    
}


#pragma mark  ======赋值======
- (void)setCurrenIndex:(NSInteger)currenIndex {
    _currenIndex = currenIndex;
    
    
    CGFloat percent = (self.maximumValue - self.minimumValue)/self.scale;
    if (percent<=0) {
        percent = 1.0;
    }
    
    CGFloat sectionLength = (self.frame.size.width-leftMargin-rightMargin)/percent;
    
    CGFloat showViewX = leftMargin + sectionLength *(currenIndex-self.minimumValue)/self.scale;
    
    self.showView.center = CGPointMake(showViewX, self.showView.center.y);
    

    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.processView.frame;
        frame.size.width = self.showView.center.x - leftMargin;
        self.processView.frame = frame;
        
    }];
    
    self.percentLabel.text = [NSString stringWithFormat:@"%ld%%",currenIndex];
    

}





@end
