//
//  CollectionAutoLayoutCell.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/4/23.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "CollectionAutoLayoutCell.h"
#import "Masonry.h"
#import <UIImageView+WebCache.h>

@interface CollectionAutoLayoutCell ()

@property (nonatomic ,strong)UIImageView *testImage;

@property (strong, nonatomic)UILabel *testLabel;

@end



@implementation CollectionAutoLayoutCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.testLabel = [UILabel new];
        self.testLabel.numberOfLines = 0;
        [self.contentView addSubview:self.testLabel];
        
        self.testImage = [UIImageView new];
        [self.contentView addSubview:self.testImage];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.testImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.testImage.mas_bottom).offset(10.0);
        make.left.width.mas_equalTo(self.testImage);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(SCR_WIDTH);
        make.bottom.mas_equalTo(self.testLabel.mas_bottom).offset(15.0);
    }];
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.testLabel.text = text;
//    [self.testImage sd_setImageWithURL:[NSURL URLWithString:text]];
}

//- (void)setImg:(UIImage *)img
//{
//    _img = img;
//    self.testImage.image = img;
//
//
//}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];

    CGRect cellFrame = layoutAttributes.frame;

    cellFrame.size.height = size.height;

    layoutAttributes.frame = cellFrame;
    
    return layoutAttributes;
}

/**
 * 返回特定的高, 如果外面实现了高度方法, 还是以外面的为准, 这个高度, 跟外面的高度一直, 不要刷新时跳跳跳
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    UICollectionViewLayoutAttributes *attributes = [layoutAttributes copy];
    
    attributes.size = CGSizeMake(SCR_WIDTH, 120);
    
    return attributes;
}
 */

@end
