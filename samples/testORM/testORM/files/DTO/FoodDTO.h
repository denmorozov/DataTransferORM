#import <CoreData/CoreData.h>
@class MealDTO;

@interface FoodDTO : NSObject
@property (nonatomic, strong) NSManagedObjectID *objectID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, strong) MealDTO *meal;
@end
