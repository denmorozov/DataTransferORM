#import "ConditionDate.h"

@interface ConditionDate ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionDate

- (instancetype)initWithFieldName:(NSString *)fieldName
					 withOperator:(ConditionOperator)operator
						withValue:(NSDate *)value
{
	return [self initWithFieldName:fieldName withOperator:operator withValue:value withOperation:ConditionAggregateOperationNo];
}

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName
{
	return [self initIsNULLWithFieldName:fieldName withOperation:ConditionAggregateOperationNo];
}

- (instancetype)initWithFieldName:(NSString *)fieldName
					 withOperator:(ConditionOperator)operator
						withValue:(NSDate *)value
					withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ %@ '%@')", [self stringOperation:operation], fieldName, [self stringOperator:operator], value];
	}
	
	return self;
}

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName
						  withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ %@ == nil)", [self stringOperation:operation], fieldName];
	}
	
	return self;
}

@end