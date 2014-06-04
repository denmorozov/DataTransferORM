from generate_model.templates import methodTemplate

def generateSetPropertiesForToManyForCreate(entity, property, tabs):
    
    lines = []
    
    lines.append('')
    
    var = entity.name.lower()
    subentity = property.relationship.entity.name
    subvar = property.relationship.entity.name.lower()
    collectionName = subvar + 'List'
    
    lines.append(tabs + 'NSMutableSet *{cn} = [NSMutableSet set];'.format(cn = collectionName))
    
    #foreach begin
    lines.append(tabs + 'for ({se}DTO *{sv}DTO in {v}DTO.{pn})'.format(se = subentity, sv = subvar, v = var, pn = property.name))
    lines.append(tabs + '{')
    
    #generate follow source code
    #   entityVar = (EntityClass *)[NSEntityDescription insertNewObjectForEntityForName:@"EntityName" inManagedObjectContext:context];
    #   [collectionNew addObject:entityVar];
    lines.append(tabs + '\t' + '{se} *{sv} = ({se} *)[NSEntityDescription insertNewObjectForEntityForName:@"{se}" inManagedObjectContext:context];'.format(sv = subvar, se = subentity));
    lines.append(tabs + '\t' + '[{cn} addObject:{sv}];'.format(cn = collectionName, sv = subvar))
    
    #generate set sub-properties
    subpropertiesList = generateSetPropertiesForCreate(entity, property.relationship.entity, property.properties, tabs + '\t')
    lines += subpropertiesList #join two arrays
    
    lines.append(tabs + '}')
    #forneach end
    
    lines.append(tabs + '{v}.{pn} = {cn};'.format(cn = collectionName, v = var, pn = property.name))
    
    return lines

def generateSetPropertiesForToOneForCreate(entity, property, tabs):
    lines = []
    var = entity.name.lower()
    subentity = property.relationship.entity.name
    subvar = property.relationship.entity.name.lower()
    lines.append(tabs + '')
    lines.append(tabs + 'if ({v}DTO.{pn} != nil)'.format(v = var, pn = property.name))
    lines.append(tabs + '{')
    lines.append(tabs + '\t' + '{se} *{sv} = ({se} *)[NSEntityDescription insertNewObjectForEntityForName:@"{se}" inManagedObjectContext:context];'.format(se = subentity, sv = subvar))
    lines.append(tabs + '\t' + '{se}DTO *{sv}DTO = {v}DTO.{pn};'.format(se = subentity, sv = subvar, v = var, pn = property.name))
    lines += generateSetPropertiesForCreate(entity, property.relationship.entity, property.properties, tabs + '\t')
    lines.append(tabs + '\t' + '{v}.{pn} = {sv};'.format(sv = subvar, v = var, pn = property.name))
    lines.append(tabs + '}')
    
    return lines

def generateSetPropertiesForCreate(rootentity, entity, properties, tabs):
    lines = []
    
    for property in properties:
        
        #scalar property
        if property.relationship == None:
            lines.append('{t}{v}.{pn} = {v}DTO.{pn};'.format(t = tabs, v = entity.name.lower(), pn = property.name))
            continue
        
        #check inverse property
        if rootentity != None and rootentity.containsRelationshipWithNameAndInverse(property.relationship.inverse, property.relationship.name) == True:
            continue
        
        if property.relationship.type == 'toMany':
            lines += generateSetPropertiesForToManyForCreate(entity, property, tabs)
        
        if property.relationship.type == 'toOne':
            lines += generateSetPropertiesForToOneForCreate(entity, property, tabs)
        
    return lines

def generateCreateMethod(model):
    lines = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        lines.append('- (void)create{e}DTO:({e}DTO *){v}DTO with{e}:({e} *){v} inContext:(NSManagedObjectContext *)context'.format(e = entity, v = var))
        
        lines.append('{')
        
        lines += generateSetPropertiesForCreate(None, struct.entity, struct.properties, '\t')
        
        lines.append('}')
    
    return '\n'.join(lines)

def generateCreateDTOMethodsNames(model):
    methodsNames = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        methodsNames.append('- (void)create{e}DTO:({e}DTO *){v}DTO;'.format(e = entity, v = var))
    return methodsNames

def generateCreateDTOMethod(model):
    methods = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        tryBlock = []
        tryBlock.append('{e} *{v} = ({e} *)[NSEntityDescription insertNewObjectForEntityForName:@"{e}" inManagedObjectContext:context];'.format(e = entity, v = var))
        tryBlock.append('[self create{e}DTO:{v}DTO with{e}:{v} inContext:context];'.format(e = entity, v = var))
        tryBlock.append('[context save:nil];')
        
        exceptionBlock = ['NSLog(@"%@", e);']
        finallyBlock = []
        
        methodName = '- (void)create{e}DTO:({e}DTO *){v}DTO'.format(e = entity, v = var)
        
        methods.append(methodName + '\n' + methodTemplate([], tryBlock, exceptionBlock, finallyBlock, []))
    return '\n'.join(methods)
