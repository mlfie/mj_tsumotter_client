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

@interface KyokuInfoViewController ()

@end

@implementation KyokuInfoViewController
{
    UITableViewCell *imgCell;
    UITableViewCell *is_tsumoCell;
    UITableViewCell *jikazeCell;
    MjAgari *agari;
}

@synthesize agari, imgCell, is_tsumoCell, jikazeCell;

- (void)dealloc
{
    [self.agari release];
    [super dealloc];
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
    if (indexPath.section == 0) {
        return imgCell.bounds.size.height;
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                return is_tsumoCell.bounds.size.height;
                break;
            case 1:
                return jikazeCell.bounds.size.height;
                break;                
            default:
                break;
        }
    }
    
    return is_tsumoCell.bounds.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;            
        default:
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"牌画像";
            break;
        case 1:
            return @"アガリ状況";
            break;            
        default:
            break;
    }
    return @"";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (indexPath.section == 0) {
        return imgCell;
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                return is_tsumoCell;
                break;
            case 1:
                return jikazeCell;
                break;                
            default:
                break;
        }
    }
    
    return is_tsumoCell;
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
