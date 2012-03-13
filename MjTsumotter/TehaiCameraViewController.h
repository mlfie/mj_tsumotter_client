//
//  TehaiCameraViewController.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol TehaiCameraControllerDelegate <NSObject>
@required
- (void)didFinishTakePhoto:(UIImage *)image at:(NSDate *)date;
- (void)didCancelTakePhoto;
@end


@interface TehaiCameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    id<TehaiCameraControllerDelegate>   _delegate;
    CGRect                              _tehaiRect;
    
    UIImagePickerController             *_cameraPicker;

    UIView                              *_overlayView;
    UILabel                             *_areaLabel;
    UILabel                             *_messageLabel;
    UIButton                            *_shootButton;
}

@property(nonatomic, readwrite, assign) id<TehaiCameraControllerDelegate>   delegate;
@property(nonatomic, readonly, assign)  CGRect                              tehaiRect;
@property(nonatomic, readonly, retain)  UIImagePickerController             *cameraPicker;
@property(nonatomic, readonly, retain)  UIView                              *overlayView;
@property(nonatomic, readonly, retain)  UILabel                             *areaLabel;
@property(nonatomic, readonly, retain)  UILabel                             *messageLabel;
@property(nonatomic, readonly, retain)  UIButton                            *shootButton;

- (id)initWithTehaiArea:(CGRect)rect;
- (void)setupCameraView;

@end
