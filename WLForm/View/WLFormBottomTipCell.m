//
//  WLFormBottomTipCell.m
//  WLForm
//
//  Created by 刘光强 on 2018/5/4.
//  Copyright © 2018年 quangqiang. All rights reserved.
//

#import "WLFormBottomTipCell.h"

@interface WLFormBottomTipCell()

@property (nonatomic, strong) UILabel *tipLable;

@end

@implementation WLFormBottomTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = clear_color;
        [self renderViews];
    }
    return self;
}

- (void)renderViews {
    [self.contentView addSubview:self.tipLable];
}

- (void)setTipStr:(NSString *)tipStr {
    _tipStr = tipStr;
    
    self.tipLable.text = tipStr;
    [self.tipLable sizeToFit];
}

- (UILabel *)tipLable {
    if (!_tipLable) {
        _tipLable = [[UILabel alloc] init];
        _tipLable.frame = CGRectMake(20, 10, SCREEN_WIDTH - 40, 20);
        _tipLable.textColor = HexRGB(0x999999);
        _tipLable.font = H12;
        _tipLable.numberOfLines = 2;
        [_tipLable whenTapped:^{
            NSLog(@"点击了提示文字");
        }];
    }
    return _tipLable;
}

@end
