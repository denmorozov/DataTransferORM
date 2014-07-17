#import <CoreData/CoreData.h>
@class NutritionModelMealCategoryDTO;
@class NutritionModelMealCategoryMealsDTO;

@interface NutritionModelMealCategoryDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *subcategories;
- (void)addSubcategoriesObject:(NutritionModelMealCategoryDTO *)object;
- (void)removeSubcategoriesObject:(NutritionModelMealCategoryDTO *)object;

@property (nonatomic, strong) NSArray *meals;
- (void)addMealsObject:(NutritionModelMealCategoryMealsDTO *)object;
- (void)removeMealsObject:(NutritionModelMealCategoryMealsDTO *)object;

@end
