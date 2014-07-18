#import "NutritionModel.h"

#import "DataManager.h"
#import "Food.h"
#import "Meal.h"
#import "ModelContext.h"

@interface NutritionModel ()


@end

@implementation NutritionModel

- (NutritionModelMealDTO *)NutritionModelMealWithMeal:(Meal *)meal withContext:(ModelContext *)ctx
{
	if ([ctx containsWithObjectID:meal.objectID withClass:NutritionModelMealDTO.class])
	{
		return [ctx objectWithObjectID:meal.objectID withClass:NutritionModelMealDTO.class];
	}
	NutritionModelMealDTO *dto = [NutritionModelMealDTO new];
	[ctx addObject:dto withObjectID:meal.objectID];
	dto.objectID = meal.objectID;
	dto.name = meal.name;
	for (Food *subfood in meal.foods)
	{
		NutritionModelMealFoodsDTO *subsubfoodDTO = [self NutritionModelMealFoodsWithFood:subfood withContext:ctx];
		[dto addFoodsObject:subsubfoodDTO];
	}
	return dto;
}
- (NutritionModelMealFoodsDTO *)NutritionModelMealFoodsWithFood:(Food *)food withContext:(ModelContext *)ctx
{
	if ([ctx containsWithObjectID:food.objectID withClass:NutritionModelMealFoodsDTO.class])
	{
		return [ctx objectWithObjectID:food.objectID withClass:NutritionModelMealFoodsDTO.class];
	}
	NutritionModelMealFoodsDTO *dto = [NutritionModelMealFoodsDTO new];
	[ctx addObject:dto withObjectID:food.objectID];
	dto.objectID = food.objectID;
	dto.name = food.name;
	dto.amount = food.amount;
	return dto;
}
- (NutritionModelFoodDTO *)NutritionModelFoodWithFood:(Food *)food withContext:(ModelContext *)ctx
{
	if ([ctx containsWithObjectID:food.objectID withClass:NutritionModelFoodDTO.class])
	{
		return [ctx objectWithObjectID:food.objectID withClass:NutritionModelFoodDTO.class];
	}
	NutritionModelFoodDTO *dto = [NutritionModelFoodDTO new];
	[ctx addObject:dto withObjectID:food.objectID];
	dto.objectID = food.objectID;
	dto.name = food.name;
	dto.amount = food.amount;
	return dto;
}

- (NSArray *)mealObjectsWithComporator:(NutritionModelMealComporator)comporator
{
	NSMutableArray *result = [NSMutableArray new];
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Meal" inManagedObjectContext:context];
		[request setEntity:entityDescription];
		
		if (comporator != nil)
		{
			NutritionModelMealComporatorContext *comporatorContext = [NutritionModelMealComporatorContext new];
			NSPredicate *predicate = [comporator(comporatorContext) predicate];
			[request setPredicate:predicate];
		}
		
		NSError *error = nil;
		NSArray *array = [context executeFetchRequest:request error:&error];
		if (array == nil)
		{
			//Deal with error...
		}
		else
		{
			ModelContext *ctx = [ModelContext new];
			for (Meal *meal in array)
			{
				[result addObject:[self NutritionModelMealWithMeal:meal withContext:ctx]];
			}
		}
	}
	@catch(NSException *e)
	{
		NSLog(@"%@", e);
	}
	@finally
	{
	}
	
	return result.copy;
}
- (NSArray *)foodObjectsWithComporator:(NutritionModelFoodComporator)comporator
{
	NSMutableArray *result = [NSMutableArray new];
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Food" inManagedObjectContext:context];
		[request setEntity:entityDescription];
		
		if (comporator != nil)
		{
			NutritionModelFoodComporatorContext *comporatorContext = [NutritionModelFoodComporatorContext new];
			NSPredicate *predicate = [comporator(comporatorContext) predicate];
			[request setPredicate:predicate];
		}
		
		NSError *error = nil;
		NSArray *array = [context executeFetchRequest:request error:&error];
		if (array == nil)
		{
			//Deal with error...
		}
		else
		{
			ModelContext *ctx = [ModelContext new];
			for (Food *food in array)
			{
				[result addObject:[self NutritionModelFoodWithFood:food withContext:ctx]];
			}
		}
	}
	@catch(NSException *e)
	{
		NSLog(@"%@", e);
	}
	@finally
	{
	}
	
	return result.copy;
}

- (void)saveMeal:(Meal *)meal withNutritionModelMealDTO:(NutritionModelMealDTO *)dto withContext:(ModelContext *)ctx
{
	meal.name = dto.name;
	{
		NSMutableSet *foodListNew = [NSMutableSet set];
		NSMutableSet *foodListOld = meal.foods.mutableCopy;
		for (NutritionModelMealFoodsDTO *item in dto.foods)
		{
			Food *subfood;
			if ([ctx containsEntityObjectForDTO:item] == YES)
			{
				subfood = (Food *)[ctx entityObjectForDTO:item];
			}
			else
			{
				if (item.objectID == nil)
				{
					subfood = (Food *)[NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:meal.managedObjectContext];
				}
				else
				{
					subfood = (Food *)[meal.managedObjectContext objectWithID:item.objectID];
				}
				[ctx addEntityObject:subfood forDTO:item];
				[self saveFood:subfood withNutritionModelMealFoodsDTO:item withContext:ctx];
			}
			[foodListNew addObject:subfood];
		}
		meal.foods = foodListNew.copy;
	}
}
- (void)saveFood:(Food *)food withNutritionModelMealFoodsDTO:(NutritionModelMealFoodsDTO *)dto withContext:(ModelContext *)ctx
{
	food.name = dto.name;
	food.amount = dto.amount;
}
- (void)saveFood:(Food *)food withNutritionModelFoodDTO:(NutritionModelFoodDTO *)dto withContext:(ModelContext *)ctx
{
	food.name = dto.name;
	food.amount = dto.amount;
}

- (void)saveNutritionModelMealDTO:(NutritionModelMealDTO *)mealDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		Meal *meal;
		if (mealDTO.objectID != nil)
		{
			meal = (Meal *)[context objectWithID:mealDTO.objectID];
		}
		else
		{
			meal = (Meal *)[NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:context];
		}
		ModelContext *ctx = [ModelContext new];
		[ctx addEntityObject:meal forDTO:mealDTO];
		[self saveMeal:meal withNutritionModelMealDTO:mealDTO withContext:ctx];
		[context save:nil];
	}
	@catch(NSException *e)
	{
		NSLog(@"%@", e);
	}
	@finally
	{
	}
	
}
- (void)saveNutritionModelFoodDTO:(NutritionModelFoodDTO *)foodDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		Food *food;
		if (foodDTO.objectID != nil)
		{
			food = (Food *)[context objectWithID:foodDTO.objectID];
		}
		else
		{
			food = (Food *)[NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
		}
		ModelContext *ctx = [ModelContext new];
		[ctx addEntityObject:food forDTO:foodDTO];
		[self saveFood:food withNutritionModelFoodDTO:foodDTO withContext:ctx];
		[context save:nil];
	}
	@catch(NSException *e)
	{
		NSLog(@"%@", e);
	}
	@finally
	{
	}
	
}

@end