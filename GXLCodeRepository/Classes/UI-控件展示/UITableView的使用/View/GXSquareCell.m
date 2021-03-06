//
//  GXSquareCell.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/25.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXSquareCell.h"

@implementation GXSquareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置指示器
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.accessoryView = [[UISwitch alloc] init];

        // 设置选中的背景色
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = [UIColor redColor];
        self.selectedBackgroundView = selectedBackgroundView;

        // 设置默认的背景色
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"taobaoDetai_coupon"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.imageView.backgroundColor = [UIColor redColor];
    }
    return self;
}

// 技术点: 在layoutSubViews中, 可以多干一些事情
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    imageRect.origin.x = 0;
    self.imageView.frame = imageRect;
    
    if (self.imageView.image != nil) {
        CGRect labelRect = self.textLabel.frame;
        labelRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
        self.textLabel.frame = labelRect;
    }
}

//技术点: 可以在setFrame中拦截一些尺寸
- (void)setFrame:(CGRect)frame
{
//    NSLog(@"%@", NSStringFromCGRect(frame));
    /**
     * 技术点: 在设置tableView为Group时, 默认第一个section的frame会下移35, 在setFrame中更改会有问题, footerView的位置不会变
     * 如果有footerView一定要在tableView的edgeInset设置这个
     */
//    frame.origin.y -= (35 - 10);
    [super setFrame:frame];
}

@end
