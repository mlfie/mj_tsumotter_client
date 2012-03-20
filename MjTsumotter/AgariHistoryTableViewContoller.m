//
//  AgariHistoryTableViewContoller.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AgariHistoryTableViewContoller.h"
#import "MjTsumotterAppDelegate.h"

// TableViewの位置、サイズを定義
static const float  TABLE_VIEW_ORIGIN_X         = ZERO_VALUE_FLOAT;
static const float  TABLE_VIEW_ORIGIN_Y         = ZERO_VALUE_FLOAT;
static const float  TABLE_VIEW_SIZE_WIDTH       = IPHONE_DEVICE_SIZE_WIDTH;
static const float  TABLE_VIEW_SIZE_HEIGHT      = IPHONE_DEVICE_SIZE_HEIGHT - STATUS_BAR_SIZE_HEIGHT - NAVIGATION_BAR_SIZE_HEIGHT - TAB_BAR_SIZE_HEIGHT;

// エンティティを定義
static NSString     *kEntityAgari               = @"Agari";
static NSString     *kEntityYaku                = @"Yaku";

// エンティティ"Agari"の属性を定義
static NSString     *kAgariAttrDate             = @"date";
static NSString     *kAgariAttrImg              = @"img";
static NSString     *kAgariAttrTotalPoint       = @"total_point";
static NSString     *kAgariAttrYakus            = @"yakus";

// エンティティ"Yaku"の属性を定義
static NSString     *kYakuAttrName              = @"name";
static NSString     *kYakuAttrHanNum            = @"han_num";
static NSString     *kYakuAttrNakiHanNum        = @"naki_han_num";
static NSString     *kYakuAttrKanji             = @"Kanji";

// 一度のFetchしてくるデータ数を定義
static const NSInteger  FETCH_BATCH_SIZE        = 20;

// 検索条件
static NSString     *kPredicateFormatDate       = @"(date = %f)";
static NSString     *kPredicateFormatName       = @"(name = %@)";

// テーブルのセルの識別子を定義
static NSString     *kCellIdentifierFormat      = @"AgariHistory_%d_%d";

// セルの表示書式を定義
static NSString     *kCellFormatPoint           = @"%6d点";

@implementation AgariHistoryTableViewContoller

@synthesize tableView           = _tableView;
@synthesize fetchedResultsCtl   = _fetchedResultsCtl;

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.title = @"履歴";
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // テーブルを定義
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(TABLE_VIEW_ORIGIN_X, 
                                                                   TABLE_VIEW_ORIGIN_Y, 
                                                                   TABLE_VIEW_SIZE_WIDTH, 
                                                                   TABLE_VIEW_SIZE_HEIGHT) 
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

#ifdef ModeDebug
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertAgariObject:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
#endif
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView flashScrollIndicators];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_tableView release];
    [_fetchedResultsCtl release];
    [detail_ release];
    [super dealloc];
}

#pragma mark - Table view data source

/**
 * テーブルのセクション数を設定する.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsCtl sections] count];
}

/**
 * テーブルのセクション毎の行数を設定する.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fetchedResultsCtl sections] objectAtIndex:section] numberOfObjects];
}

/**
 * テーブルに表示する内容を設定する.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier        = [NSString stringWithFormat:kCellIdentifierFormat, indexPath.section, indexPath.row];
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                       reuseIdentifier:cellIdentifier] autorelease];
    }

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

/**
 * セルが選択された場合、アガリ情報の詳細画面を表示する.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detail_ = [[AgariDetailTableViewController alloc] initWithIndex:indexPath.row];
    [self.navigationController pushViewController:detail_ animated:YES];
}


#pragma mark - Fetched results controller delegate

/**
 * コンテンツ内容が変更される前に呼び出される.
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

/**
 * セクションが変更された場合に呼び出される.
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/**
 * オブジェクトが変更された場合に呼び出される.
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] 
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] 
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/**
 * コンテンツ内容が変更された後に呼び出される.
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */


#pragma mark - AgariHistoryTableViewController
/**
 * AgariをFetchするコントローラを取得する.
 */
