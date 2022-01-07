//
//  UITableView+BCHelper.m
//  BCUIKit
//
//  Created by Basic. on 2019/8/16.
//

#import "UITableView+BCHelper.h"

@implementation UITableView (BCHelper)

///MARK: - UITable
- (__kindof UITableViewCell *)bc_cellWithClassName:(NSString *)clsName
{
    NSString *identity = clsName ? : @"UITableViewCell";
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        Class clazz = NSClassFromString(identity);
        // 兼容swift获取class
        if (!clazz) {
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *workName = [infoDict valueForKey:@"CFBundleExecutable"];
            NSString *className = [NSString stringWithFormat:@"%@.%@",workName,identity];
            clazz = NSClassFromString(className);
        }
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
- (__kindof UITableViewHeaderFooterView *)bc_headerFooterWithClassName:(NSString *)clsName {
    NSString *identity = clsName ? : @"UITableViewHeaderFooterView";
    UITableViewHeaderFooterView *view = [self dequeueReusableHeaderFooterViewWithIdentifier:identity];
    if (!view) {
        Class clazz = NSClassFromString(identity);
        // 兼容swift获取class
        if (!clazz) {
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *workName = [infoDict valueForKey:@"CFBundleExecutable"];
            NSString *className = [NSString stringWithFormat:@"%@.%@",workName,identity];
            clazz = NSClassFromString(className);
        }
        view = [[clazz alloc] initWithReuseIdentifier:identity];
    }
    return view;
}
///MARK: - scroll
- (void)bc_scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0, 0) animated:animated];
}
- (void)bc_scrollToBottomAnimated:(BOOL)animated {

    if (self.numberOfSections == 0) {
        return;
    }
    NSInteger row = [self numberOfRowsInSection:(self.numberOfSections - 1)];
    if (row < 1) {
        return;
    }
    // 延迟在主线程执行防止抖动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(row-1) inSection:(self.numberOfSections - 1)];
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];
    });
}

@end
