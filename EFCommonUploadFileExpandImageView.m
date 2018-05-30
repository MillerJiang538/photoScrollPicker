//
//  EFCommonUploadFileExpandImageView.m
//  ielts
//
//  Created by Miller on 16/3/28.
//  Copyright © 2016年 Pppppat. All rights reserved.
//

#import "EFCommonUploadFileExpandImageView.h"
#import "EFCommonUploadFilePhotoScrollView.h"

@interface EFCommonUploadFileExpandImageView ()

@property (nonatomic,strong) EFCommonUploadFilePhotoScrollView *scrollView;

@end

@implementation EFCommonUploadFileExpandImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.scrollView.imageName = _imageName;
}

- (void)setImageUrl:(NSURL *)imageUrl {
    _imageUrl = imageUrl;
    self.scrollView.imageUrl = _imageUrl;
}

- (void)setPhotoImage:(UIImage *)photoImage {
    _photoImage = photoImage;
    self.scrollView.photoImage = _photoImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[EFCommonUploadFilePhotoScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:self.scrollView];
        __weak typeof(self) weakSelf = self;
        self.scrollView.singleCallback = ^{
            if (weakSelf.dismissBlock) {
                weakSelf.dismissBlock();
            }
        };
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDismiss:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.scrollView = [[EFCommonUploadFilePhotoScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:self.scrollView];
        __weak typeof(self) weakSelf = self;
        self.scrollView.singleCallback = ^{
            if (weakSelf.dismissBlock) {
                weakSelf.dismissBlock();
            }
        };
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDismiss:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickDismiss:(UITapGestureRecognizer *)gesture {
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}


@end
