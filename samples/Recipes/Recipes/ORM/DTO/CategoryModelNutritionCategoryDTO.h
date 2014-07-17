#import <CoreData/CoreData.h>
@class CategoryModelNutritionCategoryDTO;
@class CategoryModelNutritionCategoryMealsDTO;

@interface CategoryModelNutritionCategoryDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *subcategories;
- (void)addSubcategoriesObject:(CategoryModelNutritionCategoryDTO *)object;
- (void)removeSubcategoriesObject:(CategoryModelNutritionCategoryDTO *)object;

@property (nonatomic, strong) NSArray *meals;
- (void)addMealsObject:(CategoryModelNutritionCategoryMealsDTO *)object;
- (void)removeMealsObject:(CategoryModelNutritionCategoryMealsDTO *)object;

@end
