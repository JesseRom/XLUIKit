//
//  ViewController.m
//  XLUIKit
//
//  Created by HONGLUO on 2018/9/12.
//  Copyright © 2018年 HONGLUO. All rights reserved.
//

#import "ViewController.h"
#import "XLUIKit.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    self.label.xl_width = 200;
    self.label.xl_height = 100;
    [self.label xl_moveToCenterOfSuperview];
    
    [self.label xl_setKeywordColor:[UIColor cyanColor] keywork:@"天下第一"];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:17.f];
        _label.textColor = [UIColor xl_colorWithHex:@"333333"];
        _label.text = @"老子天下第一";
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}


@end
