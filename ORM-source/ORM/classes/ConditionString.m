#import "ConditionString.h"

@interface ConditionString ()

@property (nonatomic, strong) NSString *condition;

@end

@implementation ConditionString

- (instancetype)initWithFieldName:(NSString *)fieldName equalToString:(NSString *)string
{
	return [self initWithFieldName:fieldName equalToString:string withOperation:ConditionAggregateOperationNo];
}
- (instancetype)initWithFieldName:(NSString *)fieldName likeToPattern:(NSString *)pattern
{
	return [self initWithFieldName:fieldName likeToPattern:pattern withOperation:ConditionAggregateOperationNo];
}
- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName
{
	return [self initIsNULLWithFieldName:fieldName withOperation:ConditionAggregateOperationNo];
}

- (instancetype)initWithFieldName:(NSString *)fieldName equalToString:(NSString *)string withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == '%@')", fieldName, string];
	}
	
	return self;
}

- (instancetype)initWithFieldName:(NSString *)fieldName likeToPattern:(NSString *)pattern withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ like '%@')", fieldName, pattern];
	}
	
	return self;
}

- (instancetype)initIsNULLWithFieldName:(NSString *)fieldName withOperation:(ConditionAggregateOperation)operation
{
	self = [super init];
	
	if (self)
	{
		self.condition = [NSString stringWithFormat:@"(%@ == '%@')", fieldName, nil];
	}
	
	return self;
}

@end