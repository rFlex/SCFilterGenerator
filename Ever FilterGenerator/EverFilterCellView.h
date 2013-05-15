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

-(void)buildCell:(EverFilter*)filter;

@property(assign) id<EverFilterCellViewDelegate> delegate;
@property(assign) NSTextField * effectTitle;
@property(assign) NSButton * checkbox;
@property(assign) NSButton * deleteButton;
@property(assign) NSButton * editButton;
@property(assign) EverFilter * filter;

@end

@protocol EverFilterCellViewDelegate <NSObject>

- (void)bypassBoxChanged:(EverFilterCellView*)cell;
- (void)deletePressed:(EverFilterCellView*)cell;
- (void)editPressed:(EverFilterCellView*)cell;

@end