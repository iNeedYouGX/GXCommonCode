//
//  GXAttrStringFuncController.m
//  GXLCodeRepository
//
//  Created by JsonBourne on 2020/5/14.
//  Copyright © 2020 JasonBourne. All rights reserved.
//

#import "GXAttrStringFuncController.h"

@interface GXAttrStringFuncController ()

@property (nonatomic, strong) UIScrollView *scrollerView;

@end

@implementation GXAttrStringFuncController

- (UIScrollView *)scrollerView
{
    if (_scrollerView == nil) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT)];
        //    scrollerView.backgroundColor = RANDOMCOLOR;
        _scrollerView.pagingEnabled = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollerView];
    
    [self example1];
    [self example2];
    [self example3];
    
    self.scrollerView.contentSize = CGSizeMake(0, CZGetY([self.scrollerView.subviews lastObject]) + 120);
}

#pragma mark - 基本样式
- (void)example1
{
    [self MTitle:@"1. 创建一个富文本"];
    [self STitle:@"NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:@\"¥4000/月\"];"
     ];
    
    [self MTitle:@"2. 找到\"/\"目标的位置 (location = 5, length = 1)"];
    [self STitle:@"NSRange range = [string rangeOfString:@\"/\"];"];
 
    [self MTitle:@"3. 赋值"];
    [self STitle:@"[attribut addAttributes:param range:range];"];
    
    [self MTitle:@"4. 创建属性"];
    [self SSTitle:@"(1). NSFontAttributeName属性:设置字体属性，默认值：字体：Helvetica(Neue) 字号：12" key:NSFontAttributeName keyStr:@"NSFontAttributeName" value:[UIFont systemFontOfSize:25] valueStr:@"[UIFont systemFontOfSize:25]"];
    
    [self SSTitle:@"(2). 设置字体颜色，取值为UIColor对象，默认值为黑色" key:NSForegroundColorAttributeName keyStr:@"NSForegroundColorAttributeName" value:[UIColor redColor] valueStr:@"[UIColor redColor]"];
    
    [self SSTitle:@"(3). 设置字体所在区域背景颜色，取值为UIColor对象，默认值为nil, 透明色" key:NSBackgroundColorAttributeName keyStr:@"NSBackgroundColorAttributeName" value:[UIColor darkGrayColor] valueStr:@"[UIColor darkGrayColor]"];
    
    [self SSTitle:@"(4). 设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄" key:NSKernAttributeName keyStr:@"NSKernAttributeName" value:@(9) valueStr:@"@(9)"];
    
    [self SSTitle:@"(5). 设置删除线，取值为 NSNumber 对象（整数）" key:NSStrikethroughStyleAttributeName keyStr:@"NSStrikethroughStyleAttributeName" value:@(4) valueStr:@"@(2)"];
    
    [self SSTitle:@"(6). 设置删除线颜色，取值为 UIColor 对象，默认值为黑色" key:NSStrikethroughColorAttributeName keyStr:@"NSStrikethroughColorAttributeName" value:[UIColor redColor] valueStr:@"[UIColor redColor]"];
    
    [self SSTitle:@"(7). 设置下划线，取值为 NSNumber 对象（整数），枚举常量" key:NSUnderlineStyleAttributeName keyStr:@"NSUnderlineStyleAttributeName" value:@(3) valueStr:@"@(3)"];

    [self SSTitle:@"(8). 设置下划线颜色，取值为 UIColor 对象，默认值为黑色" key:NSUnderlineColorAttributeName keyStr:@"NSUnderlineColorAttributeName" value:[UIColor redColor] valueStr:@"[UIColor redColor]"];
    
    [self SSTitle:@"(9). 设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果" key:NSStrokeWidthAttributeName keyStr:@"NSStrokeWidthAttributeName" value:@(3) valueStr:@"@(3)"];
    
    [self SSTitle:@"(10). 填充部分颜色，不是字体颜色，取值为 UIColor 对象" key:NSStrokeColorAttributeName keyStr:@"NSStrokeColorAttributeName" value:[UIColor redColor] valueStr:@"[UIColor redColor]"];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [self SSTitle:@"(11). 设置阴影属性，取值为 NSShadow 对象" key:NSShadowAttributeName keyStr:@"NSShadowAttributeName" value:shadow valueStr:@"NSShadow"];
    
    [self SSTitle:@"(12). 设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用" key:NSTextEffectAttributeName keyStr:@"NSTextEffectAttributeName" value:NSTextEffectLetterpressStyle valueStr:@"NSTextEffectLetterpressStyle"];
    
    [self SSTitle:@"(13). 设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏" key:NSBaselineOffsetAttributeName keyStr:@"NSBaselineOffsetAttributeName" value:@10 valueStr:@"@10"];
    
    [self SSTitle:@"(14). 设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾" key:NSObliquenessAttributeName keyStr:@"NSObliquenessAttributeName" value:@-1 valueStr:@"@-1"];

    [self SSTitle:@"(15). 设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本" key:NSExpansionAttributeName keyStr:@"NSExpansionAttributeName" value:@-1 valueStr:@"@-1"];
 
    [self SSTitle:@"(16). 设置文字书写方向，从左向右书写或者从右向左书写" key:NSWritingDirectionAttributeName keyStr:@"NSWritingDirectionAttributeName" value:@[@(NSWritingDirectionRightToLeft)] valueStr:@"@[@2]"];
    
    [self SSTitle:@"(17). 设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本?" key:NSVerticalGlyphFormAttributeName keyStr:@"NSVerticalGlyphFormAttributeName" value:@0 valueStr:@"@0"];
    
    [self SSTitle:@"(18). 设置链接属性，点击后调用浏览器打开指定URL地址" key:NSLinkAttributeName keyStr:@"NSLinkAttributeName" value:[NSURL URLWithString:@"http://www.baidu.com"] valueStr:@"[NSURL URLWithString:@\"http://www.baidu.com\"]"];
    /* 签订协议, 指定代理人之后. 但点击链接时, 会回调协议方法
        (- textView:shouldInteractWithURL:inRange:)
        textView.delegate = self;
     */
}

