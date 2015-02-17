//  Created by Alessio on 28/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, ALEDiskSaverOptions)
{
    /**
     *  Creates the specified directory if it doesn't exist.
     */
    ALEArchiverOptionCreateDirIfNotExist       = 1 << 0,
    
    /**
     *  Set the root directory as the Library directory. Mutually exclusive with ALEDiskSaverOptionRootDirectoryDocuments
     */
    ALEArchiverOptionRootDirectoryLibrary      = 1 << 1,
    
    /**
     *  Set the root directory as the Documents directory. Mutually exclusive with ALEDiskSaverOptionRootDirectoryLibrary
     */
    ALEArchiverOptionRootDirectoryDocuments    = 1 << 2,
};

/**
 *   Saves/loads (atomically) any object conforming to NSCoding to/from the specified directory.
 You can specify as an option the root directory as either Library or Documents.
 You can also append a custom directory path and tell it to create the directories if they don't exist.
 */

@interface ALEArchiver : NSObject

/**
 *  Saves to a file an object which conforms to the NSCoding protocol, using NSKeyedArchiver to encode it with the provided key.
 *
 *  @param toSave   an object which conforms to the NSCoding protocol (required)
 *  @param filename the name for the file which will contain the archived object (required)
 *  @param dirPath  an optional intermediary directory in which to put the file
 *  @param key      the key used to archive the file (required)
 *  @param options  a bitmask of options or 0
 *  @param error    the resulting error in case the save operation fails
 *
 *  @return YES if the operation was successful, otherwise NO
 */
- (BOOL)saveObject:(id <NSCoding>)toSave
          withName:(NSString *)filename
       inDirectory:(NSString *)dirPath
               key:(NSString *)key
           options:(ALEDiskSaverOptions)options
             error:(NSError **)error;

/**
 *  Loads a previously saved object from a file, and decodes it using the provided key.
 *
 *  @param filename the name of the file in which the requested object was saved (required)
 *  @param dirPath  the intermediary directory that contains the file, if present
 *  @param key      the key with which the object was archived (required)
 *  @param options  a bitmask of options or 0
 *
 *  @return the decoded object
 */
- (id)loadObjectWithFilename:(NSString *)filename
                 inDirectory:(NSString *)dirPath
                         key:(NSString *)key
                     options:(ALEDiskSaverOptions)options;

/**
 *  Removes a previously saved object from the filesystem.
 *
 *  @param filename the name of the file to remove (required)
 *  @param dirPath  the intermediary directory that contains the file, if present
 *  @param options  a bitmask of options or 0
 *  @param error    the resulting error in case the remove operation fails
 *
 *  @return YES if the operation was successful, otherwise NO
 */
- (BOOL)removeObjectWithFilename:(NSString *)filename
                     inDirectory:(NSString *)dirPath
                         options:(ALEDiskSaverOptions)options
                           error:(NSError **)error;

@end
