//
//  CZCategoryLineLayoutView.m
//  BestCity
//
//  Created by JasonBourne on 2019/12/20.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "CZCategoryLineLayoutView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"


@implementation CZCategoryItem
@end

@implementation CZCategoryButton
- (void)setup
{
    [self setAdjustsImageWhenHighlighted:NO];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:UIColorFromRGB(0x202020) forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;

    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 10;
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width / 2.0;
}

@end

@interface CZCategoryLineLayoutView () <UIScrollViewDelegate>
/** <#注释#> */
@property (nonatomic, strong) void (^block)(CZCategoryItem *);
/** <#注释#> */
@property (nonatomic, strong) UIScrollView *scrollerConentView;
/** 指示器 */
@property (nonatomic, strong) UIView *minline;
/** <#注释#> */
@property (nonatomic, strong) id recordElement;

@end

@implementation CZCategoryLineLayoutView

+ (NSArray *)categoryItems:(NSArray *)items setupNameKey:(NSString *)NameKey imageKey:(NSString *)imageKey IdKey:(NSString *)IdKey objectKey:(NSString *)objectKey
{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in items) {

        if (![dic isKindOfClass:[NSDictionary class]]) {
            CZCategoryItem *item = [[CZCategoryItem alloc] init];
            item.categoryName = (NSString *)dic;
            [list addObject:item];
        } else {
            CZCategoryItem *item = [[CZCategoryItem alloc] init];
            item.categoryName = dic[NameKey];
            item.categoryId = dic[IdKey];
            item.categoryImage = dic[imageKey];
            item.objectInfo = dic[objectKey];
            [list addObject:item];
        }
    }
    return list;
}


+ (instancetype)categoryLineLayoutViewWithFrame:(CGRect)frame Items:(NSArray <CZCategoryItem *> *)items type:(CZCategoryLineLayoutViewType)type didClickedIndex:(void (^)(CZCategoryItem *item))block
{
    CZCategoryLineLayoutView *view = [[CZCategoryLineLayoutView alloc] initWithFrame:frame];
    view.block = block;
    view.categoryItems = items;
    if (type == CZCategoryLineLayoutViewTypeVertical) {
        [view createVerticalView];
    } else if (type == CZCategoryLineLayoutViewTypeLine) {
        [view createLineTitle];
    } else if (type == CZCategoryLineLayoutViewTypeDefault) {
        [view createDefaultView:1];
    } else if (type == CZCategoryLineLayoutViewTypeTwoLine) {
        [view createTwoLine];
    }
    return view;
}


#pragma mark - 创建小组件component, module, element

// 创建scrollerView
- (UIScrollView *)scrollerConentView
{
    if (_scrollerConentView == nil) {
        _scrollerConentView = [[UIScrollView alloc] init];
        _scrollerConentView.frame = CGRectMake(0, 0, self.width, self.height);
        _scrollerConentView.pagingEnabled = YES;
        _scrollerConentView.showsHorizontalScrollIndicator = NO;
        _scrollerConentView.delegate = self;
    }
    return _scrollerConentView;;
}

// 创建上下排布的按钮
- (UIView *)createBtnView:(CGSize)size img:(id)img text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIView *btnView = [[UIView alloc] init];
        btnView.size = size;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.size = CGSizeMake(btnView.width, btnView.width);
        if ([img isKindOfClass:[UIImage class]]) {
            imageView.image = img;
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:img]];
        }
        [btnView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = textColor;
        label.font = font;
        label.text = text;
        [label sizeToFit];
        label.y = btnView.height - label.height;
        label.centerX = btnView.width / 2.0;
        [btnView addSubview:label];
    
    return btnView;
}

// 单独创建一排按钮
- (UIView *)createBtnViewsWithData:(NSArray <CZCategoryItem *> *)data cols:(NSInteger)cols contentSize:(CGSize)contentSize itemWidth:(CGFloat)itemWidth textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    CGFloat space = (contentSize.width - cols * itemWidth) / (cols - 1);
    for (int i = 0; i < cols; i++) {
        CZCategoryItem *item = data[i];
        UIView *btnView = [self createBtnView:CGSizeMake(itemWidth, contentSize.height) img:item.categoryImage text:item.categoryName textColor:textColor font:font];
        btnView.x = i * (itemWidth + space);
        [content addSubview:btnView];
    }
    return content;
}