#pragma mark - 字符串图片
- (void)example2
{
    NSString *string = @"¥4000/月";
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
    
    [self MTitle:@"5. 创建一个字符串图片"];
    NSString *s1 = @"NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];\n"
    @"attchImage.image = [UIImage imageNamed:@\"1\"];\n"
    @"attchImage.bounds = CGRectMake(0, -5, 20, 20);\n"
    @"NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];\n";
    [self STitle:s1];
    
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 图片
    attchImage.image = [UIImage imageNamed:@"1"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0, -5, 20, 20);
    // 根据图片创建字符串
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    
    [self MTitle:@"6. 将图片字符串插入原来字符串中"];
    NSString *s2 = @"[attribut insertAttributedString:stringImage atIndex:2];";
    [self STitle:s2];
    // 插入字符串中
    [attribut insertAttributedString:stringImage atIndex:2];
    [self exampleLabel:attribut];
}

#pragma mark - 格式&排版
- (void)example3
{
    NSString *string = @"¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月¥4000/月";
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
    
    [self MTitle:@"7. 创建格式&排版"];
    NSString *s1 = @"NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];\nparagraphStyle.alignment = NSTextAlignmentLeft;\nparagraphStyle.lineSpacing = 10;// 调整行间距\nparagraphStyle.firstLineHeadIndent = 6;//首行缩进\nNSRange range = NSMakeRange(0, [string length]);\n[attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];";
    [self STitle:s1];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = 10; // 调整行间距
    paragraphStyle.firstLineHeadIndent = 40;//首行缩进
    NSRange range = NSMakeRange(0, [string length]);
    [attribut addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    [self exampleLabel:attribut];
    
    CGFloat lineSpacing;                 // 字体的行间距
    CGFloat paragraphSpacing;            // 段与段之间的间距
    NSTextAlignment alignment;           // (两端对齐的)文本对齐方式(左,中,右,两端对齐,自然)
    CGFloat firstLineHeadIndent;         // 首行缩进
    CGFloat headIndent;                  // 整体缩进(首行除外)
    CGFloat tailIndent;                  // 尾部缩进
    NSLineBreakMode lineBreakMode;       // 结尾部分的内容以……方式省略
    CGFloat minimumLineHeight;           // 最低行高
    CGFloat maximumLineHeight;           // 最大行高
    NSWritingDirection baseWritingDirection; // 书写方向
    CGFloat lineHeightMultiple;          // 行间距多少倍
    CGFloat paragraphSpacingBefore;      // 段首行空白空
    float hyphenationFactor;             // 连字属性 在iOS，唯一支持的值分别为0和1

}

- (void)MTitle:(NSString *)title
{
    GXElementLabel *mainLabel = [GXElementLabel elementLabelMainTitle:title];
    mainLabel.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:mainLabel];
}

- (void)STitle:(NSString *)title
{
    GXElementView *elementView = [GXElementView elementViewTitle:title];
    elementView.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:elementView];
}

- (void)MImg:(NSString *)imgUrl
{
    GXElementView *elementImage = [GXElementView elementViewImage:imgUrl];
    elementImage.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
    [self.scrollerView addSubview:elementImage];
}

- (void)exampleLabel:(NSAttributedString *)text
{
     UILabel *label = [[UILabel alloc] init];
     label.attributedText = text;
//     label.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 13];
     label.numberOfLines = 0;
     label.textAlignment = NSTextAlignmentCenter;
     label.y = CZGetY([self.scrollerView.subviews lastObject]) + 10;
     label.x = 10;
     label.width = SCR_WIDTH - 20;
     CGSize size = [label sizeThatFits:CGSizeMake(label.width, 10)];
     label.height = size.height;
     [self.scrollerView addSubview:label];
}

- (void)SSTitle:(NSString *)title key:(NSString *)key keyStr:(NSString *)keyStr value:(NSObject *)value valueStr:(NSString *)valueStr
{
    NSString *string = @"¥4000/月";
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSArray *arr = [title componentsSeparatedByString:@". "];
    NSString *s4 = [NSString stringWithFormat:@"%@. %@属性:%@\nparam[%@] = %@;", [arr firstObject], keyStr, [arr lastObject], keyStr, valueStr];
    [self STitle:s4];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[key] = value;
    
    if (key == NSStrikethroughColorAttributeName) {
        dic[NSStrikethroughStyleAttributeName] = @(1);
    }
    if (key == NSUnderlineColorAttributeName) {
        dic[NSUnderlineStyleAttributeName] = @(1);
    }
    if (key == NSStrokeColorAttributeName) {
        dic[NSStrokeWidthAttributeName] = @(3);
    }
    
    [attribut addAttributes:dic range:NSMakeRange(0, string.length)];
    [self exampleLabel:attribut];
}


@end
