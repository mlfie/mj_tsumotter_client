//
//  AgariDetailTableViewController.m
//  MjTsumotter
//
//  Created by 寺師 佳彦 on 11/12/29.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AgariDetailTableViewController.h"
#import "TehaiView.h"

// TableViewの位置、サイズを定義
static const float  TABLE_VIEW_ORIGIN_X         = ZERO_VALUE_FLOAT;
static const float  TABLE_VIEW_ORIGIN_Y         = ZERO_VALUE_FLOAT;
static const float  TABLE_VIEW_SIZE_WIDTH       = IPHONE_DEVICE_SIZE_WIDTH;
static const float  TABLE_VIEW_SIZE_HEIGHT      = IPHONE_DEVICE_SIZE_HEIGHT - STATUS_BAR_SIZE_HEIGHT - NAVIGATION_BAR_SIZE_HEIGHT - TAB_BAR_SIZE_HEIGHT;

@implementation AgariDetailTableViewController
{
    Agari *m_agari;
}

@synthesize tableView                   = _tableView;

- (id)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self != nil) {
        index_ = index_;
    }
    return self;
}

- (id)initWithAgari:(Agari *)agari
{
    self = [super init];
    if (self) {
        m_agari = [agari retain];
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

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // テーブルを定義
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(TABLE_VIEW_ORIGIN_X, 
                                                               TABLE_VIEW_ORIGIN_Y, 
                                                               TABLE_VIEW_SIZE_WIDTH, 
                                                               TABLE_VIEW_SIZE_HEIGHT) 
                                              style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = ZERO_VALUE_INT;
    switch (section) {
        case 0:
            number = 1;
            break;
        case 1:
            number = 5;
            break;
        case 2:
            number = 4;
        default:
            break;
    }
    return number;
}

// 各セクション(グループ)のタイトルを設定する.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch (section) {
        case 0:
            break;
        case 1:
            title = @"役";
            break;
        case 2:
            title = @"詳細";
            break;
        default:
            break;
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    switch (indexPath.section) {
        case 0:
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            NSString *fileName  = [NSString stringWithFormat:@"sample%d", index_];
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:fileName 
                                                                  ofType:kFileTypeJpeg];
            //cell.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
            
            TehaiView *tehai = [[TehaiView alloc] initWithFrame:CGRectMake(0, 0, 280, 45)];
            tehai.tehaiString = m_agari.tehai_list;
            [cell.contentView addSubview:tehai];
            
            break;
        case 1:
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
                                               reuseIdentifier:CellIdentifier] autorelease];
            }
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text         = @"立直";
                    cell.detailTextLabel.text   = @"1飜";
                    break;
                case 1:
                    cell.textLabel.text         = @"門前清自摸和";
                    cell.detailTextLabel.text   = @"1飜";
                    break;
                case 2:
                    cell.textLabel.text         = @"断么九";
                    cell.detailTextLabel.text   = @"1飜";
                    break;
                case 3:
                    cell.textLabel.text         = @"一盃口";
                    cell.detailTextLabel.text   = @"1飜";
                    break;
                case 4:
                    cell.textLabel.text         = @"満貫";
                    cell.detailTextLabel.text   = @"12000点";
                    break;
                default:
                    break;
            }
            break;
        case 2:
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
                                               reuseIdentifier:CellIdentifier] autorelease];
            }
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text         = @"場風";
                    cell.detailTextLabel.text   = @"東";
                    break;
                case 1:
                    cell.textLabel.text         = @"自風";
                    cell.detailTextLabel.text   = @"東";
                    break;
                case 2:
                    cell.textLabel.text         = @"本場";
                    cell.detailTextLabel.text   = @"2";
                    break;
                case 3:
                    cell.textLabel.text         = @"アガリ";
                    cell.detailTextLabel.text   = @"ツモ";
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc
{
    [photoView_ release];
    [_tableView release];
    [m_agari release];
    [super dealloc];
}

@end
