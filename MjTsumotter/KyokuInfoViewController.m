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
        }];
        [section cell:^(Cell *cell) {
            cell.cellView = &ippatsuCell;
        }];
        [section cell:^(Cell *cell) {
            cell.cellView = &haiteiCell;
        }];
        [section cell:^(Cell *cell) {
            cell.cellView = &rinshanCell;
        }];
        [section cell:^(Cell *cell) {
            cell.cellView = &chankanCell;
        }];
        [section cell:^(Cell *cell) {
            cell.cellView = &tenhoCell;
        }];
        [section cell:^(Cell *cell) {
            cell.cellView = &chihoCell;
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

@end
