//
//  ViewController.m
//  WLForm
//
//  Created by 刘光强 on 2018/4/16.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "ViewController.h"
#import "WLFormItemViewModel.h"
#import "WLFormSectionViewModel.h"
#import "WLForm.h"
#import "WLFormTextInputCell.h"
#import "WLFormStepperCell.h"
#import "WLFormMoreInfoCell.h"
#import "WLFormBottomTipCell.h"
#import "WLFormBottomButtonCell.h"
#import "WLFormRadioCell.h"
#import "WLFormSelectCell.h"
#import "WLFormBottomTipButtonCell.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)renderViews {
    [super renderViews];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
    [self setupViews];
    [self configForm];
    //    [self.form reformResRet:@{@"name":@"xx",@"sex":@"pp"}];
    //    [self.tableView reloadData];
}

#pragma mark - event response
- (void)submit:(id)sender {
    NSDictionary *dic = [self.form validateItems];
    if (![dic[kValidateRetKey] boolValue]) {
        [self alertMsg:dic[kValidateMsgKey]];
    } else {
        NSString *msg = [[self.form fetchRequestParams] description];
        [self alertMsg:msg title:@"Params are OK"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - private methods
- (void)configForm {
    [self.form addSection:[self merchantInfo]];
    [self.form addSection:[self detailSection]];
    [self.form addSection:[self moreInfoSection]];
}

- (WLFormSectionViewModel *)merchantInfo {
    WLFormSectionViewModel *section = nil;
    WLFormItemViewModel *row = nil;
    NSDictionary *dic = @{};
    
    section = [[WLFormSectionViewModel alloc] init];
    section.headerHeight = 58;
    section.headerTitle = @"商户信息（必填）";
    
    dic = @{kLeftKey:@"名称", kPlaceholder:@"请输入商户名称"};
    row = [self textFieldCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"税号", kPlaceholder:@"请输入税号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"地址", kPlaceholder:@"请输入地址"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"联系电话", kPlaceholder:@"请输入联系电话"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"银行账号", kPlaceholder:@"请输入银行账号"};
    row = [self textFieldCellWithInfo:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"开户行", kPlaceholder:@"请输入开户行"};
    row = [self textFieldCellWithInfo:dic];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    return section;
}

- (WLFormSectionViewModel *)detailSection {
    
    WLFormSectionViewModel *section = nil;
    WLFormItemViewModel *row = nil;
    
    section = [[WLFormSectionViewModel alloc] init];
    section.headerHeight = 50;
    section.headerTitle = @"详情";
    
    NSDictionary *dic = @{kLeftKey:@"电话", kPlaceholder:@"请输入电话号码"};
    row = [self textFieldCellWithInfo:dic];
    row.hasTopSep = YES;
    [section addItem:row];
    
    dic = @{kLeftKey:@"更多信息（选填）"};
    row = [self rowForMoreInfo:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    return section;
}

- (WLFormSectionViewModel *)moreInfoSection {
    WLFormSectionViewModel *section = nil;
    WLFormItemViewModel *row = nil;
    NSDictionary *dic = @{};
    
    section = [[WLFormSectionViewModel alloc] init];
    
    dic = @{kLeftKey:@"税控盘类型", @"leftButtonTitle":@"航信金税盘", @"rightButtonTitle":@"百望税控盘"};
    row = [self rowForRadio:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"是否已开通电子发票业务", @"leftButtonTitle":@"未开通", @"rightButtonTitle":@"已开通"};
    row = [self rowForRadio:dic];
    [section addItem:row];
    
    dic = @{kLeftKey:@"说明：请输入新邮箱后点击提交，系统会给您重新发送电子发票"};
    row = [self rowForBottomTip:dic];
    row.hasBottomSep = NO;
    [section addItem:row];
    
    dic = @{kLeftKey:@"提交"};
    row = [self rowForBottomButton:dic];
    row.bottomSepLineMarginLeft = 0;
    [section addItem:row];
    return section;
}

- (WLFormItemViewModel *)rowForRadio:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormRadioCell"];
    row.cellClass = [WLFormRadioCell class];
    row.itemHeight = 48.f;
    row.itemConfigBlock = ^(WLFormRadioCell *cell, id value, NSIndexPath *indexPath) {
        cell.radioInfo = info;
    };
    return row;
}

- (WLFormItemViewModel *)rowForBottomTip:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomTipButtonCell"];
    row.cellClass = [WLFormBottomTipButtonCell class];
    row.itemHeight = 54.f;
    row.itemConfigBlock = ^(WLFormBottomTipButtonCell *cell, id value, NSIndexPath *indexPath) {
        [cell.tipButton setTitle:info[kLeftKey] forState:UIControlStateNormal];
    };
    return row;
}

- (WLFormItemViewModel *)rowForBottomButton:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormBottomButtonCell"];
    row.cellClass = [WLFormBottomButtonCell class];
    row.itemHeight = 78.f;
    __weak typeof(self) weakSelf = self;
    row.itemConfigBlock = ^(WLFormBottomButtonCell *cell, id value, NSIndexPath *indexPath) {
        [cell.button setTitle:info[kLeftKey] forState:UIControlStateNormal];
        [cell.button whenTapped:^{
        }];
    };
    return row;
}

- (WLFormItemViewModel *)rowForMoreInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormMoreInfoCell"];
    row.cellClass = [WLFormMoreInfoCell class];
    row.itemHeight = 54.f;
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormMoreInfoCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftTitle.text = value[kLeftKey];
        cell.moreInfoBlock = ^{
            WLFormSectionViewModel *section = self.form.sectionArray[2];
            section.hidden = !section.hidden;
            [self.tableView reloadData];
        };
    };
    return row;
}

