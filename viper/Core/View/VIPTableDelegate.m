//
//  VIPTableDelegate.m
//  viper
//
//  Created by zlpro on 2020/3/24.
//  Copyright © 2020 None. All rights reserved.
//

#import "VIPTableDelegate.h"

@implementation VIPTableDelegate


#pragma mark - UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.page.sections.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<SectionViewModel> area = self.page.sections[section];
    if(area.asCell.boolValue) {
        return 1;
    }
    return area.models.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CellViewModel> item = [self modelAtIndexPath:indexPath];
    UITableViewCell<Cell> *cell = [tableView dequeueReusableCellWithIdentifier:item.reuseIdentifier forIndexPath:indexPath];
    [cell updateWithModel:item];
    if([cell respondsToSelector:@selector(delegate)]) {
        cell.delegate = self;
    }
    return cell;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<SectionViewModel> vm = [self.page.sections objectAtIndex:section];
    if(vm.header) {
        UIView<Cell> *cell = (UIView<Cell>*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:vm.header.reuseIdentifier];
        if(!cell) {
            Class klass = NSClassFromString(vm.header.reuseIdentifier);
            CGSize size = [klass cellSizeWithModel:vm];
            cell = [[klass alloc] initWithFrame:(CGRect){CGPointZero, size}];
        }
        [cell updateWithModel:vm];
    }
    return nil;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<SectionViewModel> vm = [self.page.sections objectAtIndex:section];
    if(vm.footer) {
        UIView<Cell> *cell = (UIView<Cell>*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:vm.footer.reuseIdentifier];
        if(!cell) {
            Class klass = NSClassFromString(vm.footer.reuseIdentifier);
            CGSize size = [klass cellSizeWithModel:vm];
            cell = [[klass alloc] initWithFrame:(CGRect){CGPointZero, size}];
        }
        [cell updateWithModel:vm];
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<CellViewModel> item = [self modelAtIndexPath:indexPath];
    Class klass = NSClassFromString(item.reuseIdentifier);
    CGSize size = [klass cellSizeWithModel:item];
    return size.height;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<SectionViewModel> vm = [self.page.sections objectAtIndex:section];
    if(vm.header) {
        Class klass = NSClassFromString(vm.header.reuseIdentifier);
        CGSize size = [klass cellSizeWithModel:vm.header];
        return size.height;
    }
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<SectionViewModel> vm = [self.page.sections objectAtIndex:section];
    if(vm.footer) {
        Class klass = NSClassFromString(vm.footer.reuseIdentifier);
        CGSize size = [klass cellSizeWithModel:vm.footer];
        return size.height;
    }
    return (section == 0)?0.01:20;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<SectionViewModel> area = self.page.sections[indexPath.section];
    id<CellViewModel> model = [self modelAtIndexPath:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(onSelectCell:inSection:)]) {
        [self.delegate onSelectCell:model inSection:area];
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell conformsToProtocol:@protocol(Animating)]) {
        id<Animating> an = (id<Animating>)cell;
        [an startAnimating];
    }
}

- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if([cell conformsToProtocol:@protocol(Animating)]) {
        id<Animating> an = (id<Animating>)cell;
        [an stopAnimating];
    }
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view conformsToProtocol:@protocol(Animating)]) {
        id<Animating> an = (id<Animating>)view;
        [an startAnimating];
    }
}

- (void) tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if([view conformsToProtocol:@protocol(Animating)]) {
        id<Animating> an = (id<Animating>)view;
        [an stopAnimating];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section {
    if([view conformsToProtocol:@protocol(Animating)]) {
        id<Animating> an = (id<Animating>)view;
        [an startAnimating];
    }
}

- (void) tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if([view conformsToProtocol:@protocol(Animating)]) {
        id<Animating> an = (id<Animating>)view;
        [an stopAnimating];
    }
}

#pragma mark -

- (void) onSelectCell:(id<CellViewModel>)cell inSection:(id<SectionViewModel>)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onSelectCell:inSection:)]) {
        [self.delegate onSelectCell:cell inSection:section];
    }
}

- (void) onTriggerEvent:(id<Event>)event ofCell:(id<CellViewModel>)cell inSection:(id<SectionViewModel>)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onTriggerEvent:ofCell:inSection:)]) {
        [self.delegate onTriggerEvent:event ofCell:cell inSection:section];
    }
}

- (void) onTriggerAttachmentEvent:(id<Event>)event inSection:(id<SectionViewModel>)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onTriggerAttachmentEvent:inSection:)]) {
        [self.delegate onTriggerAttachmentEvent:event inSection:section];
    }
}


#pragma mark -

- (id<CellViewModel>) modelAtIndexPath:(NSIndexPath*)indexPath {
    id<SectionViewModel> area = self.page.sections[indexPath.section];
    if(area.asCell.boolValue) {
        return area;
    }
    id<CellViewModel> cell = area.models[indexPath.row];
    return cell;
}

@end
