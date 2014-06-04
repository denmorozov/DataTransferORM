from generate_model.templates import methodTemplate

def generateSetPropertiesForToManyForSelect(entity, property, tabs):
    
    lines = []
    
    lines.append('')
    
    var = entity.name.lower()
    subentity = property.relationship.entity.name
    subvar = property.relationship.entity.name.lower()
    collectionName = subvar + 'List'
    
    lines.append(tabs + 'NSMutableArray *{cn} = [NSMutableArray new];'.format(cn = collectionName))
    
    #foreach begin
    lines.append(tabs + 'for ({se} *{sv} in {v}.{pn})'.format(se = subentity, sv = subvar, v = var, pn = property.name))
    lines.append(tabs + '{')
    
    lines.append(tabs + '\t' + '{se}DTO *{sv}DTO = [[{se}DTO alloc] init];'.format(sv = subvar, se = subentity));
    lines.append(tabs + '\t' + '[{cn} addObject:{sv}DTO];'.format(cn = collectionName, sv = subvar))
    
    #generate set sub-properties
    subpropertiesList = generateSetPropertiesForSelect(entity, property.relationship.entity, property.properties, tabs + '\t')
    lines += subpropertiesList #join two arrays
    
    lines.append(tabs + '}')
    #forneach end
    
    lines.append(tabs + '{v}DTO.{pn} = {cn};'.format(cn = collectionName, v = var, pn = property.name))
    
    return lines

def generateSetPropertiesForToOneForSelect(entity, property, tabs):
    lines = []
    var = entity.name.lower()
    subentity = property.relationship.entity.name
    subvar = property.relationship.entity.name.lower()
    lines.append(tabs + '')
    lines.append(tabs + 'if ({v}.{pn} != nil)'.format(v = var, pn = property.name))
    lines.append(tabs + '{')
    lines.append(tabs + '\t' + '{se}DTO *{sv}DTO = [[{se}DTO alloc] init];'.format(se = subentity, sv = subvar))
    lines.append(tabs + '\t' + '{se} *{sv} = {v}.{sv};'.format(se = subentity, sv = subvar, v = var))
    lines += generateSetPropertiesForSelect(entity, property.relationship.entity, property.properties, tabs + '\t')
    lines.append(tabs + '\t' + '{v}DTO.{pn} = {sv}DTO;'.format(sv = subvar, v = var, pn = property.name))
    lines.append(tabs + '}')
    
    return lines

def generateSetPropertiesForSelect(rootentity, entity, properties, tabs):
    lines = []
    
    lines.append('{t}{v}DTO.objectID = {v}.objectID;'.format(t = tabs, v = entity.name.lower()))
    
    for property in properties:
        
        #scalar property
        if property.relationship == None:
            lines.append('{t}{v}DTO.{pn} = {v}.{pn};'.format(t = tabs, v = entity.name.lower(), pn = property.name))
            continue
        
        #check inverse property
        if rootentity != None and rootentity.containsRelationshipWithNameAndInverse(property.relationship.inverse, property.relationship.name) == True:
            continue
        
        if property.relationship.type == 'toMany':
            lines += generateSetPropertiesForToManyForSelect(entity, property, tabs)
        
        if property.relationship.type == 'toOne':
            lines += generateSetPropertiesForToOneForSelect(entity, property, tabs)
        
    return lines

def generateConvertToDTOMethod(model):
    lines = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        lines.append('- (NSArray *){v}ObjectsConvertToDTO:(NSArray *)array'.format(v = var))
        
        lines.append('{')
        lines.append('\tNSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:array.count];')
        lines.append('\t')
        lines.append('\tfor ({e} *{v} in array)'.format(e = entity, v = var))
        lines.append('\t{')
        lines.append('\t\t{e}DTO *{v}DTO = [[{e}DTO alloc] init];'.format(e = entity, v = var))
        lines += generateSetPropertiesForSelect(None, struct.entity, struct.properties, '\t\t')
        lines.append('\t\t')
        lines.append('\t\t[result addObject:{v}DTO];'.format(v = var))
        lines.append('\t}')
        lines.append('\t')
        lines.append('\treturn result.copy;')
        
        lines.append('}')
    
    return '\n'.join(lines)

def generateSelectDTOMethodsNames(model):
    methodNames = []
    for struct in model.structs:
        var = struct.entity.name.lower()
        entity = struct.entity.name
        methodNames.append('- (NSArray *){v}ObjectsWithComporator:({mn}{en}Comporator)comporator;'.format(mn = model.name, v = var, en = entity))
    return methodNames

def generateSelectDTOMethod(model):
    methods = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        tryBlock = []
        tryBlock.append('NSFetchRequest *request = [[NSFetchRequest alloc] init];')
        tryBlock.append('')
        tryBlock.append('NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"{e}" inManagedObjectContext:context];'.format(e = entity, v = var))
        tryBlock.append('[request setEntity:entityDescription];')
        tryBlock.append('')
        tryBlock.append('if (comporator != nil)')
        tryBlock.append('{')
        tryBlock.append('\t{mn}{en}ComporatorContext *comporatorContext = [{mn}{en}ComporatorContext new];'.format(mn = model.name, en = entity))
        tryBlock.append('\tNSPredicate *predicate = [comporator(comporatorContext) predicate];'.format(v = var))
        tryBlock.append('\t[request setPredicate:predicate];')
        tryBlock.append('}')
        tryBlock.append('')
        
        tryBlock.append('NSError *error = nil;')
        tryBlock.append('NSArray *array = [context executeFetchRequest:request error:&error];')
        tryBlock.append('if (array == nil)')
        tryBlock.append('{')
        tryBlock.append('\t//Deal with error...')
        tryBlock.append('}')
        tryBlock.append('else')
        tryBlock.append('{')
        tryBlock.append('\tresult = [self {v}ObjectsConvertToDTO:array];'.format(v = var))
        tryBlock.append('}')
        
        exceptionBlock = ['NSLog(@"%@", e);']
        finallyBlock = []
        
        methodName = '- (NSArray *){v}ObjectsWithComporator:({mn}{en}Comporator)comporator'.format(mn = model.name, v = var, en = entity)
        
        methods.append(methodName + '\n' + methodTemplate(['NSArray *result = nil;'], tryBlock, exceptionBlock, finallyBlock, ['return result;']))
    return '\n'.join(methods)
