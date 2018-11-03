//
//  OCExampleController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2018/10/11.
//  Copyright © 2018年 JasonBourne. All rights reserved.
//

#import "OCExampleController.h"

@interface OCExampleController ()
/** 数组 */
@property (nonatomic, strong) NSMutableArray *viewsArr;
@end

@implementation OCExampleController

- (NSMutableArray *)viewsArr
{
    if (_viewsArr == nil) {
        _viewsArr = [NSMutableArray array];
    }
    return _viewsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}



#pragma mark - 让数组里面的所有控件执行同一个方法
- (void)example1
{
    for (int i = 0; i < 3; i++) {
        CGFloat w = 30;
        CGFloat h = 30;
        CGFloat x = 10 + (i * (w + 10));
        CGFloat y = 100;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        v.backgroundColor = [UIColor redColor];
        [self.view addSubview:v];
        [self.viewsArr addObject:v];
    }
    
    /** 让数组里面的所有控件执行同一个方法 */
    [self.viewsArr makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor greenColor]];
}

@end
