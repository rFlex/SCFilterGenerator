//
//  EverFilterExporter.h
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/21/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EverFilterExporter : NSObject {
    
}

+ (BOOL) exportFilters:(NSArray*)pipeline outputFile:(NSURL*)outputFile;

@end
