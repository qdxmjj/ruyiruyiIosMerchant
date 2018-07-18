//
//  TireRepairBarCodeCell.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/6/27.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "TireRepairBarCodeCell.h"
#import "JJMacro.h"
@interface TireRepairBarCodeCell ()

@property(nonatomic,copy)UILabel *numerLab;
@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *chuLab;

@property (weak, nonatomic) IBOutlet UIButton *plusBtn;

@property (weak, nonatomic) IBOutlet UIButton *lessBtn;
@property (weak, nonatomic) IBOutlet UILabel *valueLab;

@property(nonatomic,assign)CGFloat minValue;
@property(nonatomic,assign)CGFloat maxValue;
@property(nonatomic,assign)CGFloat value;
@property(nonatomic,assign)CGFloat stepValue;

@end
@implementation TireRepairBarCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self.contentView addSubview:self.numerLab];
        
        //默认值
        _stepValue = 1;
        _minValue = 0;
        _maxValue = 3;
        self.value = 0;

    }
    return self;
}


- (IBAction)valueChangeEvent:(UIButton *)sender {
    
    if ([sender isEqual: _plusBtn]) {
        
        self.value = _value + _stepValue;
    }
    
    if ([sender isEqual: _lessBtn]) {
        
        self.value = _value - _stepValue;
    }
    
    self.updateBlock(_value);
}

-(void)setValue:(CGFloat)value{
    
    if (value < _minValue) {
        
        value = _minValue;
    }
    else if (value > _maxValue){
        value = _maxValue;
    }
    
    _lessBtn.enabled = value > _minValue;
    _plusBtn.enabled = value < _maxValue;
    self.valueLab.text = [NSString stringWithFormat:@"%.0f",value];
    _value = value;
    
    
}

-(void)setMaxValue:(CGFloat)maxValue{
    
    if (maxValue < _minValue) {
        maxValue = _minValue;
    }
    _maxValue = maxValue;
}

-(void)setMinValue:(CGFloat)minValue{
    
    if (minValue > _maxValue) {
        minValue = _maxValue;
    }
    _minValue = minValue;
}

-(void)setModel:(TireRepairBarCodeModel *)model{
    
//    if ([self.valueLab.text integerValue] < model.repairAmount) {
//
//        self.value = model.repairAmount;
//    }
    self.maxValue -= model.repairAmount;
    self.barCodelab.text = model.barCode;
    self.numerLab.text = [NSString stringWithFormat:@"%ld", (long)model.repairAmount];
}

-(void)setStepperViewHidden:(BOOL)hidden{
    
    self.view.hidden = !hidden;
    self.chuLab.hidden = !hidden;
    self.numerLab.hidden = hidden;
}

-(UILabel *)numerLab{
    
    if (!_numerLab) {
        
        _numerLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-16, 0, 20, self.frame.size.height)];
        _numerLab.textAlignment = NSTextAlignmentRight;
        _numerLab.hidden = YES;
    }
    
    
    return _numerLab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
