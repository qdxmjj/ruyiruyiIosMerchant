//
//  FirstOrderPhotoView.m
//  ruyiRuyi
//
//  Created by yym on 2020/6/22.
//  Copyright © 2020 如驿如意. All rights reserved.
//

#import "FirstOrderPhotoView.h"
#import "ZZYPhotoHelper.h"
@implementation FirstOrderPhotoView

- (IBAction)selectPhoto:(UIButton *)sender {
    
    [[ZZYPhotoHelper shareHelper] showImageViewSelcteWithResultBlock:^(id data) {
        if (data) {
            
            self.photoImgView.image = data;
        }
    }];
}

@end
