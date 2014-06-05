//
//  AppDelegate.m
//  testORM
//
//  Created by Denis Morozov on 01.06.14.
//

#import "AppDelegate.h"

#import "DataManager.h"

#import "NutritionModel.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[DataManager sharedInstance];
	
	//create
	{
		NutritionModel *model = [[NutritionModel alloc] init];
		
		FoodDTO *f = [[FoodDTO alloc] init];
		
		f.amount = 2.1f;
		f.name = @"fff";
		
		[model createFoodDTO:f];
	}
	
	//create
	{
		NutritionModel *model = [[NutritionModel alloc] init];
		
		FoodDTO *f = [[FoodDTO alloc] init];
		
		f.amount = 1.1f;
		f.name = @"qqw";
		
		[model createFoodDTO:f];
	}
	
	//select
	{
		NutritionModel *model = [[NutritionModel alloc] init];
		
		NSArray *arr = [model foodObjectsWithComporator:^Condition *(NutritionModelFoodComporatorContext *ctx) {
			return AND( OR([ctx.name equal:@"fff"], [ctx.name equal:@"qqw"], nil), [ctx.amount more:1.5f], nil);
		}];
		
		NSLog(@"%@", arr);
	}
	
	//select
	{
		NutritionModel *model = [[NutritionModel alloc] init];
		
		NSArray *arr = [model foodObjectsWithComporator:^Condition *(NutritionModelFoodComporatorContext *ctx) {
			return OR([ctx.name equal:@"fff"], [ctx.name equal:@"qqw"], nil);
		}];
		
		NSLog(@"%@", arr);
	}
	
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
