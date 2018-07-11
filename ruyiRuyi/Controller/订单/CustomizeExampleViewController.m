//
//  CustomizeExampleViewController.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/7/5.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

/*
 字体与字体高度 差值表
 font size    font.lineHeight（近似）    差值
 10                  12                  2
 11                  13                  2
 12                  14                  2
 13                  15.5                2.5
 14                  17                  3
 15                  18                  3
 16                  19                  3
 17                  20                  3
 18                  21.5                3.5
 19                  23                  4
 20                  24                  4
 */

#import "CustomizeExampleViewController.h"
#import <Masonry.h>
@interface CustomizeExampleViewController ()

@property(nonatomic,strong)UITextView *contentView;

@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)UIImageView *leftImg;

@property(nonatomic,strong)UIImageView *rigthImg;

@property(nonatomic,strong)UIButton *starPhotograph;

@end

@implementation CustomizeExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"拍照示例";

    [self.view addSubview:self.img];
    [self.view addSubview:self.leftImg];
    [self.view addSubview:self.rigthImg];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.starPhotograph];
}

-(void)setImgNameArr:(NSMutableArray *)imgNameArr{
 
    if (imgNameArr.count<=0) {
        return;
    }
    
    _imgNameArr = imgNameArr;
    
    if (imgNameArr.count == 1) {
        
        self.img.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgNameArr[0] ofType:@"png"]];
        
        
    }else if (imgNameArr.count == 2){
        
        self.img.hidden = YES;
        self.leftImg.hidden = NO;
        self.rigthImg.hidden = NO;
        
        self.leftImg.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgNameArr[0] ofType:@"png"]];
        self.rigthImg.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgNameArr[1] ofType:@"png"]];
        
    }else{
        
    }
}
-(void)setContentArr:(NSMutableArray *)contentArr{
    
    if (contentArr.count<=0) {
        return;
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] init];
    NSString *str = [[NSString alloc] init];
    
    for (str in contentArr) {
        
        str = [NSString stringWithFormat:@" %@\n",str];
        [AttributedStr appendAttributedString:[self AttributedString:str]];
    }
    self.contentView.attributedText = AttributedStr;
}

- (NSMutableAttributedString *)AttributedString:(NSString *)content
{
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",content]];

    // 创建图片图片附件
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"ic_yes"];
    attach.bounds = CGRectMake(0, 0, 20, 20);

    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];

    //将图片插入到合适的位置
    [string insertAttributedString:attachString atIndex:0];
    //设置字体
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:NSMakeRange(0, content.length)];
    //设置文字颜色
    [string addAttribute:NSForegroundColorAttributeName value:[JJTools getColor:@"#5E5E5E"] range:NSMakeRange(0, content.length)];
    
    
    //拿到整体的字符串
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    // 对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    paragraph.lineSpacing = 5;//间距
    paragraph.firstLineHeadIndent = 20.0f;//首行缩进

    paragraph.headIndent = 40.f;//整体缩进(首行除外)
    paragraph.minimumLineHeight = 20;//最低行高
    paragraph.maximumLineHeight = 20;//最大行高
    
    [string addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, content.length)];
    
    //设置偏移量，受图片大小跟文字字体影响，文字与图片会有偏差
    [string addAttribute:NSBaselineOffsetAttributeName value:@(3.5) range:NSMakeRange(1, content.length - 1)];

    return string;
}

-(void)viewWillLayoutSubviews{
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.35);
    }];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).inset(20);
        make.top.mas_equalTo(self.view.mas_top).inset(20);
        make.width.and.height.mas_equalTo(CGSizeMake((self.view.frame.size.width-60)/2,((self.view.frame.size.width-60)/2) * 0.66));
    }];
    
    
    [self.rigthImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right).inset(20);
        make.top.mas_equalTo(self.view.mas_top).inset(20);
        make.width.and.height.mas_equalTo(CGSizeMake((self.view.frame.size.width-60)/2,(self.view.frame.size.width-60)/2 * 0.66));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        if (self.imgNameArr.count == 1) {
            
            make.top.mas_equalTo(self.img.mas_bottom).inset(20);
            
        }else if (self.imgNameArr.count == 2){
            
            make.top.mas_equalTo(self.leftImg.mas_bottom).inset(20);

        }else{
            
            make.top.mas_equalTo(self.view.mas_top).inset(20);
        }
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.3);
    }];
    
    [self.starPhotograph mas_makeConstraints:^(MASConstraintMaker *make) {
       
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {

            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
        
    }];
}


-(UITextView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UITextView alloc] init];
        _contentView.editable = NO;
        _contentView.scrollEnabled = NO;
    }
    return _contentView;
}

-(UIImageView *)img{
    
    if (!_img) {
        
        _img = [[UIImageView alloc] init];
    }
    return _img;
}

-(UIImageView *)leftImg{
    
    if (!_leftImg) {
        
        _leftImg = [[UIImageView alloc] init];
        _leftImg.layer.cornerRadius = 5.f;
        _leftImg.layer.masksToBounds = YES;
        _leftImg.hidden = YES;
    }
    
    return _leftImg;
}

-(UIImageView *)rigthImg{
    
    if (!_rigthImg) {
        
        _rigthImg = [[UIImageView alloc] init];
        _rigthImg.layer.cornerRadius = 5.f;
        _rigthImg.layer.masksToBounds = YES;
        _rigthImg.hidden = YES;
    }
    return _rigthImg;
}

-(UIButton *)starPhotograph{
    
    if (!_starPhotograph) {
        
        _starPhotograph = [UIButton buttonWithType:UIButtonTypeSystem];
        [_starPhotograph setTitle:@"开始拍照" forState:UIControlStateNormal];
        [_starPhotograph.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_starPhotograph setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_starPhotograph setBackgroundColor:JJThemeColor];
        [_starPhotograph addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starPhotograph;
}

-(void)popViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
