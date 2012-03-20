//
//  AgariDetailTableViewController.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/29.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agari.h"

@interface AgariDetailTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView                 *photoView_;
    UITableView                 *_tableView;
    NSInteger                   index_;
}

@property(nonatomic, readonly, retain)  UITableView                     *tableView;

- (id)initWithIndex:(NSInteger)index;
- (id)initWithAgari:(Agari *)agari;

@end
