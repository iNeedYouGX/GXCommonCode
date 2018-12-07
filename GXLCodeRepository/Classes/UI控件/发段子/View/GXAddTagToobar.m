//
//  GXAddTagToobar.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/11/1.
//  Copyright © 2018 JasonBourne. All rights reserved.
//

#import "GXAddTagToobar.h"
#import "GXAddTagController.h"

@implementation GXAddTagToobar

// 这个方法可以写成View的分类, 在view的分类UIVIew+Extension.h中可以查看
//+ (instancetype)addTagToolbar
//{
//    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIButton *addBtn = [[UIButton alloc] init];
    
    // 复习一下bundle加载方式
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PostImage.bundle" ofType:nil];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    // 加载图片带有bundle的方法
    UIImage *addImage = [UIImage imageNamed:@"mine-my-post.png" inBundle:bundle compatibleWithTraitCollection:nil];
    
    // 设置图片
    [addBtn setImage:addImage forState:UIControlStateNormal];
    
    // 获取图片的尺寸
//    addBtn.size = [addBtn imageForState:UIControlStateNormal].size;
    addBtn.size = addBtn.currentImage.size;
    
    [addBtn addTarget:self action:@selector(addTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:addBtn];
}

- (void)addTagBtn:(UIButton *)sender
{
    NSLog(@"%@", sender);
    GXAddTagController *vc = [[GXAddTagController alloc] init];
    UIViewController *superVc = (UIViewController *)[self superview].nextResponder;
    superVc.hidesBottomBarWhenPushed = YES;
    [superVc.navigationController pushViewController:vc animated:YES];
    
    /**
     * 知识点:如果是modal出来的控制器,A 模态 B, A的presentedViewController属性就是B
                                           B的presentingViewController属性就是A
     */
}


@end
