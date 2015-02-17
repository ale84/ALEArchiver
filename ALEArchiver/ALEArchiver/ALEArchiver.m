//  Created by Alessio on 28/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "ALEArchiver.h"

@interface ALEArchiver ()
- (NSString *)libraryDirectory;
- (NSString *)documentsDirectory;
- (NSString *)rootDirForOptions:(ALEDiskSaverOptions)options;
@end

@implementation ALEArchiver

- (NSString *)libraryDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return paths[0];
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}

- (NSString *)rootDirForOptions:(ALEDiskSaverOptions)options
{
    NSString *rootDir = self.documentsDirectory;
    
    if (options & ALEArchiverOptionRootDirectoryDocuments) {
        rootDir = self.documentsDirectory;
    }
    if (options & ALEArchiverOptionRootDirectoryLibrary) {
        rootDir = self.libraryDirectory;
    }
    if ((options & ALEArchiverOptionRootDirectoryLibrary) &&
        (options & ALEArchiverOptionRootDirectoryDocuments) ) {
        NSLog(@"<WARNING>ALEDiskSaver: you can't specify both ALEDiskSaverOptionRootDirectoryLibrary and ALEDiskSaverOptionRootDirectoryDocuments options. Behaviour is undefined");
    }
    return rootDir;
}

- (BOOL)saveObject:(id<NSCoding>)toSave
          withName:(NSString *)filename
       inDirectory:(NSString *)dirPath
               key:(NSString *)key
           options:(ALEDiskSaverOptions)options
             error:(NSError *__autoreleasing *)error
{
    BOOL success = YES;
    
    NSString *directory = nil;
    
    NSString *rootDir = [self rootDirForOptions:options];
    
    if (dirPath) {

        directory = [rootDir stringByAppendingPathComponent:dirPath];
        if (options & ALEArchiverOptionCreateDirIfNotExist) {
           success = [[NSFileManager defaultManager]createDirectoryAtPath:directory
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:error];
            if (!success) {
                return success;
            }
        }
    }
    else {
        directory = rootDir;
    }

    NSString *filePath = [directory stringByAppendingPathComponent:filename];
    NSMutableData *fileData = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:fileData];
	[archiver encodeObject:toSave forKey:key];
	[archiver finishEncoding];
	success = [fileData writeToFile:filePath atomically:YES];
    return success;
}

- (id)loadObjectWithFilename:(NSString *)filename
               inDirectory:(NSString *)dirPath
                       key:(NSString *)key
                   options:(ALEDiskSaverOptions)options
{
    NSString *rootDir = [self rootDirForOptions:options];
    
    NSString *directory = nil;
    if (dirPath) {
        directory = [rootDir stringByAppendingPathComponent:dirPath];
    }
    else {
        directory = rootDir;
    }
    
    NSString *filePath = [directory stringByAppendingPathComponent:filename];
	NSMutableData *fileData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    
    id someObject = nil;
    
    if (fileData) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:fileData];
        someObject = [unarchiver decodeObjectForKey:key] ;
        [unarchiver finishDecoding];
    }
    
	return someObject;
}

- (BOOL)removeObjectWithFilename:(NSString *)filename
                     inDirectory:(NSString *)dirPath
                         options:(ALEDiskSaverOptions)options
                           error:(NSError *__autoreleasing *)error
{
    NSString *rootDir = [self rootDirForOptions:options];
    NSString *directory = nil;
    
    if (dirPath) {
        directory = [rootDir stringByAppendingPathComponent:dirPath];
    }
    else {
        directory = rootDir;
    }
    
    NSString *filePath = [directory stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager removeItemAtPath:filePath error:error];
    return success;
}


@end
