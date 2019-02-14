//
//  ViewController.m
//  XWSlider
//
//  Created by mac on 2019/1/31.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"
#import "XWSlider.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    XWSlider *slider = [[XWSlider alloc] init];
    slider.minimumValue = 80;
    slider.maximumValue = 100;
    slider.isAnimalShow = YES;
    slider.scale = 5;
    [self.view addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 50));
        make.center.equalTo(self.view);
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
