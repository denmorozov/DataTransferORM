#import "CategoryModel.h"

#import "DataManager.h"
#import "NutritionCategory.h"
#import "Meal.h"
#import "ModelContext.h"

@interface CategoryModel ()


@end

@implementation CategoryModel

- (CategoryModelNutritionCategoryDTO *)CategoryModelNutritionCategoryWithNutritionCategory:(NutritionCategory *)nutritioncategory withContext:(ModelContext *)ctx
{
	if ([ctx containsWithObjectID:nutritioncategory.objectID withClass:CategoryModelNutritionCategoryDTO.class])
	{
		return [ctx objectWithObjectID:nutritioncategory.objectID withClass:CategoryModelNutritionCategoryDTO.class];
	}
	CategoryModelNutritionCategoryDTO *dto = [CategoryModelNutritionCategoryDTO new];
	[ctx addObject:dto withObjectID:nutritioncategory.objectID];
	dto.objectID = nutritioncategory.objectID;
	dto.name = nutritioncategory.name;
	for (NutritionCategory *subnutritioncategory in nutritioncategory.subcategories)
	{
		CategoryModelNutritionCategoryDTO *subsubnutritioncategoryDTO = [self CategoryModelNutritionCategoryWithNutritionCategory:subnutritioncategory withContext:ctx];
		[dto addSubcategoriesObject:subsubnutritioncategoryDTO];
	}
	for (Meal *submeal in nutritioncategory.meals)
	{
		CategoryModelNutritionCategoryMealsDTO *subsubmealDTO = [self CategoryModelNutritionCategoryMealsWithMeal:submeal withContext:ctx];
		[dto addMealsObject:subsubmealDTO];
	}
	return dto;
}
- (CategoryModelNutritionCategoryMealsDTO *)CategoryModelNutritionCategoryMealsWithMeal:(Meal *)meal withContext:(ModelContext *)ctx
{
	if ([ctx containsWithObjectID:meal.objectID withClass:CategoryModelNutritionCategoryMealsDTO.class])
	{
		return [ctx objectWithObjectID:meal.objectID withClass:CategoryModelNutritionCategoryMealsDTO.class];
	}
	CategoryModelNutritionCategoryMealsDTO *dto = [CategoryModelNutritionCategoryMealsDTO new];
	[ctx addObject:dto withObjectID:meal.objectID];
	dto.objectID = meal.objectID;
	dto.name = meal.name;
	return dto;
}

- (NSArray *)nutritioncategoryObjectsWithComporator:(CategoryModelNutritionCategoryComporator)comporator
{
	NSMutableArray *result = [NSMutableArray new];
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		
		NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"NutritionCategory" inManagedObjectContext:context];
		[request setEntity:entityDescription];
		
		if (comporator != nil)
		{
			CategoryModelNutritionCategoryComporatorContext *comporatorContext = [CategoryModelNutritionCategoryComporatorContext new];
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
			for (NutritionCategory *nutritioncategory in array)
			{
				[result addObject:[self CategoryModelNutritionCategoryWithNutritionCategory:nutritioncategory withContext:ctx]];
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

- (void)saveNutritionCategory:(NutritionCategory *)nutritioncategory withCategoryModelNutritionCategoryDTO:(CategoryModelNutritionCategoryDTO *)dto withContext:(ModelContext *)ctx
{
	nutritioncategory.name = dto.name;
	{
		NSMutableSet *nutritioncategoryListNew = [NSMutableSet set];
		NSMutableSet *nutritioncategoryListOld = nutritioncategory.subcategories.mutableCopy;
		for (CategoryModelNutritionCategoryDTO *item in dto.subcategories)
		{
			NutritionCategory *subnutritioncategory;
			if ([ctx containsEntityObjectForDTO:item] == YES)
			{
				subnutritioncategory = (NutritionCategory *)[ctx entityObjectForDTO:item];
			}
			else
			{
				if (item.objectID == nil)
				{
					subnutritioncategory = (NutritionCategory *)[NSEntityDescription insertNewObjectForEntityForName:@"NutritionCategory" inManagedObjectContext:nutritioncategory.managedObjectContext];
				}
				else
				{
					subnutritioncategory = (NutritionCategory *)[nutritioncategory.managedObjectContext objectWithID:item.objectID];
				}
				[ctx addEntityObject:subnutritioncategory forDTO:item];
				[self saveNutritionCategory:subnutritioncategory withCategoryModelNutritionCategoryDTO:item withContext:ctx];
			}
			[nutritioncategoryListNew addObject:subnutritioncategory];
		}
		nutritioncategory.subcategories = nutritioncategoryListNew.copy;
	}
	{
		NSMutableSet *mealListNew = [NSMutableSet set];
		NSMutableSet *mealListOld = nutritioncategory.meals.mutableCopy;
		for (CategoryModelNutritionCategoryMealsDTO *item in dto.meals)
		{
			Meal *submeal;
			if ([ctx containsEntityObjectForDTO:item] == YES)
			{
				submeal = (Meal *)[ctx entityObjectForDTO:item];
			}
			else
			{
				if (item.objectID == nil)
				{
					submeal = (Meal *)[NSEntityDescription insertNewObjectForEntityForName:@"Meal" inManagedObjectContext:nutritioncategory.managedObjectContext];
				}
				else
				{
					submeal = (Meal *)[nutritioncategory.managedObjectContext objectWithID:item.objectID];
				}
				[ctx addEntityObject:submeal forDTO:item];
				[self saveMeal:submeal withCategoryModelNutritionCategoryMealsDTO:item withContext:ctx];
			}
			[mealListNew addObject:submeal];
		}
		nutritioncategory.meals = mealListNew.copy;
	}
}
- (void)saveMeal:(Meal *)meal withCategoryModelNutritionCategoryMealsDTO:(CategoryModelNutritionCategoryMealsDTO *)dto withContext:(ModelContext *)ctx
{
	meal.name = dto.name;
}

- (void)saveCategoryModelNutritionCategoryDTO:(CategoryModelNutritionCategoryDTO *)nutritioncategoryDTO
{
	
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
	context.persistentStoreCoordinator = [DataManager sharedInstance].persistentStoreCoordinator;
	@try
	{
		NutritionCategory *nutritioncategory;
		if (nutritioncategoryDTO.objectID != nil)
		{
			nutritioncategory = (NutritionCategory *)[context objectWithID:nutritioncategoryDTO.objectID];
		}
		else
		{
			nutritioncategory = (NutritionCategory *)[NSEntityDescription insertNewObjectForEntityForName:@"NutritionCategory" inManagedObjectContext:context];
		}
		ModelContext *ctx = [ModelContext new];
		[ctx addEntityObject:nutritioncategory forDTO:nutritioncategoryDTO];
		[self saveNutritionCategory:nutritioncategory withCategoryModelNutritionCategoryDTO:nutritioncategoryDTO withContext:ctx];
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