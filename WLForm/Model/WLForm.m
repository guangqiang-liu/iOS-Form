//
//  WLForm.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLForm.h"
#import "WLFormSection.h"
#import "WLFormItem.h"

@interface WLForm ()

@property (nonatomic, strong, readwrite) NSMutableArray<WLFormSection *> *sectionArray;
@end

@implementation WLForm

- (void)addSection:(WLFormSection *)section {
    [self.sectionArray addObject:section];
}

- (void)removeSection:(WLFormSection *)section {
    [self.sectionArray removeObject:section];
}

- (void)reformResRet:(id)res {
    for (WLFormSection *section in self.sectionArray) {
        for (WLFormItem *item in section.itemArray) {
            !item.reformResRetBlock ?: item.reformResRetBlock(res, item.value);
        }
    }
}

- (id)fetchRequestParams {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (WLFormSection *section in self.sectionArray) {
        for (WLFormItem *item in section.itemArray) {
            if (!item.requestParamsConfigBlock) continue;
            id params = item.requestParamsConfigBlock(item.value);
            if ([params isKindOfClass:[NSDictionary class]]) {
                [dic addEntriesFromDictionary:params];
            } else if ([params isKindOfClass:[NSArray class]]) {
                for (NSDictionary *subParams in params) {
                    [dic addEntriesFromDictionary:subParams];
                }
            }
        }
    }
    return dic;
}

- (NSDictionary *)validateItems {
    for (WLFormSection *section in self.sectionArray) {
        for (WLFormItem *item in section.itemArray) {
            if (!item.isHidden && item.valueValidateBlock) {
                NSDictionary *dic = item.valueValidateBlock(item.value);
                NSNumber *ret = dic[kValidateRetKey];
                NSAssert(ret, @"缺少参数");
                if (!ret) continue;
                if (!ret.boolValue) return dic;
            }
        }
    }
    return itemValid();
}

- (WLFormItem *)itemWithIndexPath:(NSIndexPath *)indexPath {
    NSInteger sectionCounter = -1;
    WLFormSection *tempSection = nil;
    for (WLFormSection *section in self.sectionArray) {
        if (!section.isHidden) sectionCounter ++;
        if (sectionCounter == indexPath.section) {
            tempSection = section;
            break;
        }
    }
    
    if (sectionCounter == -1) return nil;
    
    NSInteger itemCounter = -1;
    for (WLFormItem *item in tempSection.itemArray) {
        if (!item.isHidden) itemCounter ++;
        if (itemCounter == indexPath.row) {
            return item;
        }
    }
    return nil;
}

- (NSIndexPath *)indexPathWithItem:(WLFormItem *) item {
    if (item.isHidden) return nil;
    if (!item.section || item.section.hidden) return nil;
    WLFormSection *tempSection = item.section;
    NSInteger sectionCounter = -1;
    BOOL matchSection = NO;
    for (WLFormSection *section in self.sectionArray) {
        if (!section.isHidden) sectionCounter ++;
        if (section == tempSection) {
            matchSection = YES;
            break;
        }
    }
    
    if (!matchSection) return nil;
    
    NSInteger itemCounter = -1;
    BOOL matchItem = NO;
    for (WLFormItem *itemT in tempSection.itemArray) {
        if (!itemT.isHidden) itemCounter ++;
        if (itemT == item) {
            matchItem = YES;
            break;
        }
    }
    
    if (!matchItem) return nil;
    
    return [NSIndexPath indexPathForRow:itemCounter inSection:sectionCounter];
}

- (NSMutableArray<WLFormSection *> *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}

- (NSUInteger)count {
    return self.sectionArray.count;
}

@end
