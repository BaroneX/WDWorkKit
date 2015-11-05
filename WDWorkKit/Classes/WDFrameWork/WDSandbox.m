//
//  WDSandbox.m
//  WDFrameWork
//
//  Created by Blake on 15/3/12.
//  Copyright (c) 2015年 Blake. All rights reserved.
//

#import "WDSandbox.h"

@interface WDSandbox ()
{
    NSString *	_appPath;
    NSString *	_docPath;
    NSString *	_libPrefPath;
    NSString *	_libCachePath;
    NSString *	_tmpPath;
}

- (BOOL)touch:(NSString *)path;
- (BOOL)touchFile:(NSString *)path;

@end

@implementation WDSandbox

@dynamic appPath;
@dynamic docPath;
@dynamic libPrefPath;
@dynamic libCachePath;
@dynamic tmpPath;

+ (WDSandbox *)sharedInstance
{
    static WDSandbox *_sandboxManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sandboxManager = [[self alloc] init];
    });
    return _sandboxManager;
}

+ (NSString *)appPath
{
    return [[WDSandbox sharedInstance] appPath];
}

- (NSString *)appPath
{
    if (nil == _appPath)
    {
        _appPath = [[NSBundle mainBundle] bundlePath];
    }
    
    return _appPath;
}

+ (NSString *)docPath
{
    return [[WDSandbox sharedInstance] docPath];
}

- (NSString *)docPath
{
    if (nil == _docPath)
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _docPath = [paths objectAtIndex:0];
    }
    
    return _docPath;
}

+ (NSString *)libPrefPath
{
    return [[WDSandbox sharedInstance] libPrefPath];
}

- (NSString *)libPrefPath
{
    if ( nil == _libPrefPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
        
        [self touch:path];
        
        _libPrefPath = path;
    }
    
    return _libPrefPath;
}

+ (NSString *)libCachePath
{
    return [[WDSandbox sharedInstance] libCachePath];
}

- (NSString *)libCachePath
{
    if (nil == _libCachePath)
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
        
        [self touch:path];
        
        _libCachePath = path;
    }
    
    return _libCachePath;
}

+ (NSString *)tmpPath
{
    return [[WDSandbox sharedInstance] tmpPath];
}

- (NSString *)tmpPath
{
    if ( nil == _tmpPath )
    {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString * path = [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
        
        [self touch:path];
        
        _tmpPath = path;
    }
    
    return _tmpPath;
}

+ (BOOL)touch:(NSString *)path
{
    return [[WDSandbox sharedInstance] touch:path];
}

- (BOOL)touch:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return YES;
}

+ (BOOL)touchFile:(NSString *)file
{
    return [[WDSandbox sharedInstance] touchFile:file];
}

- (BOOL)touchFile:(NSString *)file
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:file] )
    {
        return [[NSFileManager defaultManager] createFileAtPath:file
                                                       contents:[NSData data]
                                                     attributes:nil];
    }
    
    return YES;
}

@end
