#import "ConditionDouble.h"

@interface ConditionDouble ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionDouble

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toDouble:(double)value
{
	return [self initWithFieldName:fieldName withOperator:operator toDouble:value withOperation:ConditionAggregateOperationNo];
}

- (instancetype)initWithFieldName:(NSString *)fieldName withOperator:(ConditionOperator)operator toDouble:(double)value withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ %@ %f)", [self stringOperation:operation], fieldName, [self stringOperator:operator], value];
	}
	
	return self;
}

@end