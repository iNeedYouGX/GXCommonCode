//
//  CZCollectionTypeOneCell.m
//  BestCity
//
//  Created by JasonBourne on 2019/12/23.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "CZCollectionTypeOneCell.h"
#import "UIImageView+WebCache.h"

@interface CZCollectionTypeOneCell ()
/** 最大的背景view */
@property (nonatomic, weak) IBOutlet UIView *backView;

/** 大图片 */
@property (nonatomic, weak) IBOutlet UIImageView *bigImageView;
/** 标题 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/** 副标题 */
@property (nonatomic, weak) IBOutlet UILabel *subTitleLabel;

/** 当前价格 */
@property (nonatomic, weak) IBOutlet UILabel *actualPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actualPriceLabelBottomMragin;
@property (nonatomic, weak) IBOutlet UILabel *otherPricelabel;
/** 券价格 */
@property (nonatomic, weak) IBOutlet UILabel *couponPriceLabel;
/** <#注释#> */
@property (nonatomic, weak) IBOutlet UIView *couponPriceView;
/**  */
@property (nonatomic, weak) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feeLabelMargin;
/** <#注释#> */
@property (nonatomic, weak) IBOutlet UILabel *volumeLabel;
@property (nonatomic, weak) IBOutlet UILabel *buyRateLabel;
@end

@implementation CZCollectionTypeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"img"]]];
    self.titleLabel.text = dataDic[@"otherName"];

    self.subTitleLabel.text = dataDic[@"shopName"];
    self.buyRateLabel.text = [NSString stringWithFormat:@"%@折", dataDic[@"buyRate"]];


    NSString *buyBtnStr = [NSString stringWithFormat:@"¥%.2f", [dataDic[@"buyPrice"] floatValue]];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:buyBtnStr];
    [attrStr addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xE25838), NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Medium" size: 18]} range:NSMakeRange(0, attrStr.length)];
    [attrStr addAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Medium" size: 11]} range:NSMakeRange(0, 1)];

    self.actualPriceLabel.attributedText = attrStr;



    NSString *other = [NSString stringWithFormat:@"¥%.2lf", [dataDic[@"otherPrice"] floatValue]];
    self.otherPricelabel.attributedText = [other addStrikethroughWithRange:NSMakeRange(0, other.length)];

    self.couponPriceLabel.text = [NSString stringWithFormat:@"券 ¥%.0f", [dataDic[@"couponPrice"] floatValue]];
    self.feeLabel.text = [NSString stringWithFormat:@"  补贴 ¥%.2f  ", [dataDic[@"fee"] floatValue]];

    if ([self.couponPriceLabel.text isEqualToString:@"券 ¥0"]) {
        self.couponPriceView.hidden = YES;
        self.feeLabelMargin.constant = -50;
        [self layoutIfNeeded];
    } else {
        self.couponPriceView.hidden = NO;
        self.feeLabelMargin.constant = 5;
    }

    if ([self.feeLabel.text isEqualToString:@"  补贴 ¥0.00  "]) {
        [self.feeLabel setHidden:YES];
    } else {
        [self.feeLabel setHidden:NO];
    }

    if ([self.couponPriceLabel.text isEqualToString:@"券 ¥0"] && [self.feeLabel.text isEqualToString:@"  补贴 ¥0.00  "]) {
        [self.feeLabel setHidden:YES];
        self.couponPriceView.hidden = YES;
        self.actualPriceLabelBottomMragin.constant = -24;
    } else {
        [self.feeLabel setHidden:NO];
        self.actualPriceLabelBottomMragin.constant = 8;
    }
    self.volumeLabel.text = [NSString stringWithFormat:@"%@人已买",  dataDic[@"volume"]];

}



@end
