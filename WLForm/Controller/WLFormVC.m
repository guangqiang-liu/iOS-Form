//
//  WLFormVC.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormVC.h"
#import "WLForm.h"
#import "WLFormSection.h"
#import "WLFormItem.h"
#import "UITableViewCell+Extention.h"

#define SEREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SEREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface WLFormVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation WLFormVC

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderViews];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0;
    for (WLFormSection *section in self.form.sectionArray) {
        if (!section.isHidden) count ++;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WLFormSection *sectionT = self.form.sectionArray[section];
    NSInteger count = 0;
    for (WLFormItem *item in sectionT.itemArray) {
        if (!item.isHidden) count ++;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WLFormItem *item = [self.form itemWithIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.reuseIdentifier];
    if (!cell) {
        if (item.cellClass) {
            cell = [[item.cellClass alloc] initWithStyle:item.style reuseIdentifier:item.reuseIdentifier];
        } else {
            cell = [[[NSBundle mainBundle] loadNibNamed:item.nibName owner:nil options:nil] lastObject];
        }
        !item.cellExtraInitBlock ?: item.cellExtraInitBlock(cell, item.value, indexPath);
    }
    
    NSAssert(!(item.itemConfigBlockWithCompletion && item.itemConfigBlock), @"row config block 二选一");
    itemConfigCompletion completion = nil;
    if (item.itemConfigBlock) {
        item.itemConfigBlock(cell, item.value, indexPath);
    } else if (item.itemConfigBlockWithCompletion) {
        completion = item.itemConfigBlockWithCompletion(cell, item.value, indexPath);
    }
    [self handleEnableWithCell:cell item: item indexPath: indexPath];
    !completion ?: completion();
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WLFormItem *item = [self.form itemWithIndexPath:indexPath];
    [cell updateCellSep:item.hasTopSep isBottom:item.hasBottomSep];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    WLFormSection *sectionT = self.form.sectionArray[section];
    return sectionT.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    WLFormSection *sectionT = self.form.sectionArray[section];
    return sectionT.footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WLFormItem *item = [self.form itemWithIndexPath:indexPath];
    return item.itemHeight == 0 ? UITableViewAutomaticDimension : item.itemHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    WLFormSection *sectionT = self.form.sectionArray[section];
    return sectionT.headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WLFormItem *item = [self.form itemWithIndexPath:indexPath];
    !item.didSelectBlock ?: item.didSelectBlock(indexPath, item.value);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    !item.didSelectCellBlock ?: item.didSelectCellBlock(indexPath, item.value, cell);
}

#pragma mark - private methods
- (void)renderViews {
    [self.view addSubview:self.tableView];
}

- (void)handleEnableWithCell:(UITableViewCell *)cell item:(WLFormItem *)item indexPath:(NSIndexPath *)indexPath {
    BOOL enable = YES;
    if (self.form.disableBlock) {
        enable = NO;
        if (item.enableValidateBlock) {
            NSNumber *num = item.enableValidateBlock(item.value, NO)[kValidateRetKey];
            enable = num.boolValue;
        }
    } else if (item.disableValidateBlock) {
        NSNumber *num = item.disableValidateBlock(item.value, NO)[kValidateRetKey];
        enable = num.boolValue;
    }
    
    [cell updateCellTouchWithIndexPath:indexPath target:self action:@selector(disableClick:) enable:enable];
}

#pragma mark - event response
- (void)disableClick:(UIButton *)button {
    UITableViewCell *cell = (UITableViewCell *)[button subviews];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WLFormItem *item = [self.form itemWithIndexPath:indexPath];
    if (item.disableValidateBlock) {
        NSNumber *num = item.disableValidateBlock(item.value, NO)[kValidateRetKey];
        BOOL enable = num.boolValue;
        if (!enable) {
            item.disableValidateBlock(item.value, YES);
            return;
        }
    }
    if (self.form.disableBlock) {
        self.form.disableBlock(self.form);
    }
}

#pragma mark - getter\setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SEREEN_WIDTH, SEREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
    }
    return _tableView;
}

- (WLForm *)form {
    if (!_form) {
        _form = [[WLForm alloc] init];
    }
    return _form;
}

@end
