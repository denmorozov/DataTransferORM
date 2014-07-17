//
//  AppDelegate.m
//  Recipes
//
//  Created by Denis Morozov on 16.07.14.
//  Copyright (c) 2014 Denis Morozov. All rights reserved.
//

#import "AppDelegate.h"

#import "NutritionModel.h"
#import "CategoryModel.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	
	
	//save food
//	NutritionModelFoodDTO * food = [NutritionModelFoodDTO new];
//	food.name = @"";
//	food.amount = 1.0f;
//	
//	NutritionModel *model = [NutritionModel new];
//	
//	[model saveNutritionModelFoodDTO:food];

	
	//select foods
//	NutritionModel *model = [NutritionModel new];
//	
//	NSArray * foods = [model foodObjectsWithComporator:^Condition *(NutritionModelFoodComporatorContext *ctx) {
//		return [ctx.name equal:@""];
//	}];
//	
//	NSLog(@"%@", foods);
	
	
	//save categories
//	CategoryModelNutritionCategoryDTO *meatCategory = [CategoryModelNutritionCategoryDTO new];
//	
//	meatCategory.name = @"Meat";
//	
//	CategoryModelNutritionCategoryDTO *chikenCategory = [CategoryModelNutritionCategoryDTO new];
//	
//	chikenCategory.name = @"Chiken";
//	
//	CategoryModelNutritionCategoryDTO *pigCategory = [CategoryModelNutritionCategoryDTO new];
//	
//	pigCategory.name = @"Pig";
//	
//	[meatCategory addSubcategoriesObject:chikenCategory];
//	[meatCategory addSubcategoriesObject:pigCategory];
//	
//	CategoryModel *model = [CategoryModel new];
//	
//	[model saveCategoryModelNutritionCategoryDTO:meatCategory];
	
	
	//select categories
//	CategoryModel *model = [CategoryModel new];
//	
//	NSArray *categories = [model nutritioncategoryObjectsWithComporator:^Condition *(CategoryModelNutritionCategoryComporatorContext *ctx) {
//		return [ctx.name equal:@"Meat"];
//	}];
//	
//	NSLog(@"%@", categories);
	
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