- (WLFormItemViewModel *)rowForSelect:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormSelectCell"];
    row.itemHeight = 48;
    row.cellClass = [WLFormSelectCell class];
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormSelectCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftLable.text = value[kLeftKey];
        cell.rightTitle = value[kRightKey];
    };
    return row;
}

- (WLFormItemViewModel *)rowForBirthDay {
    WLFormItemViewModel *row = nil;
    NSDictionary *dic = @{kLeftKey:@"Date of Birth"};
    row = [self textFieldCellWithInfo:dic];
    row.disableValidateBlock = ^NSDictionary *(id value, BOOL didClicked) {
        [self.form reformResRet:@{@"key":@"value"}];
        NSString *msg = @"此行已禁用，暂不支持";
        if (didClicked) [self alertMsg:msg];
        return itemInvalid(msg);
    };
    return row;
}

- (WLFormItemViewModel *)rowForStepper {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"StepperCell"];
    row.cellClass = [WLFormStepperCell class];
    row.itemHeight = 44.f;
    row.value = @{kLeftKey:@"Age"}.mutableCopy;
    row.itemConfigBlock = ^(WLFormStepperCell *cell, id value, NSIndexPath *indexPath) {
        cell.textLabel.text = value[kLeftKey];
        [cell updateValue:[value[kRightKey] doubleValue]];
        cell.stepperBlock = ^(double newValue){
            value[kRightKey] = @(newValue);
        };
    };
    return row;
}

- (WLFormItemViewModel *)textFieldCellWithInfo:(NSDictionary *)info {
    WLFormItemViewModel *row = nil;
    row = [[WLFormItemViewModel alloc] initFormItemWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WLFormTextInputCell"];
    row.itemHeight = 48;
    row.cellClass = [WLFormTextInputCell class];
    row.value = info.mutableCopy;
    row.itemConfigBlock = ^(WLFormTextInputCell *cell, id value, NSIndexPath *indexPath) {
        cell.leftlabel.text = value[kLeftKey];
        cell.rightField.text = value[kRightKey];
        cell.rightField.enabled = ![value[kDisableKey] boolValue];
        cell.rightField.textColor = [value[kDisableKey] boolValue] ? HexRGB(0xcfcfcf) : textDarkBlackColor;
        cell.rightField.placeholder = value[kPlaceholder];
        cell.textChangeBlock = ^(NSString *text) {
            value[kRightKey] = text;
        };
    };
    row.requestParamsConfigBlock = ^(id value) {
        NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:1];
        ret[value[kLeftKey]] = value[kRightKey];
        return ret;
    };
    row.valueValidateBlock = ^NSDictionary *(id value) {
        if ([value[kRightKey] length] || [value[kDispensable] boolValue]) return itemValid();
        return itemInvalid(value[kPlaceholder]);
    };
    return row;
}

- (void)setupViews {
    self.title = @"WLForm";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Submit"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(submit:)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)alertMsg:(NSString *)msg title:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:done];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alertMsg:(NSString *)msg {
    [self alertMsg:nil title:msg];
}

@end
