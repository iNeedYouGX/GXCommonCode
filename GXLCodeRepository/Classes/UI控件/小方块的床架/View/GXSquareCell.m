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
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        // 技术点: backgroundView在contentView的下面
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

// 技术点: 在layoutSubViews中, 可以多干一些事情
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    imageRect.origin.x = 10;
    self.imageView.frame = imageRect;
    
    if (self.imageView.image != nil) {
        CGRect labelRect = self.textLabel.frame;
        labelRect.origin.x = CGRectGetMaxX(self.imageView.frame);
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
