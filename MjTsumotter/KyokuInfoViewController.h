//
//  KyokuInfoViewController.h
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MjAgari.h"

@interface KyokuInfoViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableViewCell *imgCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *is_tsumoCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *jikazeCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *bakazeCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *doraNumCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *honbaNumCell;

@property (nonatomic, retain) MjAgari *agari;

- (IBAction)is_tsumoChanged:(id)sender;

- (id)initWithMjAgari:(MjAgari *)agari;

@end
