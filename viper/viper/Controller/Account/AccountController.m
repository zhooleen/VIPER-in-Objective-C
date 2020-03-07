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

@interface AccountController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) id<PageViewModel> page;
@end

@implementation AccountController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [UIView tableView];
    CGRect frame = self.view.bounds;
    frame.origin.y -= 1;
    frame.size.height+=1;
    self.tableView.frame = frame;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - VIP

- (void) reloadTableView:(id<Result>)result {
    self.page = result.data;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.page.sections.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<SectionViewModel> area = self.page.sections[section];
    return area.models.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CellViewModel> item = [self modelAtIndexPath:indexPath];
    UITableViewCell<Cell> *cell = [tableView dequeueReusableCellWithIdentifier:item.reuseIdentifier forIndexPath:indexPath];
    [cell updateWithModel:item];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CellViewModel> item = [self modelAtIndexPath:indexPath];
    Class klass = NSClassFromString(item.reuseIdentifier);
    CGSize size = [klass cellSizeWithModel:item];
    return size.height;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?0.001:20;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<CellViewModel> model = [self modelAtIndexPath:indexPath];
    if(model.event) {
        [self.handler handleEvent:model.event];
    }
}

#pragma mark -

- (id<CellViewModel>) modelAtIndexPath:(NSIndexPath*)indexPath {
    id<SectionViewModel> area = self.page.sections[indexPath.section];
    id<CellViewModel> cell = area.models[indexPath.row];
    return cell;
}

@end
