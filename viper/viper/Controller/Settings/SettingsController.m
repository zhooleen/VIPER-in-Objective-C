//
//  SettingsController.m
//  NONE
//
//  Created by none on 2020/2/10.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "SettingsController.h"
#import "Core.h"
#import "UIView+Util.h"
#import "VIPTableDelegate.h"

@interface SettingsController () <CellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) id<PageViewModel> page;
@property (strong, nonatomic) VIPTableDelegate *tableDelegate;
@end

@implementation SettingsController


- (void)viewDidLoad {
    
    self.tableView = [UIView tableView];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    self.tableDelegate = [[VIPTableDelegate alloc] init];
    self.tableView.delegate = self.tableDelegate;
    self.tableView.dataSource = self.tableDelegate;
    self.tableDelegate.delegate = self;
        
    NSArray *names = @[@"NLBasicTableCell", @"ActionTableCell"];
    for (NSString *name in names) {
        Class klass = NSClassFromString(name);
        if(klass != nil && [klass isSubclassOfClass:[UITableViewCell class]]) {
            [self.tableView registerClass:klass forCellReuseIdentifier:name];
        }
    }
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self.resultMapping registerSelector:@selector(reloadData:) forKey:kEventViewDidLoad];
    [self sendEvent:kEventViewDidLoad];
}

#pragma mark - VIP

- (void) reloadData:(id<Result>)result {
    self.page = result.data;
    self.tableDelegate.page = result.data;
    [self.tableView reloadData];
}

#pragma mark - CellDelegate

- (void) onSelectCell:(id<CellViewModel>)cell inSection:(id<SectionViewModel>)section {
    if(cell.event) {
        [self.handler handleEvent:cell.event];
    }
}

@end
