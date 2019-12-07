//
//  GXRACTestController.m
//  GXLCodeRepository
//
//  Created by JasonBourne on 2019/6/18.
//  Copyright © 2019 JasonBourne. All rights reserved.
//

#import "GXRACTestController.h"
#import <Masonry.h>
#import "RACPerson.h"

@interface GXRACTestController ()
/** <#注释#> */
@property (nonatomic, assign) CGFloat width1;
/** <#注释#> */
@property (nonatomic, strong) UIButton *btn;
/** <#注释#> */
@property (nonatomic, strong) RACPerson *p;
@end

@implementation GXRACTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *redView = [[UIButton alloc] init];
    redView.userInteractionEnabled = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.bottom.right.equalTo(@-10);
    }];
    _btn = redView;

    RACPerson *p = [[RACPerson alloc] init];
    _p = p;
    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int index = 0;
    index++;
    _p.name1 = [NSString stringWithFormat:@"name-%d", index];
    NSLog(@"%@", _p.name1xxxxxxxxxx);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
