#import "ConditionFloat.h"

@interface ConditionFloat ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionFloat

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toFloat:(CGFloat)value
{
	return [self initWithFieldName:fieldName withOperator:operator toFloat:value withOperation:ConditionAggregateOperationNo];
}
- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toFloat:(CGFloat)value withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ %@ %f)", [self stringOperation:operation], fieldName, [self stringOperator:operator], value];
	}
	
	return self;
}

@end