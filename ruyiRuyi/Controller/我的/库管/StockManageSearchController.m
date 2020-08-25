//
//  StockManageSearchController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "StockManageSearchController.h"
@interface StockManageSearchController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation StockManageSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.text = self.searchContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (self.view == touch.view) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)resetAction:(id)sender {
    
    if (self.searchBlock) {
        self.textField.text = @"";
        self.searchBlock(@"");
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)searchAction:(id)sender {
    if (self.searchBlock) {
        self.searchBlock(self.textField.text);
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
