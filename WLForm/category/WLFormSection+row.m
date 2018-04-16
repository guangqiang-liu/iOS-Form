//
//  WLFormSection+row.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormSection+row.h"
#import "WLFormItem.h"

@implementation WLFormSection (row)

- (WLFormItem *)getItemWithIndex:(NSInteger) index {
    if (self.itemArray.count > index) {
        return self.itemArray[index];
    }
    return nil;
}

- (void)setItem:(WLFormItem *)item index:(NSInteger)index {
    if (self.itemArray.count < index) {
        return;
    }
    self.itemArray[index] = item;
}
@end
