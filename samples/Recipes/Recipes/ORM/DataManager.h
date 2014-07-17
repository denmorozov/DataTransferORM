@class NSPersistentStoreCoordinator;

@interface DataManager : NSObject

@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager *)sharedInstance;

@end