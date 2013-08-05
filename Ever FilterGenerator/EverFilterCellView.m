//
//  EverFilterCellView.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "EverFilterCellView.h"
#import "EverFilters.h"

@implementation EverFilterCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
    
    self.effectTitle = [self.subviews objectAtIndex:0];
    self.checkbox = [self.subviews objectAtIndex:1];
    self.deleteButton = [self.subviews objectAtIndex:2];
    self.editButton = [self.subviews objectAtIndex:3];
    
    [self.checkbox setTarget:self];
    [self.checkbox setAction:@selector(checkBoxChanged:)];
    [self.deleteButton setTarget:self];
    [self.deleteButton setAction:@selector(deletePressed:)];
    [self.editButton setTarget:self];
    [self.editButton setAction:@selector(editPressed:)];
    
}
- (void)deletePressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deletePressed:)]) {
        [self.delegate deletePressed:self];
    }
}

- (void)checkBoxChanged:(id)sender {
    if ([self.delegate respondsToSelector:@selector(bypassBoxChanged:)]) {
        [self.delegate bypassBoxChanged:self];
    }
}

- (void)editPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editPressed:)]) {
        [self.delegate editPressed:self];
    }
}

- (NSArray*)draggingImageComponents {
    NSLog(@"Dragging image components!");
    return nil;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (void)buildCell:(EverFilter *)filter {
    self.effectTitle.stringValue = filter.name;
    self.filter = filter;
    self.checkbox.state = filter.enabled;
}

@end
