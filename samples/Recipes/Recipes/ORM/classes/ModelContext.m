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
	for (NSDictionary *d in DTOs_MOs)
	{
		if (d[@"dto"] == dto)
		{
			return YES;
		}
	}
	return NO;
}

- (NSManagedObject *)entityObjectForDTO:(id)dto
{
	for (NSDictionary *d in DTOs_MOs)
	{
		if (d[@"dto"] == dto)
		{
			return d[@"mo"];
		}
	}
	return nil;
}

- (void)addEntityObject:(NSManagedObject *)object forDTO:(id)dto
{
	assert([self containsEntityObjectForDTO:dto] == NO);
	
	[DTOs_MOs addObject:@{@"dto" : dto, @"mo" : object}];
}

@end
