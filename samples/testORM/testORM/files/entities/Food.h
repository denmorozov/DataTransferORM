#import <CoreData/CoreData.h>
@class Meal;

@interface Food : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CGFloat amount;
@property (nonatomic, strong) Meal *meal;
@end
