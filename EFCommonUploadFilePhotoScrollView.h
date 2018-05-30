//
//  MyScrollView.h
//  PhotoDamo
//
//  Created by Miller on 16/4/3.
//  Copyright © 2016年 Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SingleTapBlock)(void);

@interface EFCommonUploadFilePhotoScrollView : UIScrollView

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,copy) NSURL *imageUrl;

@property (nonatomic,copy) UIImage *photoImage;

@property (nonatomic,copy) SingleTapBlock singleCallback;

@end
