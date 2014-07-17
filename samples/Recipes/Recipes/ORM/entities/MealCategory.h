#import <CoreData/CoreData.h>
@class Meal;

@interface MealCategory : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSSet *subcategories;
@property (nonatomic, strong) MealCategory *parentcategory;
@property (nonatomic, strong) NSSet *meals;
@end
