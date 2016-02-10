# ALEArchiver
A component which simplifies the process of archiving any object witch conforms to NSCoding using NSKeyedArchiver and saving it to disk.
# Usage
You can use an instance of the archiver to save/load/delete any objects which conform to NSCoding. 

You need to specify the filename and the key for the archive.

The default root dir for the file is the documents directory, but you can also specify the library dir, and a custom intermediary path.

See the ALEArchiver.h for full documentation and custom options.

    ALEArchiver *archiver = [[ALEArchiver alloc] init];
    
    NSError *error = nil;
    
    //archiving and saving an object to a file
    [archiver saveObject:@"hello"
                withName:@"filename"
             inDirectory:nil
                     key:@"fileKey"
                 options:0
                   error:&error];

    //loading and decoding an object from a previosly saved file
    NSString *savedString = [archiver loadObjectWithFilename:@"filename"
                                                 inDirectory:nil
                                                         key:@"fileKey"
                                                     options:0];
    
    //deleting a file
    [archiver removeObjectWithFilename:@"filename"
                           inDirectory:nil
                               options:0
                                 error:&error];

# Installation
With CocoaPods:

       pod 'ALEArchiver', '~> 0.1.0' 
