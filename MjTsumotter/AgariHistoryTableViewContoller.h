//
//  AgariHistoryTableViewContoller.h
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AgariDetailTableViewController.h"
#import "MjAgari.h"
#import "Agari.h"
#import "Yaku.h"

@interface AgariHistoryTableViewContoller : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    UITableView                     *_tableView;
    NSFetchedResultsController      *_fetchedResultsCtl;
    AgariDetailTableViewController  *detail_;
}

@property(nonatomic, readonly, retain)  UITableView                     *tableView;
@property(nonatomic, readonly, retain)  NSFetchedResultsController      *fetchedResultsCtl;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)insertAgariObject:(id)sender;
- (void)insertOrUpdateAgari:(MjAgari *)mjAgari at:(NSDate *)date;
- (Agari *)getAgariObjectAt:(NSDate *)date;
- (Yaku *)getYakuObjectByName:(NSString *)name;

@end
