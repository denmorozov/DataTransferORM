#import "NutritionModel.h"

#import "DataManager.h"
#import "Meal.h"
#import "Food.h"
#import "A.h"
#import "B.h"

@interface NutritionModel ()


@end

@implementation NutritionModel

- (NSArray *)mealObjectsConvertToDTO:(NSArray *)array
{
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:array.count];
	
	for (Meal *meal in array)
	{
		MealDTO *mealDTO = [[MealDTO alloc] init];
		mealDTO.objectID = meal.objectID;
		mealDTO.name = meal.name;
		
		if (meal.a != nil)
		{
			ADTO *aDTO = [[ADTO alloc] init];
			A *a = meal.a;
			aDTO.objectID = a.objectID;
			aDTO.nameA = a.nameA;
			mealDTO.a = aDTO;
		}

		NSMutableArray *foodList = [NSMutableArray new];
		for (Food *food in meal.foods)
		{
			FoodDTO *foodDTO = [[FoodDTO alloc] init];
			[foodList addObject:foodDTO];
			foodDTO.objectID = food.objectID;
			foodDTO.name = food.name;
			foodDTO.amount = food.amount;
			
			if (food.b != nil)
			{
				BDTO *bDTO = [[BDTO alloc] init];
				B *b = food.b;
				bDTO.objectID = b.objectID;
				bDTO.nameB = b.nameB;
				foodDTO.b = bDTO;
			}
		}
		mealDTO.foods = foodList;
		
		[result addObject:mealDTO];
	}
	
	return result.copy;
}
- (NSArray *)foodObjectsConvertToDTO:(NSArray *)array
{
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:array.count];
	
	for (Food *food in array)
	{
		FoodDTO *foodDTO = [[FoodDTO alloc] init];
		foodDTO.objectID = food.objectID;
		foodDTO.name = food.name;
		foodDTO.amount = food.amount;
		
		[result addObject:foodDTO];
	}
	
	return result.copy;
}

- (NSArray *)mealObjectsWithComporator:(NutritionModelMealComporator)comporator
{
	NSArray *result = nil;
	
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
			result = [self mealObjectsConvertToDTO:array];
		}
	}
	@catch(NSException *e)
	{
		NSLog(@"%@", e);
	}
	@finally
	{
	}
	
	return result;
}
- (NSArray *)foodObjectsWithComporator:(NutritionModelFoodComporator)comporator
{
	NSArray *result = nil;
	
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
			result = [self foodObjectsConvertToDTO:array];
		}
	}
	@catch(NSException *e)
	{
		NSLog(@"%@", e);
	}
	@finally
	{
	}
	
	return result;
}

- (void)saveMealDTO:(MealDTO *)mealDTO withMeal:(Meal *)meal inContext:(NSManagedObjectContext *)context
{
	meal.name = mealDTO.name;
	
	if (mealDTO.a == nil)
	{
		meal.a = nil;
	}
	else
	{
		if (meal.a == nil)
		{
			meal.a = (A *)[NSEntityDescription insertNewObjectForEntityForName:@"A" inManagedObjectContext:context];
		}
		A *a = meal.a;
		ADTO *aDTO = mealDTO.a;
		a.nameA = aDTO.nameA;
	}

	NSMutableSet *foodListNew = [NSMutableSet set];
	NSMutableSet *foodListOld = meal.foods.mutableCopy;
	for (FoodDTO *foodDTO in mealDTO.foods)
	{
		Food *food = nil;
		if (foodDTO.objectID == nil)
		{
			food = (Food *)[NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
		}
		else
		{
			food = (Food *)[context objectWithID:foodDTO.objectID];
			[foodListOld removeObject:food];
		}
		[foodListNew addObject:food];
		food.name = foodDTO.name;
		food.amount = foodDTO.amount;
		
		if (foodDTO.b == nil)
		{
			food.b = nil;
		}
		else
		{
			if (food.b == nil)
			{
				food.b = (B *)[NSEntityDescription insertNewObjectForEntityForName:@"B" inManagedObjectContext:context];
			}
			B *b = food.b;
			BDTO *bDTO = foodDTO.b;
			b.nameB = bDTO.nameB;
		}
	}
	meal.foods = foodListNew;
	for (Food *food in foodListOld)
	{
		[context deleteObject:food];
	}
}
- (void)saveFoodDTO:(FoodDTO *)foodDTO withFood:(Food *)food inContext:(NSManagedObjectContext *)context
{
	food.name = foodDTO.name;
	food.amount = foodDTO.amount;
}

- (void)saveMealDTO:(MealDTO *)mealDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		Meal *meal = (Meal *)[context objectWithID:mealDTO.objectID];
		[self saveMealDTO:mealDTO withMeal:meal inContext:context];
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
- (void)saveFoodDTO:(FoodDTO *)foodDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		Food *food = (Food *)[context objectWithID:foodDTO.objectID];
		[self saveFoodDTO:foodDTO withFood:food inContext:context];
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

- (void)createMealDTO:(MealDTO *)mealDTO withMeal:(Meal *)meal inContext:(NSManagedObjectContext *)context
{
	meal.name = mealDTO.name;
	
	if (mealDTO.a != nil)
	{
		A *a = (A *)[NSEntityDescription insertNewObjectForEntityForName:@"A" inManagedObjectContext:context];
		ADTO *aDTO = mealDTO.a;
		a.nameA = aDTO.nameA;
		meal.a = a;
	}

	NSMutableSet *foodList = [NSMutableSet set];
	for (FoodDTO *foodDTO in mealDTO.foods)
	{
		Food *food = (Food *)[NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
		[foodList addObject:food];
		food.name = foodDTO.name;
		food.amount = foodDTO.amount;
		
		if (foodDTO.b != nil)
		{
			B *b = (B *)[NSEntityDescription insertNewObjectForEntityForName:@"B" inManagedObjectContext:context];
			BDTO *bDTO = foodDTO.b;
			b.nameB = bDTO.nameB;
			food.b = b;
		}
	}
	meal.foods = foodList;
}
- (void)createFoodDTO:(FoodDTO *)foodDTO withFood:(Food *)food inContext:(NSManagedObjectContext *)context
{
	food.name = foodDTO.name;
	food.amount = foodDTO.amount;
}

- (void)createMealDTO:(MealDTO *)mealDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		Meal *meal = (Meal *)[NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:context];
		[self createMealDTO:mealDTO withMeal:meal inContext:context];
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
- (void)createFoodDTO:(FoodDTO *)foodDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		Food *food = (Food *)[NSEntityDescription insertNewObjectForEntityForName:@"Food" inManagedObjectContext:context];
		[self createFoodDTO:foodDTO withFood:food inContext:context];
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