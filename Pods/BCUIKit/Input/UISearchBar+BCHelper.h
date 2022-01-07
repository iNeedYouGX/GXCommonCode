//
//  UISearchBar+BCHelper.h
//  Pods
//
//  Created by Basic. on 2019/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (BCHelper)
/// 搜索框背景 view
@property (nonatomic, readonly, nullable) UIView *bc_backgroundView;
/// 搜索框文本输入框 view
@property (nonatomic, readonly, nullable) UITextField *bc_searchTextField;

@end

NS_ASSUME_NONNULL_END
