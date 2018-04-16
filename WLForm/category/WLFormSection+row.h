//
//  WLFormSection+row.h
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormSection.h"

@class WLFormItem;
@interface WLFormSection (row)

- (WLFormItem *)getItemWithIndex:(NSInteger) index;
- (void)setItem:(WLFormItem *)item index:(NSInteger)index;
@end
