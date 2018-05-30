//
//  GJImagePreCollectionViewCell.m
//  ImageScrollManger
//
//  Created by Miller on 2018/5/30.
//  Copyright © 2018年 Miller. All rights reserved.
//

#import "GJImagePreCollectionViewCell.h"
#import "EFCommonUploadFileExpandImageView.h"

@interface GJImagePreCollectionViewCell()

@property (nonatomic,strong) EFCommonUploadFileExpandImageView *expandImageView;

@end

@implementation GJImagePreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.expandImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.expandImageView.frame = self.contentView.bounds;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    
    self.expandImageView.imageUrl = [NSURL URLWithString:_imageUrl];
//    self.expandImageView.imageName = _imageUrl;
}

- (EFCommonUploadFileExpandImageView *)expandImageView {
    if (!_expandImageView) {
        _expandImageView = [[EFCommonUploadFileExpandImageView alloc] initWithFrame:self.contentView.bounds];
    }
    return _expandImageView;
}

@end
