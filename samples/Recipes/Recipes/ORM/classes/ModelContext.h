
#import <CoreData/CoreData.h>

@interface ModelContext : NSObject

- (BOOL)containsWithObjectID:(NSManagedObjectID *)objectID withClass:(Class)class;
- (id)objectWithObjectID:(NSManagedObjectID *)objectID withClass:(Class)class;
- (void)addObject:(id)dto withObjectID:(NSManagedObjectID *)objectID;

- (BOOL)containsEntityObjectForDTO:(id)dto;
- (NSManagedObject *)entityObjectForDTO:(id)dto;
- (void)addEntityObject:(NSManagedObject *)object forDTO:(id)dto;

@end