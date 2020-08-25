//
//  OrderGoodsSearchController.m
//  ruyiRuyi
//
//  Created by yym on 2020/5/31.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "OrderGoodsSearchController.h"

@interface OrderGoodsSearchController ()

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;

@end

@implementation OrderGoodsSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([self.searchDic.allKeys containsObject:@"brand"]) {
        self.textField1.text = self.searchDic[@"brand"];
    }
    if ([self.searchDic.allKeys containsObject:@"diameter"]) {
        self.textField2.text = self.searchDic[@"diameter"];

    }
    if ([self.searchDic.allKeys containsObject:@"type"]) {
        self.textField3.text = self.searchDic[@"type"];

    }
    if ([self.searchDic.allKeys containsObject:@"flgurename"]) {
        self.textField4.text = self.searchDic[@"flgurename"];

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if (self.view == touch.view) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)resetAction:(id)sender {
    
    self.textField1.text = @"";
    self.textField2.text = @"";
    self.textField3.text = @"";
    self.textField4.text = @"";
}

- (IBAction)searchAction:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (self.textField1.text.length > 0) {
        [dic setObject:self.textField1.text forKey:@"brand"];
    }
    if (self.textField2.text.length > 0) {
        [dic setObject:self.textField2.text forKey:@"diameter"];
    }
    if (self.textField3.text.length > 0) {
        [dic setObject:self.textField3.text forKey:@"type"];
    }
    if (self.textField4.text.length > 0) {
        [dic setObject:self.textField4.text forKey:@"flgurename"];
    }    
    if (self.searchBlock) {
        
        self.searchBlock(dic);
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
@end
