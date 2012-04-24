//
//  TableViewSetting.m
//  MjTsumotter
//
//  Created by 健 荻野 on 12/03/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewSetting.h"

@implementation TableViewSetting
{
    NSMutableArray *sections;
}

- (id)init
{
    self = [super init];
    if (self) {
        sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [sections release];
    
    [super dealloc];
}

- (void)section:(SectionImplementHandler)handler
{
    Section *s = [[Section alloc] init];
    handler(s);
    
    [sections addObject:s];
    [s release];
}

- (NSString *)getTitleOfSection:(int)sectionIndex
{
    Section *s = [sections objectAtIndex:sectionIndex];
    return s.title;
}

- (int)sectionCount
{
    return [sections count];
}

- (int)cellCountOfSection:(int)sectionIndex
{
    return [[sections objectAtIndex:sectionIndex] cellCount];
}

- (int)getHeightOfSection:(int)sectionIndex cell:(int)cellIndex
{
    return [[sections objectAtIndex:sectionIndex] getHeightOfCell:cellIndex];
}

- (UITableViewCell *)getCellViewOfSection:(int)sectionIndex cell:(int)cellIndex
{
    return [[sections objectAtIndex:sectionIndex] getCellViewOfCell:cellIndex];
}

- (void)performSection:(int)sectionIndex cell:(int)cellIndex view:(UITableView *)view
{
    [[[sections objectAtIndex:sectionIndex] getCell:cellIndex] performView:view];
}

@end

@implementation Section
{
    NSString *title;
    NSMutableArray *cells;
}

@synthesize title;

- (id)init
{
    self = [super init];
    if (self) {
        cells = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    self.title = nil;
    [cells release];
    
    [super dealloc];
}

- (void)cell:(CellImplementHandler)handler
{
    Cell *c = [[Cell alloc] init];
    handler(c);
    
    [cells addObject:c];
    [c release];
}

- (int)cellCount
{
    return [cells count];
}

- (int)getHeightOfCell:(int)cellIndex
{
    Cell *c = [cells objectAtIndex:cellIndex];
    return c.height;
}

- (UITableViewCell *)getCellViewOfCell:(int)cellIndex
{
    return [[cells objectAtIndex:cellIndex] getCellView];
}

- (Cell *)getCell:(int)cellIndex
{
    return [cells objectAtIndex:cellIndex];
}

@end

@implementation Cell
{
    UITableViewCell **cellView;
    id touchedDelegate;
    SEL touchedAction;
    CellPerformHandler performHandler;
}

@synthesize cellView;
@dynamic height;

- (void)dealloc
{
    self.cellView = nil;
    [performHandler release];
    
    [super dealloc];
}

- (UITableViewCell *)getCellView
{
    if (*cellView) {
        return (*cellView);
    }
    return nil;
}

- (int)height
{
    if (*cellView) {
        return (*cellView).bounds.size.height;
    }
    return 0;
}

- (void)setPerformHandler:(CellPerformHandler)handler
{
    performHandler = [handler copy];
}

- (void)performView:(UITableView *)view
{
    if (performHandler) {
        performHandler(view);
    }

}


@end