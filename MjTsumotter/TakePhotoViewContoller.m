//
//  TakePhotoViewContoller.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TakePhotoViewContoller.h"
#import "MjTsumotterAppDelegate.h"
#import "MjTsumotterViewContoller.h"

typedef enum{
    MJTSelectPhotoTypeCamera,
    MJTSelectPhotoTypePhotoLibrary,
    MJTSelectPhotoTypeMax
} MJTSelectPhotoType;

static float        TEHAI_AREA_X                = 100.0;
static float        TEHAI_AREA_Y                =  13.5;
static float        TEHAI_AREA_WIDTH            = 120.0;
static float        TEHAI_AREA_HEIGHT           = 400.0;

@implementation TakePhotoViewContoller

@synthesize cameraViewCtl   = _cameraViewCtl;

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.title = @"手牌を送る";
        
        CGRect tehaiRect                = CGRectMake(TEHAI_AREA_X, 
                                                     TEHAI_AREA_Y, 
                                                     TEHAI_AREA_WIDTH, 
                                                     TEHAI_AREA_HEIGHT);
        _cameraViewCtl                  = [[TehaiCameraViewController alloc] initWithTehaiArea:tehaiRect];
        self.cameraViewCtl.delegate     = self;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ナビゲーションバーの内容を設定
    cameraButton_   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera 
                                                                    target:self 
                                                                    action:@selector(takePhoto:)
                       ];
    self.navigationItem.leftBarButtonItem   = cameraButton_;
    
    sendButton_     = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
                                                                    target:self 
                                                                    action:@selector(sendAgariPhoto:)
                       ];
    self.navigationItem.rightBarButtonItem  = sendButton_;

    // 手牌写真の表示枠を設定
    photoLabel_     = [[UILabel alloc] initWithFrame:CGRectMake( 10.0, 
                                                                 10.0, 
                                                                IPHONE_DEVICE_SIZE_WIDTH - 20.0, 
                                                                 90.0)
                       ];
    photoLabel_.textAlignment = UITextAlignmentCenter;
    photoLabel_.text = @"手牌の画像を設定してください";
    [self.view addSubview:photoLabel_];
    
    photoView_      = [[UIImageView alloc] initWithFrame:CGRectMake( 10.0, 
                                                                     10.0, 
                                                                    IPHONE_DEVICE_SIZE_WIDTH - 20.0, 
                                                                     90.0)];
    photoView_.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:photoView_];
    
    // 場風選択を設定
    bakazeLabel_    = [[UILabel alloc] initWithFrame:CGRectMake( 10.0, 
                                                                110.0, 
                                                                IPHONE_DEVICE_SIZE_WIDTH - 20.0, 
                                                                 20.0)
                       ];
    bakazeLabel_.textAlignment = UITextAlignmentLeft;
    bakazeLabel_.text = @"場風";
    [self.view addSubview:bakazeLabel_];
    
    bakazeSelect_   = [[UISegmentedControl alloc] initWithFrame:CGRectMake( 30.0, 
                                                                           135.0, 
                                                                           IPHONE_DEVICE_SIZE_WIDTH - 60.0, 
                                                                            40.0)
                       ];
    bakazeSelect_.segmentedControlStyle = UISegmentedControlStylePlain;
    [bakazeSelect_ insertSegmentWithTitle:@"東" 
                                  atIndex:0 
                                 animated:NO];
    [bakazeSelect_ insertSegmentWithTitle:@"南" 
                                  atIndex:1 
                                 animated:NO];
    [bakazeSelect_ insertSegmentWithTitle:@"西" 
                                  atIndex:2 
                                 animated:NO];
    [bakazeSelect_ insertSegmentWithTitle:@"北" 
                                  atIndex:3 
                                 animated:NO];
    bakazeSelect_.selectedSegmentIndex = 0;
    [self.view addSubview:bakazeSelect_];
    
    // 自風選択を設定
    jikazeLabel_    = [[UILabel alloc] initWithFrame:CGRectMake( 10.0, 
                                                                185.0, 
                                                                IPHONE_DEVICE_SIZE_WIDTH - 20.0, 
                                                                 20.0)
                       ];
    jikazeLabel_.textAlignment = UITextAlignmentLeft;
    jikazeLabel_.text = @"自風";
    [self.view addSubview:jikazeLabel_];
    
    jikazeSelect_   = [[UISegmentedControl alloc] initWithFrame:CGRectMake( 30.0, 
                                                                           210.0, 
                                                                           IPHONE_DEVICE_SIZE_WIDTH - 60.0, 
                                                                           40.0)
                       ];
    jikazeSelect_.segmentedControlStyle = UISegmentedControlStylePlain;
    [jikazeSelect_ insertSegmentWithTitle:@"東" 
                                  atIndex:0 
                                 animated:NO];
    [jikazeSelect_ insertSegmentWithTitle:@"南" 
                                  atIndex:1 
                                 animated:NO];
    [jikazeSelect_ insertSegmentWithTitle:@"西" 
                                  atIndex:2 
                                 animated:NO];
    [jikazeSelect_ insertSegmentWithTitle:@"北" 
                                  atIndex:3 
                                 animated:NO];
    jikazeSelect_.selectedSegmentIndex = 0;
    [self.view addSubview:jikazeSelect_];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/**
 * アクションシートでボタンが押された場合
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // キャンセルボタンが押された場合は抜ける
    if (buttonIndex >= MJTSelectPhotoTypeMax) {
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    switch (buttonIndex) {
        case MJTSelectPhotoTypeCamera:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case MJTSelectPhotoTypePhotoLibrary:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    
    // 使用可能かどうかチェックする
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {  
        return;
    }
    
    switch (sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
            [self presentModalViewController:self.cameraViewCtl.cameraPicker animated:YES];
            break;
        case UIImagePickerControllerSourceTypePhotoLibrary:
            break;
        default:
            break;
    }
}

- (void)takePhoto:(id)sender
{
    UIActionSheet * sheet_ = [[UIActionSheet alloc] initWithTitle:nil 
                                                         delegate:self 
                                                cancelButtonTitle:@"キャンセル" 
                                           destructiveButtonTitle:nil 
                                                otherButtonTitles:@"写真を撮る", @"ライブラリから選択", nil];
    [sheet_ showInView:self.tabBarController.view];
    [sheet_ release];
}

- (void)sendAgariPhoto:(id)sender
{
}

- (void)dealloc
{
    [cameraButton_ release];
    [sendButton_ release];
    [photo_ release];
    [photoView_ release];
    [bakazeLabel_ release];
    [bakazeSelect_ release];
    [jikazeLabel_ release];
    [jikazeSelect_ release];
    [_cameraViewCtl release];
    [super dealloc];
}

#pragma mark - TehaiCameraControllerDelegate

- (void)didFinishTakePhoto:(UIImage *)image at:(NSDate *)date
{
    NSLog(@"写真の撮影に成功した");
    // イメージピッカーを隠す
    [self dismissModalViewControllerAnimated:YES];
    
    NSLog(@"width:%f height:%f date:%@", image.size.width, image.size.height, date);
}

- (void)didCancelTakePhoto
{
    NSLog(@"写真の撮影がキャンセルされた");
    // イメージピッカーを隠す
    [self dismissModalViewControllerAnimated:YES];
}

@end
