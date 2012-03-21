//
//  KyokuInfoViewController.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MjAgari.h"

@interface KyokuInfoViewController : UIViewController

@property (nonatomic, retain)IBOutlet UIButton *submitButton;
@property (nonatomic, retain) MjAgari *agari;

- (IBAction)submitButtonDidPress:(id)sender;

- (id)initWithMjAgari:(MjAgari *)agari;

@end
