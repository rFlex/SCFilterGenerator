//
//  EverAppDelegate.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/14/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EverMainWindow.h"
#import "EverMainMenu.h"

@interface EverAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet EverMainWindow *mainWindow;
@property (assign) IBOutlet EverMainMenu *mainMenu;

@end
