#import "ModelContext.h"

@interface ModelContext ()
{
	NSMutableArray *DTOs_IDs;
	NSMutableArray *DTOs_MOs;
}

@end

@implementation ModelContext

- (id)init
{
	self = [super init];
	
	DTOs_IDs = [NSMutableArray new];
	DTOs_MOs = [NSMutableArray new];
	
	return self;
}

- (BOOL)containsWithObjectID:(NSManagedObjectID *)objectID withClass:(Class)class
{
	for (NSDictionary *dict in DTOs_IDs)
	{
		if ([dict[@"id"] isEqual:objectID] && [dict[@"object"] isKindOfClass:class])
		{
			return YES;
		}
	}
	return NO;
}

- (id)objectWithObjectID:(NSManagedObjectID *)objectID withClass:(Class)class
{
	for (NSDictionary *dict in DTOs_IDs)
	{
		if ([dict[@"id"] isEqual:objectID] && [dict[@"object"] isKindOfClass:class])
		{
			return dict[@"object"];
		}
	}
	
	return nil;
}

- (void)addObject:(id)dto withObjectID:(NSManagedObjectID *)objectID
{
	assert([self containsWithObjectID:objectID withClass:[dto class]] == NO);
	
	[DTOs_IDs addObject:@{@"id" : objectID, @"object" : dto}];
}

//---

- (BOOL)containsEntityObjectForDTO:(id)dto
{
	return YES;
}

- (NSManagedObject *)entityObjectForDTO:(id)dto
{
	return nil;
}

- (void)addEntityObject:(NSManagedObject *)object forDTO:(id)dto
{
}

@end
