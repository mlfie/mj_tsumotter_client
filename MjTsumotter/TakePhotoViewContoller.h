//
//  TakePhotoViewContoller.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TehaiCameraViewController.h"

@interface TakePhotoViewContoller : UIViewController <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TehaiCameraControllerDelegate>
{
    UIBarButtonItem                 *cameraButton_;
    UIBarButtonItem                 *sendButton_;
    
    UIImage                         *photo_;
    UILabel                         *photoLabel_;
    UIImageView                     *photoView_;
    UILabel                         *bakazeLabel_;
    UISegmentedControl              *bakazeSelect_;
    UILabel                         *jikazeLabel_;
    UISegmentedControl              *jikazeSelect_;
    
    TehaiCameraViewController       *_cameraViewCtl;
}

@property(nonatomic, readonly, retain)  TehaiCameraViewController           *cameraViewCtl;

- (void)takePhoto:(id)sender;
- (void)sendAgariPhoto:(id)sender;

@end
