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
    UIButton *submitButton;
    MjAgari *agari;
}

@synthesize agari;

- (id)initWithMjAgari:(MjAgari *)agari
{
    self = [super init];
    if (self) {
        self.agari = agari;
    }
    return self;
}

- (void)dealloc
{
    [self.agari release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitButton.frame = CGRectMake(0, 0, IPHONE_DEVICE_SIZE_WIDTH, 50);
    [submitButton setTitle:@"送信する" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)submitButtonDidPress:(id)sender
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

@end
