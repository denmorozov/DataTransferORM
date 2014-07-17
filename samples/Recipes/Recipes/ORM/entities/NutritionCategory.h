#import <CoreData/CoreData.h>
@class Meal;

@interface NutritionCategory : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet *subcategories;
@property (nonatomic, strong) NutritionCategory *parentcategory;
@property (nonatomic, strong) NSSet *meals;
@end
