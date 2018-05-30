//
//  EFCommonUploadFileExpandImageView.h
//  ielts
//
//  Created by Miller on 16/3/28.
//  Copyright © 2016年 Pppppat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DissmissBlcok)(void);

@interface EFCommonUploadFileExpandImageView : UIView

@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,copy) NSURL *imageUrl;

@property (nonatomic,copy) UIImage *photoImage;

@property (nonatomic,copy) DissmissBlcok dismissBlock;

@end
