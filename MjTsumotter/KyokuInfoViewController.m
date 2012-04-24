//
//  KyokuInfoViewController.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MjTsumotterAppDelegate.h"
#import "KyokuInfoViewController.h"
#import "AgariDetailTableViewController.h"
#import "MjAPIConnection.h"
#import "Agari.h"
#import "TableViewSetting.h"

@interface KyokuInfoViewController ()

@end

@implementation KyokuInfoViewController
{
    UITableViewCell *imgCell;
    UITableViewCell *is_tsumoCell;
    UITableViewCell *jikazeCell;
    UITableViewCell *bakazeCell;
    UITableViewCell *doraNumCell;
    UITableViewCell *honbaNumCell;
    UITableViewCell *reachCell;
    UITableViewCell *ippatsuCell;
    UITableViewCell *haiteiCell;
    UITableViewCell *rinshanCell;
    UITableViewCell *chankanCell;
    UITableViewCell *tenhoCell;
    UITableViewCell *chihoCell;
    
    MjAgari *agari;
    TableViewSetting *setting;
}

@synthesize agari, imgCell, is_tsumoCell, jikazeCell, bakazeCell, doraNumCell, honbaNumCell, reachCell, ippatsuCell, haiteiCell, rinshanCell, chankanCell, tenhoCell, chihoCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        setting = [[TableViewSetting alloc] init];
        [self setUpTableViewSetting];
    }
    return self;
}

- (void)dealloc
{
    self.agari = nil;
    [setting release];
    
    [super dealloc];
}

- (void)setUpTableViewSetting
{
    [setting section:^(Section *section) {
        section.title = @"牌画像";
        [section cell:^(Cell *cell) {
            cell.cellView = &imgCell;
        }];
    }];
    
    [setting section:^(Section *section) {
        section.title = @"アガリ状況";
        [section cell:^(Cell *cell) {
            cell.cellView = &is_tsumoCell;
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &jikazeCell;
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &bakazeCell;
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &doraNumCell;
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &honbaNumCell;
        }];
    }];
    
    [setting section:^(Section *section) {
        section.title = @"その他役";
        [section cell:^(Cell *cell) {
            cell.cellView = &reachCell;
            
            [cell setPerformHandler:^(UITableView *view) {
                
                if (agari.reach_num == 0) {
                    agari.reach_num = 1;
                    reachCell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    agari.reach_num = 0;
                    reachCell.accessoryType = UITableViewCellAccessoryNone;
                }
            }];
            
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &ippatsuCell;
            
            [cell setPerformHandler:^(UITableView *view) {                
                if (agari.is_ippatsu) {
                    agari.is_ippatsu = false;
                    ippatsuCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    agari.is_ippatsu = true;
                    ippatsuCell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }];
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &haiteiCell;
            
            [cell setPerformHandler:^(UITableView *view) {                
                if (agari.is_haitei) {
                    agari.is_haitei = false;
                    haiteiCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    agari.is_haitei = true;
                    haiteiCell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }];
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &rinshanCell;
            
            [cell setPerformHandler:^(UITableView *view) {                
                if (agari.is_rinshan) {
                    agari.is_rinshan = false;
                    rinshanCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    agari.is_rinshan = true;
                    rinshanCell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }];
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &chankanCell;
            
            [cell setPerformHandler:^(UITableView *view) {                
                if (agari.is_chankan) {
                    agari.is_chankan = false;
                    chankanCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    agari.is_chankan = true;
                    chankanCell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }];
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &tenhoCell;
            
            [cell setPerformHandler:^(UITableView *view) {                
                if (agari.is_tenho) {
                    agari.is_tenho = false;
                    tenhoCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    agari.is_tenho = true;
                    tenhoCell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }];
        }];
        
        [section cell:^(Cell *cell) {
            cell.cellView = &chihoCell;
            
            [cell setPerformHandler:^(UITableView *view) {                
                if (agari.is_chiho) {
                    agari.is_chiho = false;
                    chihoCell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    agari.is_chiho = true;
                    chihoCell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }];
        }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"送る" style:UIBarButtonItemStylePlain target:self action:@selector(submitButtonDidPress:)];        
    self.navigationItem.rightBarButtonItem = button;
    [button release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [setting getHeightOfSection:indexPath.section cell:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [setting sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [setting cellCountOfSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [setting getTitleOfSection:section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return [setting getCellViewOfSection:indexPath.section cell:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [setting performSection:indexPath.section cell:indexPath.row view:tableView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitButtonDidPress:(id)sender
{
    if (self.agari) {
        MjAPIConnection *con = [[[MjAPIConnection alloc] init] autorelease];
        [con sendAgari:self.agari withHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString, NSError *error) {
            NSLog(@"response = %@", responseString);
            
            [self.agari fromJSON:responseString];
            Agari *coreAgari = [self saveMjAgariToCoreData:self.agari];
            
            if (coreAgari) {
                [self moveToAgariDetailTableViewWithCoreAgari:coreAgari];
            }
        }];        
    }
}

- (id)saveMjAgariToCoreData:(MjAgari *)mjAgari
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    
    Agari *coreAgari = [NSEntityDescription insertNewObjectForEntityForName:@"Agari" inManagedObjectContext:context];
    
    [coreAgari fromMjAgari:mjAgari];
    
    NSError *error;
    if ([context save:&error]) {
        return [coreAgari autorelease];
    } else {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return nil;
    }
}

- (void)moveToAgariDetailTableViewWithCoreAgari:(Agari *)coreAgari
{    
    AgariDetailTableViewController *viewController = [[AgariDetailTableViewController alloc] initWithAgari:coreAgari];
    [self.navigationController pushViewController:viewController animated:YES];    
}

- (IBAction)is_tsumoChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    if ([control selectedSegmentIndex] == 0) {
        //"ron" is selected
        self.agari.is_tsumo = NO;
    } else {
        //"tsumo" is selected
        self.agari.is_tsumo = YES;
    }    
}

- (IBAction)jikazeChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    switch ([control selectedSegmentIndex]) {
        case 0:
            agari.jikaze = @"ton";
            break;
        case 1:
            agari.jikaze = @"nan";
            break;
        case 2:
            agari.jikaze = @"sha";
            break;
        case 3:
            agari.jikaze = @"pei";
            break;            
        default:
            break;
    }
}

- (IBAction)bakazeChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;
    
    switch ([control selectedSegmentIndex]) {
        case 0:
            agari.bakaze = @"ton";
            break;
        case 1:
            agari.bakaze = @"nan";
            break;
        case 2:
            agari.bakaze = @"sha";
            break;
        case 3:
            agari.bakaze = @"pei";
            break;            
        default:
            break;
    }
}


@end
