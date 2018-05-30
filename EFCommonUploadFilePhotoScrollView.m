//
//  MyScrollView.m
//  PhotoDamo
//
//  Created by Miller on 16/4/3.
//  Copyright © 2016年 Miller. All rights reserved.
//

#import "EFCommonUploadFilePhotoScrollView.h"
#import "SDWebImageDownloader.h"

@interface EFCommonUploadFilePhotoScrollView ()<UIScrollViewDelegate>
{
    UIImageView *_photoImageView;
}

@end

@implementation EFCommonUploadFilePhotoScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviewsConfig];
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSingleGestureRecognizer];
    }
    return self;
}

- (void)addSingleGestureRecognizer {
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleClicked:)];
    tap1.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClicked:)];
    tap2.numberOfTapsRequired = 2;
    [_photoImageView addGestureRecognizer:tap2];
    
    [tap1 requireGestureRecognizerToFail:tap2];
}

- (void)initSubviewsConfig {
    _photoImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _photoImageView.userInteractionEnabled = YES;
    [self addSubview:_photoImageView];
}

- (void)singleClicked:(UITapGestureRecognizer *)tap {
    if (self.singleCallback) {
        self.singleCallback();
    }
}

- (void)doubleClicked:(UITapGestureRecognizer *)tap {
    CGPoint touchPoint = [tap locationInView:_photoImageView];
    // Zoom
    if (self.zoomScale == self.maximumZoomScale) {
        // Zoom out
        [self setZoomScale:self.minimumZoomScale animated:YES];
        
    } else {
        // Zoom in
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
        
    }
}

#pragma mark - Image

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self displayImageName:_imageName imageUrl:nil image:nil];
}

- (void)setImageUrl:(NSURL *)imageUrl {
    _imageUrl = imageUrl;
    __weak typeof(self) weakSelf = self;
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:_imageUrl options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf displayImageName:nil imageUrl:nil image:image];
        });
    }];
}

- (void)setPhotoImage:(UIImage *)photoImage {
    _photoImage = photoImage;
    [self displayImageName:nil imageUrl:nil image:_photoImage];
}

// Get and display image
- (void)displayImageName:(NSString *)imageName
                imageUrl:(NSURL *)imageUrl
                   image:(UIImage *)image{
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    self.contentSize = CGSizeMake(0, 0);
    
    // Get image from browser as it handles ordering of fetching
    if (imageName) {
        _photoImageView.image = [UIImage imageWithContentsOfFile:imageName];
    }else if(imageUrl){
        
    }else if (image){
        _photoImageView.image = image;
    }
    // Set image
    _photoImageView.hidden = NO;
    // Setup photo frame
    CGRect photoImageViewFrame;
    photoImageViewFrame.origin = CGPointZero;
    photoImageViewFrame.size = _photoImageView.image.size;
    
    _photoImageView.frame = photoImageViewFrame;
    self.contentSize = photoImageViewFrame.size;
    
    // Set zoom to minimum zoom
    [self setMaxMinZoomScalesForCurrentBounds];
    [self setNeedsLayout];
}

#pragma mark - Setup

- (void)setMaxMinZoomScalesForCurrentBounds {
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    // Bail
    if (_photoImageView.image == nil) return;
    
    // Sizes
    CGSize boundsSize = self.bounds.size;
    boundsSize.width -= 0.1;
    boundsSize.height -= 0.1;
    
    CGSize imageSize = _photoImageView.frame.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // If image is smaller than the screen then ensure we show it at
    // min scale of 1
    if (xScale > 1 && yScale > 1) {
        //minScale = 1.0;
    }
    
    // Calculate Max
    CGFloat maxScale = 4.0; // Allow double scale
    // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
    // maximum zoom scale to 0.5.
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
        
        if (maxScale < minScale) {
            maxScale = minScale * 2;
        }
    }
    
    // Set
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    // Reset position
    _photoImageView.frame = CGRectMake(0, 0, _photoImageView.frame.size.width, _photoImageView.frame.size.height);
    [self setNeedsLayout];    
}

#pragma mark - Layout

- (void)layoutSubviews {
    
    // Super
    [super layoutSubviews];
    
    // Center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _photoImageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(_photoImageView.frame, frameToCenter))
        _photoImageView.frame = frameToCenter;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photoImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