#pragma mark - 一直往下排布
- (void)createVerticalView
{
    CGFloat width = 50;
    CGFloat height = width + 30;
    NSInteger cols = 5;
    CGFloat space = (self.width - cols * width) / (cols - 1);
    NSInteger count = self.categoryItems.count;
    

    for (int i = 0; i < count; i++) {
        NSInteger colIndex = i % cols;
        NSInteger rowIndex = i / cols;
        CZCategoryItem *item = self.categoryItems[i];
        // 创建按钮
        CZCategoryButton *btn = [CZCategoryButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.width = width;
        btn.height = height;
        btn.x = colIndex * (width + space);
        btn.y = rowIndex * (height + 10);
        [btn sd_setImageWithURL:[NSURL URLWithString:item.categoryImage] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x939393) forState:UIControlStateNormal];
        [btn setTitle:item.categoryName forState:UIControlStateNormal];
        [self addSubview:btn];
        // 点击事件
        [btn addTarget:self action:@selector(categoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.height = CZGetY(btn);
        if (i == 0) {
            self.categoryItem = item;
        }
    }
}

- (void)categoryButtonAction:(CZCategoryButton *)sender
{
    self.categoryItem = self.categoryItems[sender.tag];
    self.categoryItem.index = sender.tag;
    !self.block ? : self.block(self.categoryItem);
}

#pragma mark - 横向排布(一排)
- (void)createLineTitle
{
    [self addSubview:self.scrollerConentView];

    CGFloat width = 45;
    CGFloat height = width + 25;
    CGFloat leftSpace = 24;
    NSInteger cols = 4;
    CGFloat space = (SCR_WIDTH - leftSpace * 2 - cols * width) / (cols - 1);
    CGFloat itemWidth = SCR_WIDTH / cols;
    NSInteger count = self.categoryItems.count;
    NSInteger page = (count + (cols * 2  - 1)) / (cols * 2);;
    for (int i = 0; i < count; i++) {
        CZCategoryItem *item = self.categoryItems[i];
        // 创建按钮
        CZCategoryButton *btn = [CZCategoryButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.width = width;
        btn.height = height;
        btn.x = leftSpace + i * (width + space);
        [btn sd_setImageWithURL:[NSURL URLWithString:item.categoryImage] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x939393) forState:UIControlStateNormal];
        [btn setTitle:item.categoryName forState:UIControlStateNormal];
        [self.scrollerConentView addSubview:btn];
        // 点击事件
        [btn addTarget:self action:@selector(categoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.scrollerConentView.height = CZGetY(btn);

//        CGFloat contentWidth = self.width * ((count + (cols - 1)) / cols);
//        CGFloat contentWidth = self.width * 2;
        // itemWidth 四舍五入
        CGFloat contentWidth = (int)(itemWidth + 0.5) * (i + 1);
        self.scrollerConentView.contentSize = (CGSizeMake(contentWidth, 0));
    }
    self.height = CZGetY(self.scrollerConentView) + 10;

    if (page > 1) {
        // 指示器
        UIView *redLine = [[UIView alloc] init];
        [self addSubview:redLine];
        redLine.tag = 100;
        redLine.width = 50;
        redLine.height = 3;
        redLine.layer.cornerRadius = 1.5;
        redLine.layer.masksToBounds = YES;
        redLine.backgroundColor = UIColorFromRGB(0xD8D8D8);
        redLine.centerX = self.width / 2.0;
        redLine.y = self.height - redLine.height;
        
        UIView *minline = [[UIView alloc] init];
        self.minline = minline;
        minline.width = redLine.width / 2.0;
        minline.height = redLine.height;
        minline.layer.cornerRadius = 1.5;
        minline.layer.masksToBounds = YES;
        [redLine addSubview:minline];
        minline.backgroundColor = UIColorFromRGB(0xE25838);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat itemWidth = SCR_WIDTH / 4;
    NSInteger index = scrollView.contentOffset.x / itemWidth;
    NSLog(@"%ld", (long)index);
    [UIView animateWithDuration:0.25 animations:^{
        if (index == 0) {
            self.minline.transform = CGAffineTransformIdentity;
        } else {
            self.minline.transform = CGAffineTransformMakeTranslation(self.minline.width, 0);
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        self.minline.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - 正常排一排的
- (void)createDefaultView:(NSInteger)type
{
    if (self.height == 0) {
        [CZProgressHUD showProgressHUDWithText:@" 样式4高度等于0!!!!!"];
        [CZProgressHUD hideAfterDelay:1.5];
    }

    UIScrollView *backView = [[UIScrollView alloc] init];
    backView.showsHorizontalScrollIndicator = NO;
    backView.height = self.height;
    backView.width = SCR_WIDTH;
    [self addSubview:backView];

    NSInteger count = self.categoryItems.count;
    CGFloat space = 20;
    CGFloat btnX = 15;
    for (int i = 0; i < count; i++) {
        CZCategoryItem *item = self.categoryItems[i];
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setTitle:item.categoryName forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size: 14];
        [btn setTitleColor:UIColorFromRGB(0x565252) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xE25838) forState:UIControlStateSelected];
        [btn sizeToFit];
        btn.height = 25;
        btn.centerY = backView.height / 2.0;
        btn.x = btnX;
        [backView addSubview:btn];
//        [self.saveBtns addObject:btn];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
        btn.width += 16;
        btnX += (space + btn.width);
        btn.layer.cornerRadius = 3;
        [btn addTarget:self action:@selector(viewTypeFourAction:) forControlEvents:UIControlEventTouchUpInside];
        if (type == 1) {
            btn.backgroundColor = [UIColor whiteColor];
        }

        backView.contentSize = CGSizeMake(btnX, 0);

        if (i == item.selecedIndex) {
            btn.selected = YES;
            self.recordElement = btn;
        }
    }
}

- (void)viewTypeFourAction:(UIButton *)sender
{
    if (self.recordElement == sender) {
        return;
    }

    // 设置选中
    sender.selected = YES;

    // 还原选中
    UIButton *recordElement = self.recordElement;
    recordElement.selected = NO;

    self.categoryItem = self.categoryItems[sender.tag];
    !self.block ? : self.block(self.categoryItem);

    self.recordElement = sender;
}

#pragma mark - 横向排布(两排)

- (void)mylayout:(UIView *)btn index:(NSInteger)i width:(CGFloat)width height:(CGFloat)height space:(CGFloat)space leftSpace:(CGFloat)leftSpace
{
    if (i % 2 == 0) { // 第一排
        NSInteger col = i / 2;
        NSInteger row = i % 2;
        btn.x = leftSpace + col * (width + space);
        btn.y = row * (height + 15);
    } else { // 第二排
        NSInteger col = (i - 1) / 2;
        NSInteger row = i % 2;
        btn.x = leftSpace + col * (width + space);
        btn.y = row * (height + 15);
    }
}

- (void)createTwoLine
{
    [self addSubview:self.scrollerConentView];

    CGFloat width = 45;
    CGFloat height = width + 25;
    CGFloat leftSpace = 20;
    NSInteger cols = 5;
    CGFloat space = (SCR_WIDTH - leftSpace * 2 - cols * width) / (cols - 1);

    NSInteger count = self.categoryItems.count;
    for (int i = 0; i < count; i++) {
        CZCategoryItem *item = self.categoryItems[i];
        // 创建按钮
        CZCategoryButton *btn = [CZCategoryButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.width = width;
        btn.height = height;
        if (i % 2 == 0) { // 第一排
            NSInteger col = i / 2;
            NSInteger row = i % 2;
            btn.x = leftSpace + col * (width + space);
            btn.y = row * (height + 15);
        } else { // 第二排
            NSInteger col = (i - 1) / 2;
            NSInteger row = i % 2;
            btn.x = leftSpace + col * (width + space);
            btn.y = row * (height + 15);
        }

        [btn sd_setImageWithURL:[NSURL URLWithString:item.categoryImage] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x939393) forState:UIControlStateNormal];
        [btn setTitle:item.categoryName forState:UIControlStateNormal];
        [self.scrollerConentView addSubview:btn];
        // 点击事件
        [btn addTarget:self action:@selector(categoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        // itemWidth 四舍五入
        CGFloat contentWidth = (int)(CZGetX(btn) + 0.5);
        self.scrollerConentView.contentSize = (CGSizeMake(contentWidth, 0));

        if (i > 1) {
            self.scrollerConentView.height = btn.height * 2 + 25;
        } else {
            self.scrollerConentView.height = (CZGetY(btn));
        }
    }

    self.height = CZGetY(self.scrollerConentView) + 10;

    NSInteger page = (count + (cols * 2  - 1)) / (cols * 2);
    if (page > 1) {
        // 指示器
        UIView *redLine = [[UIView alloc] init];
        [self addSubview:redLine];
        redLine.tag = 100;
        redLine.width = 50;
        redLine.height = 3;
        redLine.layer.cornerRadius = 1.5;
        redLine.layer.masksToBounds = YES;
        redLine.backgroundColor = UIColorFromRGB(0xD8D8D8);
        redLine.centerX = self.width / 2.0;
        redLine.y = self.height - redLine.height;

        UIView *minline = [[UIView alloc] init];
        self.minline = minline;
        minline.width = redLine.width / 2.0;
        minline.height = redLine.height;
        minline.layer.cornerRadius = 1.5;
        minline.layer.masksToBounds = YES;
        [redLine addSubview:minline];
        minline.backgroundColor = UIColorFromRGB(0xE25838);
    }
}
@end
