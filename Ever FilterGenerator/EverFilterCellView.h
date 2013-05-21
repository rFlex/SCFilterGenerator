//
//  EverFilterCellView.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class EverFilter;
@protocol EverFilterCellViewDelegate;

@interface EverFilterCellView : NSTableCellView {
    
}

- (void) buildCell:(EverFilter*)filter;

@property(strong) id<EverFilterCellViewDelegate> delegate;
@property(strong) NSTextField * effectTitle;
@property(strong) NSButton * checkbox;
@property(strong) NSButton * deleteButton;
@property(strong) NSButton * editButton;
@property(strong) EverFilter * filter;

@end

@protocol EverFilterCellViewDelegate <NSObject>

- (void) bypassBoxChanged:(EverFilterCellView*)cell;
- (void) deletePressed:(EverFilterCellView*)cell;
- (void) editPressed:(EverFilterCellView*)cell;

@end