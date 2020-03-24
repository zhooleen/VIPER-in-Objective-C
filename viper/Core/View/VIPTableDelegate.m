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
