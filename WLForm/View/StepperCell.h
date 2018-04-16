//
//  StepperCell.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepperCell : UITableViewCell

@property (nonatomic, copy) void(^stepperBlock)(double newValue);

- (void)updateValue:(double)value;
@end
