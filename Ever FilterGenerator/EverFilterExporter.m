//
//  EverFilterExporter.m
//  Ever FilterGenerator
//
//  Created by Simon CORSIN on 5/21/13.
//  Copyright (c) 2013 com.ever. All rights reserved.
//

#import "EverFilterExporter.h"
#import "EverFilters.h"
#import <objc/runtime.h>

@implementation EverFilterExporter

+ (NSString*) indent:(NSString*)input {
    NSMutableString * output = [[NSMutableString alloc] initWithString:input];

    int indentCount = 0;
    BOOL shouldIndent = NO;
    for (NSUInteger index = 0; index < [output length]; index++) {
        unichar currentChar = [output characterAtIndex:index];
        
        switch (currentChar) {
            case ';':
                [output insertString:@"\n" atIndex:index + 1];
                break;
            case '{':
                indentCount++;
                [output insertString:@"\n" atIndex:index + 1];
                break;
            case '}':
                indentCount--;
                [output insertString:@"\n" atIndex:index + 1];
                break;
            case '\n':
                shouldIndent = YES;
                [output insertString:[@"" stringByPaddingToLength:indentCount withString:@"\t" startingAtIndex:0] atIndex:index + 1];
            break;
            default:
                break;
        }
    }
    
    return output;
}

+ (BOOL) exportFilters:(NSArray *)pipeline outputFile:(NSURL *)outputFile {
    NSMutableString * output = [[NSMutableString alloc] init];
    
    NSString * className = [[[outputFile path] lastPathComponent] stringByDeletingPathExtension];
    
    [output appendString:@"using System;"];
    [output appendString:@"using GPUImageBindings;using MonoTouch.UIKit;\n"];
    [output appendString:@"namespace CameraIphone {"];
    [output appendFormat:@"public class %@ : PhotoEffect {\n", className];
    [output appendFormat:@"public static readonly string NAME = \"%@\";\n", className];
    [output appendFormat:@"public %@() : base(NAME) {", className];
    [output appendFormat:@"}\n"];
    [output appendFormat:@"public override GPUImageFilter createFilter() {"];
    [output appendFormat:@"GPUImageFilterGroup group = new GPUImageFilterGroup();"];
    
    NSMutableArray * filterArray = [[NSMutableArray alloc] init];
    int currentFilterIndex = 0;
    for (EverFilter * everFilter in pipeline) {
        const char * filterType = class_getName([everFilter.filter class]);
        NSString * filterName = [NSString stringWithFormat:@"filter%d", currentFilterIndex];
        [output appendFormat:@"%s %@ = new %s();", filterType, filterName, filterType];
        NSString * parameters = [everFilter getCSharpParameters:filterName];
        if (parameters != nil) {
            [output appendString:parameters];
        }
        currentFilterIndex++;
        [filterArray addObject:filterName];
    }
    
    for (NSString * filterName in filterArray) {
        [output appendFormat:@"this.attachFilter(group, %@);", filterName];
    }
    
    [output appendFormat:@""];
    [output appendFormat:@"return group;"];
    [output appendFormat:@"}\n"];
    [output appendFormat:@"}"];
    [output appendFormat:@"}"];
    
    [[EverFilterExporter indent:output] writeToURL:outputFile atomically:YES encoding:NSASCIIStringEncoding error:nil];
    
    NSLog(@"%@", [EverFilterExporter indent:output]);
    
    return NO;
}

@end
