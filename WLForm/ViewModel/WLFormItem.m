//
//  WLFormItem.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormItem.h"

NSString *kValidateRetKey = @"kValidateRetKey";
NSString *kValidateMsgKey = @"kValidateMsgKey";

@interface WLFormItem()
@end

@implementation WLFormItem

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super init];
    if (self) {
        _style = style;
        _reuseIdentifier = reuseIdentifier;
    }
    return self;
}
@end