- (NSFetchedResultsController *)fetchedResultsCtl
{
    // 既に取得済みの場合はそのまま返す
    if (_fetchedResultsCtl != nil) {
        return _fetchedResultsCtl;
    }
    
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];

    // エンティティ"Agari"に対するフェッチリクエストを作成
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:kEntityAgari
                                                  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // 一回の呼び出しで取得するデータ数を設定する
    [fetchRequest setFetchBatchSize:FETCH_BATCH_SIZE];
    
    // ソート順を設定する
    NSSortDescriptor *sortDescriptor1   = 
        [[NSSortDescriptor alloc] initWithKey:kAgariAttrDate 
                                    ascending:NO];
    NSArray *sortDescriptors        = [NSArray arrayWithObjects:sortDescriptor1, 
                                       nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    // セクション名とキャッシュ名を設定する
    _fetchedResultsCtl              = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                          managedObjectContext:context 
                                                                            sectionNameKeyPath:nil 
                                                                                     cacheName:kEntityAgari];
    _fetchedResultsCtl.delegate     = self;
    
    [fetchRequest release];
    [sortDescriptor1 release];
    [sortDescriptors release];
    
    // フェッチを実行する
    NSError *error = nil;
	if (![self.fetchedResultsCtl performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    return _fetchedResultsCtl;
}

/**
 * セルに表示する内容を設定する.
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Agari *agari                    = [self.fetchedResultsCtl objectAtIndexPath:indexPath];
    // セルに画像を表示する
    cell.imageView.image            = [UIImage imageWithData:agari.img];
    
    // セルのテキストに日付を表示する
    NSDateFormatter *formatter      = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormatDateTime];
    NSDate *baseDate                = [formatter dateFromString:kBaseDateFrom2012];
    NSDate *date                    = [NSDate dateWithTimeInterval:agari.date 
                                                         sinceDate:baseDate];
    cell.textLabel.text             = [formatter stringFromDate:date];
    
    // セルのサブテキストに点数を表示する
    cell.detailTextLabel.text       = [NSString stringWithFormat:kCellFormatPoint, agari.total_point];

    cell.accessoryType              = UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)insertAgariObject:(id)sender
{
    NSDate *date                    = [NSDate date];
    MjAgari *mjAgari                = [[MjAgari alloc] init];
    [self insertOrUpdateAgari:mjAgari at:date];
}

- (void)insertOrUpdateAgari:(MjAgari *)mjAgari at:(NSDate *)date
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSError *error                  = nil;
    
    // MjAgariをAgariにコンバートする
//    Agari *agari                    = [self getAgariObjectAt:date];
    //----- ここから仮実装 -----
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:kEntityAgari 
                                                  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    Agari *agari                    = [NSEntityDescription insertNewObjectForEntityForName:kEntityAgari 
                                                                    inManagedObjectContext:context];
    NSDateFormatter *formatter      = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormatDateTime];
    NSDate *baseDate                = [formatter dateFromString:kBaseDateFrom2012];
    NSTimeInterval interval         = [date timeIntervalSinceDate:baseDate];
    agari.date                      = interval;
    //----- ここまで仮実装 -----
    // TODO
//    for (NSDictionary *dic in mjAgari.yaku_list) {
//        // dicをYakuにコンバートする
//        NSString *name                  = [dic objectForKey:@"name"];
//        Yaku *yaku                      = [self getYakuObjectByName:name];
//        // TODO
//    }
    
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (Agari *)getAgariObjectAt:(NSDate *)date
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSError *error                  = nil;
    
    NSDateFormatter *formatter      = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormatDateTime];
    NSDate *baseDate                = [formatter dateFromString:kBaseDateFrom2012];
    NSTimeInterval interval         = [date timeIntervalSinceDate:baseDate];
    
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:kEntityAgari 
                                                  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:kPredicateFormatDate, interval];
    [fetchRequest setPredicate:predicate];
    
    NSArray *objects                = [context executeFetchRequest:fetchRequest 
                                                             error:&error];
    
    Agari *agari                    = nil;
    if (objects == nil) {
        NSLog(@"Error");
    }
    else {
        if ([objects count] > 0) {
            agari                   = [objects objectAtIndex:0];
        }
        else {
            agari                   = [NSEntityDescription insertNewObjectForEntityForName:kEntityAgari 
                                                                    inManagedObjectContext:context];
        }
    }
    
    [fetchRequest release];
    
    return agari;
}

- (Yaku *)getYakuObjectByName:(NSString *)name
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSError *error                  = nil;
    
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity     = [NSEntityDescription entityForName:kEntityYaku 
                                                  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate          = [NSPredicate predicateWithFormat:kPredicateFormatName, name];
    [fetchRequest setPredicate:predicate];
    
    NSArray *objects                = [context executeFetchRequest:fetchRequest 
                                                             error:&error];
    Yaku *yaku                      = nil;
    if (objects == nil) {
        NSLog(@"Error");
    }
    else {
        if ([objects count] > 0) {
            yaku                    = [objects objectAtIndex:0];
        }
        else {
            yaku                    = [NSEntityDescription insertNewObjectForEntityForName:kEntityYaku 
                                                                    inManagedObjectContext:context];
        }
    }
    
    [fetchRequest release];
    
    return yaku;
}

@end
