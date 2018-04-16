//
//  WLFormSection.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormSection.h"
#import "WLFormItem.h"

@interface WLFormSection ()

@property (nonatomic, strong, readwrite) NSMutableArray <WLFormItem *> *itemArray;
@end

@implementation WLFormSection

- (void)addItem:(WLFormItem *)item {
    item.section = self;
    [self.itemArray addObject:item];
}

- (void)addItemWithArray:(NSArray <WLFormItem *> *)itemArray {
    for (WLFormItem *item in itemArray) {
        [self addItem:item];
    }
}

- (CGFloat)footerHeight {
    return _footerHeight != 0 ? _footerHeight : 0.01;
}

- (CGFloat)headerHeight {
    return _headerHeight != 0 ? _headerHeight : 0.01;
}

- (NSMutableArray<WLFormItem *> *)itemArray {
    if (!_itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
    }
    return _itemArray;
}

- (NSUInteger)count {
    return self.itemArray.count;
}

@end
