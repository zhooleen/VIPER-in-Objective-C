//
//  AccountController.m
//  NONE
//
//  Created by none on 2020/1/22.
//  Copyright © 2020 NONE. All rights reserved.
//

#import "AccountController.h"
#import "Core.h"
#import "AccountPresenter.h"
#import "AccountInteractor.h"
#import "AccountRouter.h"
#import "UIView+Util.h"
#import "VIPTableDelegate.h"

@interface AccountController () <CellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) id<PageViewModel> page;
@property (strong, nonatomic) VIPTableDelegate *tableDelegate;
@end

@implementation AccountController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [UIView tableView];
    CGRect frame = self.view.bounds;
    frame.origin.y -= 1;
    frame.size.height+=1;
    self.tableView.frame = frame;
    [self.view addSubview:self.tableView];
    
    self.tableDelegate = [[VIPTableDelegate alloc] init];
    self.tableView.delegate = self.tableDelegate;
    self.tableView.dataSource = self.tableDelegate;
    self.tableDelegate.delegate = self;
    
    NSArray *names = @[@"BasicTableCell", @"AccountTableCell"];
    for (NSString *name in names) {
        Class klass = NSClassFromString(name);
        if(klass != nil && [klass isSubclassOfClass:[UITableViewCell class]]) {
            [self.tableView registerClass:klass forCellReuseIdentifier:name];
        }
    }

    [self hideBackBarButtonItemTitle];
    self.title = @"";
    
    [self.resultMapping registerSelector:@selector(reloadTableView:) forKey:kEventViewDidLoad];
    
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
