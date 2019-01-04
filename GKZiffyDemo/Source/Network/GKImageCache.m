//
//  GKImageCache.m
//  GKZiffyDemo
//
//  Created by Gaurav Keshre on 6/29/15.
//  Copyright (c) 2015 Gaurav Keshre. All rights reserved.
//

#import "GKImageCache.h"


/*
 * INLINE
 */

static NSString* _GKImageCacheDirectory;

static inline NSString* GKImageCacheDirectory() {
    if(!_GKImageCacheDirectory) {
        _GKImageCacheDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ZiffyCache"] copy];
    }
    return _GKImageCacheDirectory;
}


inline static NSString* keyForURL(NSString *url) {
    return [NSString stringWithFormat:@"ZiffyImageCache-%lu", (unsigned long)[url hash]];
}


static inline NSString* cachePathForURL(NSString* key) {
    return [GKImageCacheDirectory() stringByAppendingPathComponent:keyForURL(key)];
}

static GKImageCache *sharedInstance;

@implementation GKImageCache

+ (GKImageCache *) sharedCache {
    if(!sharedInstance) {
        sharedInstance = [[GKImageCache alloc] init];
    }
    return sharedInstance;
}

- (id) init {
    if((self = [super init])) {
        _diskOperationQueue = [[NSOperationQueue alloc] init];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:GKImageCacheDirectory()
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    
    return self;
}

#pragma mark - Clear Cache
-(void)clearCacheData{
    [super removeAllObjects];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = GKImageCacheDirectory();
    NSArray *fileArray = [fileManager contentsOfDirectoryAtPath:directory error:nil];
    for (NSString *filename in fileArray)  {
        [fileManager removeItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
    }
}

#pragma mark - Disk Writing Operations

- (void) writeData:(NSData*)data toPath:(NSString *)path {
    [data writeToFile:path atomically:YES];
}


- (void) performDiskWriteOperation:(NSInvocation *)invoction {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invoction];
    [_diskOperationQueue addOperation:operation];
    operation = nil;
}


@end
