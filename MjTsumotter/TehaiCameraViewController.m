//
//  TehaiCameraViewController.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 12/03/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TehaiCameraViewController.h"
#import "MjTsumotterAppDelegate.h"

static float        CAMERA_FRAME_HEIGHT         = 427.0;

static float        LABEL_TEHAIAREA_BORDER      =   2.0;

static float        BUTTON_SHOOTTEHAI_X         = 110.0;
// iPhone Height(480) - Camera Height(427) - Shoot Button(40) = 13
// Camera Height(427) + 13 / 2 = 433
static float        BUTTON_SHOOTTEHAI_Y         = 433.0;
static float        BUTTON_SHOOTTEHAI_WIDTH     = 100.0;
static float        BUTTON_SHOOTTEHAI_HEIGHT    =  40.0;
static float        BUTTON_SHOOTTEHAI_RADIUS    =   5.0;

static NSString     *kImageResourceCamera       = @"UITabBarCamera.png";

static NSString     *kImageMetadataExifKey      = @"{Exif}";
static NSString     *kImageExifOriginalDateKey  = @"DateTimeOriginal";

@implementation TehaiCameraViewController

@synthesize delegate        = _delegate;
@synthesize tehaiRect       = _tehaiRect;
@synthesize cameraPicker    = _cameraPicker;
@synthesize overlayView     = _overlayView;
@synthesize areaLabel       = _areaLabel;
@synthesize messageLabel    = _messageLabel;
@synthesize shootButton     = _shootButton;

- (id)initWithTehaiArea:(CGRect)rect
{
    self    = [super init];
    if (self != nil) {
        _tehaiRect                  = rect;
        [self setupCameraView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_cameraPicker release];
    [_overlayView release];
    [_areaLabel release];
    [_messageLabel release];
    [_shootButton release];
    [super dealloc];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // オリジナル画像を取得する
    UIImage *original           = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    NSDictionary *metadata      = (NSDictionary *)[info objectForKey:UIImagePickerControllerMediaMetadata];
    NSDictionary *exif          = (NSDictionary *)[metadata objectForKey:kImageMetadataExifKey];
    NSString *dateStr           = (NSString *)[exif objectForKey:kImageExifOriginalDateKey];
    
    // 転送用画像を取得する
    CGRect rect                 = CGRectMake(self.tehaiRect.origin.y    * (original.size.width / CAMERA_FRAME_HEIGHT), 
                                             self.tehaiRect.origin.x    * (original.size.height / IPHONE_DEVICE_SIZE_WIDTH), 
                                             self.tehaiRect.size.height * (original.size.width / CAMERA_FRAME_HEIGHT), 
                                             self.tehaiRect.size.width  * (original.size.height / IPHONE_DEVICE_SIZE_WIDTH));
    CGImageRef imageRef         = CGImageCreateWithImageInRect([original CGImage], rect);
    UIImage *cropped            = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    // 撮影日付をNSDate型に変換する
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormatExifDate];
    NSDate *originalDate        = [formatter dateFromString:dateStr];
    
    // delegateに取得したデータを渡す
    if ([self.delegate respondsToSelector:@selector(didFinishTakePhoto:at:)]) {
        [self.delegate didFinishTakePhoto:[cropped copy] at:[originalDate copy]];
    }
    [cropped release];
    [originalDate release];
    [formatter release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([self.delegate respondsToSelector:@selector(didCancelTakePhoto)]) {
        [self.delegate didCancelTakePhoto];
    }
}

#pragma mark - TehaiCameraViewController

- (void)setupCameraView
{
    _cameraPicker                           = [[UIImagePickerController alloc] init];
    self.cameraPicker.sourceType            = UIImagePickerControllerSourceTypeCamera;
    self.cameraPicker.delegate              = self;
    
    self.cameraPicker.view.backgroundColor  = [UIColor blackColor];
    // 撮影後のプレビューを表示させないために、コントローラを非表示にする. 
    self.cameraPicker.showsCameraControls   = NO;
    // 撮影エリアをフル画面表示にする. 
    // 2012/03/07 CGAffineTransformScaleは単純に拡大表示される(単なるデジタルズーム)だけのため、
    // 実際に撮影した画像と倍率が異なるため使わない. 
//    self.cameraPicker.navigationBarHidden      = YES;
//    self.cameraPicker.wantsFullScreenLayout    = YES;
//    self.cameraPicker.cameraViewTransform      = CGAffineTransformScale(self.cameraPicker.cameraViewTransform, 
//                                                                        1.3, 
//                                                                        1.3);
    CGRect overlayViewRect                  = CGRectMake(ZERO_VALUE_FLOAT, 
                                                         ZERO_VALUE_FLOAT, 
                                                         IPHONE_DEVICE_SIZE_WIDTH, 
                                                         IPHONE_DEVICE_SIZE_HEIGHT);
    _overlayView                            = [[UIView alloc] initWithFrame:overlayViewRect];
    
    // 手牌撮影エリアをオーバーレイに追加する
    _areaLabel                              = [[UILabel alloc] initWithFrame:self.tehaiRect];
    self.areaLabel.backgroundColor          = [UIColor clearColor];
    self.areaLabel.layer.borderColor        = [UIColor orangeColor].CGColor;
    self.areaLabel.layer.borderWidth        = LABEL_TEHAIAREA_BORDER;
    [self.overlayView addSubview:self.areaLabel];
    
    // 独自の撮影ボタンをオーバーレイに追加する
    CGRect shootRect                        = CGRectMake(BUTTON_SHOOTTEHAI_X, 
                                                         BUTTON_SHOOTTEHAI_Y, 
                                                         BUTTON_SHOOTTEHAI_WIDTH, 
                                                         BUTTON_SHOOTTEHAI_HEIGHT);
    _shootButton                            = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shootButton.frame                  = shootRect;
    self.shootButton.layer.cornerRadius     = BUTTON_SHOOTTEHAI_RADIUS;
    [self.shootButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.shootButton setImage:[UIImage imageNamed:kImageResourceCamera] 
                      forState:UIControlStateNormal];
    [self.shootButton addTarget:self.cameraPicker
                         action:@selector(takePicture) 
               forControlEvents:UIControlEventTouchDown];
    [self.overlayView addSubview:self.shootButton];
    
    self.cameraPicker.cameraOverlayView     = self.overlayView;
}

@end
