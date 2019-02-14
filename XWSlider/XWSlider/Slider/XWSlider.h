//
//  CXWLightProcessView.h
//  voiceAIApp
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 Avsnest. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CXWPublicValueBlock)(id object);
@interface XWSlider : UIControl

/**
 设置最小值 default是0
*/
@property(nonatomic) float minimumValue;
/**
 设置最大值 default是20.0
 */
@property(nonatomic) float maximumValue;
/**
 设置刻度 default是5 最好能被最大值减去最小值的差整除
 */
@property (nonatomic) float scale;

/**
 @isAnimalShow 是否动态的显示数值 default没有
 */
@property (nonatomic) float isAnimalShow;
/**
 当前的数值
 */
@property (nonatomic, assign) NSInteger currenIndex;

/**
 回调当前的数值
 */
@property (nonatomic, copy) CXWPublicValueBlock valueBlock;

@end
