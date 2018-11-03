//
//  GXAddTagController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/11/1.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXAddTagController.h"
#import "GXTagTextField.h"

@interface GXAddTagController ()
/**内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 文字框 */
@property (nonatomic, strong) UITextField *textField;
/** 添加的按钮 */
@property (nonatomic, strong) UIButton *addButton;
/** 记录前一个tag */
@property (nonatomic, strong) UIButton *recordTagButton;
/** 储存所有标签 */
@property (nonatomic, strong) NSMutableArray *tagArray;
@end

@implementation GXAddTagController
#pragma mark - 懒加载
- (NSMutableArray *)tagArray
{
    if (_tagArray == nil) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}

- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.width = self.contentView.width;
        _addButton.height = 30;
        _addButton.backgroundColor = [UIColor greenColor];
        [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_addButton];
        _addButton.hidden = YES;
    }
    return _addButton;
}

#pragma mark - 按钮点击事件
- (void)tagButtonClicked:(UIButton *)button
{
    // 删除
    [button removeFromSuperview];
    [self.tagArray removeObject:button];
    
    // 重新布局
    [self tagButtonLayout];
    [self textFieldLayout];
}

- (void)addButtonClicked
{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tagButton.backgroundColor = [UIColor blueColor];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [tagButton addTarget:self action:@selector(tagButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //    CGSize tagSize = [tagButton.currentTitle boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : tagButton.titleLabel.font} context: nil].size;
    //    tagButton.size = CGSizeMake(tagSize.width, 30);
    // 知识点: sizeToFit很好用, 可以替换上面的一坨方法
    [tagButton sizeToFit];
    
    // 添加数组
    [self.tagArray addObject:tagButton];
    
    // 添加到界面
    [self.contentView addSubview:tagButton];
    
    
    // 创建完成后隐藏按钮
    self.addButton.hidden = YES;
    
    // 清空文本框
    self.textField.text = nil;
    
    // 布局
    [self tagButtonLayout];
    [self textFieldLayout];
    
}

/**
 * 知识点: textView用代理监听, 没有问, textField用代理监听, 打英文没有问题, 打中文选着字的时候有问题
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    // 更新textField的frame
    [self textFieldLayout];
    
    if (textField.hasText) {// 有文字创建button
        [self.addButton setHidden:NO];
        self.addButton.y = CGRectGetMaxY(textField.frame) + 10;
        [self.addButton setTitle:textField.text forState:UIControlStateNormal];
    } else { // 没有文字隐藏button
        [self.addButton setHidden:YES];
    }
}


#pragma mark - 布局重组
- (void)tagButtonLayout
{
    self.recordTagButton = nil;
    UIButton *recordBtn;
    for (UIButton *tagButton in self.tagArray) {
        if (SCR_WIDTH - CGRectGetMaxX(recordBtn.frame) > tagButton.width) {
            tagButton.x = CGRectGetMaxX(recordBtn.frame) + 10;
            tagButton.y = recordBtn.y;
        } else {
            tagButton.x = 10;
            tagButton.y = CGRectGetMaxY(recordBtn.frame) + 10;
        }
        recordBtn = tagButton;
        
        self.recordTagButton = tagButton;
    }
}

- (void)textFieldLayout
{
    // 调整textField位置
    //       CGSize textSize = [textField.text boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textField.font} context:nil].size;
    
    // 知识点: 如果只计算一行, 用下面的这个最简单
    CGSize textSize = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}];
    
    if (textSize.width > SCR_WIDTH - (CGRectGetMaxX(self.recordTagButton.frame) + 10)) {
        self.textField.y = CGRectGetMaxY(self.recordTagButton.frame) + 10;
        self.textField.x = 10;
    } else {
        self.textField.x = CGRectGetMaxX(self.recordTagButton.frame) + 10;
        self.textField.y = self.recordTagButton.y;
    }
}



#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupContentView];

    [self setupTextField];
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = 5;
    contentView.width = SCR_WIDTH - 2 * contentView.x;
    contentView.height = SCR_HEIGHT;
    contentView.y = 5;
    self.contentView = contentView;
    [self.view addSubview:contentView];
}

- (void)setupTextField
{
    __weak typeof(self) weakSelf = self;
    GXTagTextField *textField = [[GXTagTextField alloc] init];
    textField.deleteBlock = ^{
        if (!weakSelf.textField.hasText) {
            [weakSelf tagButtonClicked:[self.tagArray lastObject]];
        }
    };
    self.textField = textField;
    textField.x = 10;
    textField.y = 0;
    textField.width = 300;
    textField.height = 30;
    textField.placeholder = @"每个文字用逗号或者回车隔开!";
    textField.backgroundColor = [UIColor redColor];
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.navigationController.navigationBar.translucent = NO;
}




- (void)done:(UIButton *)sender
{
    
}

@end
