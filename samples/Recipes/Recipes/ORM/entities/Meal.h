#import <CoreData/CoreData.h>
@class Food;
@class NutritionCategory;

@interface Meal : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet *foods;
@property (nonatomic, strong) NutritionCategory *category;
@end
