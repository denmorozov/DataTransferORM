
#import "DataManager.h"

#import <CoreData/CoreData.h>

@interface DataManager ()

@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DataManager

+ (DataManager *)sharedInstance
{
	static dispatch_once_t pred;
	static DataManager *sharedInstance = nil;
	dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
	return sharedInstance;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		NSDictionary *dictEntity = @{
			@"Food" : @[
				@{@"property" : @"relationship", @"name" : @"meal", @"inverse" : @"foods", @"entity" : @"Meal", @"type" : @"toOne"},
				@{@"property" : @"field", @"name" : @"name", @"type" : @"string"},
				@{@"property" : @"field", @"name" : @"amount", @"type" : @"float"},
			],
			@"Meal" : @[
				@{@"property" : @"relationship", @"name" : @"foods", @"inverse" : @"meal", @"entity" : @"Food", @"type" : @"toMany"},
				@{@"property" : @"field", @"name" : @"name", @"type" : @"string"},
			],
		};
		
		NSMutableDictionary *dictEntityDescription = [NSMutableDictionary new];
		
		for (NSString *entityName in dictEntity)
		{
			NSEntityDescription *entityDescription = [[NSEntityDescription alloc] init];
			entityDescription.name = entityName;
			entityDescription.managedObjectClassName = entityName;
			
			[dictEntityDescription setObject:entityDescription forKey:entityName];
			
			NSMutableArray *entityProperties = [NSMutableArray new];
			
			NSArray *entityFields = dictEntity[entityName];
			
			for (NSDictionary *field in entityFields)
			{
				if ([field[@"property"] isEqualToString:@"field"])
				{
					NSAttributeDescription *attributeDescription = [[NSAttributeDescription alloc] init];
					attributeDescription.name = field[@"name"];
					[entityProperties addObject:attributeDescription];
				}
				if ([field[@"property"] isEqualToString:@"relationship"])
				{
					NSRelationshipDescription *relationshipDescription = [[NSRelationshipDescription alloc] init];
					relationshipDescription.name = field[@"name"];
					[entityProperties addObject:relationshipDescription];
				}
			}
			
			entityDescription.properties = entityProperties;
		}
		
		for (NSString *entityName in dictEntity)
		{
			NSEntityDescription *entityDescription = dictEntityDescription[entityName];
			
			NSArray *entityFields = dictEntity[entityName];
			
			for (NSDictionary *field in entityFields)
			{
				if ([field[@"property"] isEqualToString:@"field"])
				{
					NSAttributeDescription *attribute = entityDescription.attributesByName[field[@"name"]];
					
					/*
					NSUndefinedAttributeType = 0,
					NSInteger16AttributeType = 100,
					NSInteger32AttributeType = 200,
					NSInteger64AttributeType = 300,
					NSDecimalAttributeType = 400,
					NSDoubleAttributeType = 500,
					NSFloatAttributeType = 600,
					NSStringAttributeType = 700,
					NSBooleanAttributeType = 800,
					NSDateAttributeType = 900,
					NSBinaryDataAttributeType = 1000,
					NSTransformableAttributeType = 1800,
					NSObjectIDAttributeType = 2000
					*/
					if ([field[@"type"] isEqualToString:@"string"])
					{
						attribute.attributeType = NSStringAttributeType;
					}
					else if ([field[@"type"] isEqualToString:@"float"])
					{
						attribute.attributeType = NSFloatAttributeType;
					}
				}
				if ([field[@"property"] isEqualToString:@"relationship"])
				{
					NSRelationshipDescription *relationshipDescription = entityDescription.relationshipsByName[field[@"name"]];
					
					if ([field[@"type"] isEqualToString:@"toOne"])
					{
						relationshipDescription.maxCount = 1;
					}
					else //if ([field[@"type"] isEqualToString:@"toMany"])
					{
						relationshipDescription.maxCount = 0;
					}
					
					relationshipDescription.destinationEntity = dictEntityDescription[field[@"entity"]];
					relationshipDescription.inverseRelationship = relationshipDescription.destinationEntity.relationshipsByName[field[@"inverse"]];
				}
			}
		}
		
		NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] init];
		mom.entities = dictEntityDescription.allValues;
		
		NSString* path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		NSURL *storeURL = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"DB.sqlite"]];
		
		self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
		[self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
													  configuration:nil
																URL:storeURL
															options:nil
															  error:nil];
	}
	return self;
}

@end