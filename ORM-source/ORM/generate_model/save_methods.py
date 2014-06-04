from generate_model.templates import methodTemplate

def generateSetPropertiesForToManyForSave(entity, property, tabs):
    
    lines = []
    
    lines.append('')
    
    var = entity.name.lower()
    subentity = property.relationship.entity.name
    subvar = property.relationship.entity.name.lower()
    collectionName = subvar + 'List'
    
    lines.append(tabs + 'NSMutableSet *{cn}New = [NSMutableSet set];'.format(cn = collectionName))
    lines.append(tabs + 'NSMutableSet *{cn}Old = {v}.{pn}.mutableCopy;'.format(cn = collectionName, v = var, pn = property.name))
    
    #forneach begin
    lines.append(tabs + 'for ({se}DTO *{sv}DTO in {v}DTO.{pn})'.format(se = subentity, sv = subvar, v = var, pn = property.name))
    lines.append(tabs + '{')
    
    #generate follow source code
    #   if (dto.objectID == nil)
    #   {
    #       entityVar = (EntityClass *)[NSEntityDescription insertNewObjectForEntityForName:@"EntityName" inManagedObjectContext:context];
    #   }
    #   else
    #   {
    #       entityVar = (EntityClass *)[context objectWithID:dto.objectID];
    #       [collectionOld removeObject:entityVar];
    #   }
    #   [collectionNew addObject:entityVar];
    subtabs = tabs + '\t'
    lines.append(subtabs + '{se} *{sv} = nil;'.format(se = subentity, sv = subvar))
    lines.append(subtabs + 'if ({sv}DTO.objectID == nil)'.format(sv = subvar))
    lines.append(subtabs + '{')
    lines.append(subtabs + '\t' + '{sv} = ({se} *)[NSEntityDescription insertNewObjectForEntityForName:@"{se}" inManagedObjectContext:context];'.format(sv = subvar, se = subentity));
    lines.append(subtabs + '}')
    lines.append(subtabs + 'else')
    lines.append(subtabs + '{')
    lines.append(subtabs + '\t' + '{sv} = ({se} *)[context objectWithID:{sv}DTO.objectID];'.format(sv = subvar, se = subentity))
    lines.append(subtabs + '\t' + '[{cn}Old removeObject:{sv}];'.format(cn = collectionName, sv = subvar))
    lines.append(subtabs + '}');
    lines.append(subtabs + '[{cn}New addObject:{sv}];'.format(cn = collectionName, sv = subvar))
    
    #generate set sub-properties
    subpropertiesList = generateSetPropertiesForSave(entity, property.relationship.entity, property.properties, tabs + '\t')
    lines += subpropertiesList #join two arrays
    
    lines.append(tabs + '}')
    #foreach end
    
    lines.append(tabs + '{v}.{pn} = {cn}New;'.format(cn = collectionName, v = var, pn = property.name))
    
    #remove old objects
    #foreach begin
    lines.append(tabs + 'for ({se} *{sv} in {cn}Old)'.format(se = subentity, sv = subvar, cn = collectionName))
    lines.append(tabs + '{')
    lines.append(tabs + '\t' + '[context deleteObject:{sv}];'.format(sv = subvar))
    lines.append(tabs + '}')
    #foreach end
    
    return lines

def generateSetPropertiesForToOneForSave(entity, property, tabs):
    lines = []
    var = entity.name.lower()
    subentity = property.relationship.entity.name
    subvar = property.relationship.entity.name.lower()
    lines.append(tabs + '')
    lines.append(tabs + 'if ({v}DTO.{pn} == nil)'.format(v = var, pn = property.name))
    lines.append(tabs + '{')
    lines.append(tabs + '\t' + '{v}.{pn} = nil;'.format(v = var, pn = property.name))
    lines.append(tabs + '}')
    lines.append(tabs + 'else')
    lines.append(tabs + '{')
    lines.append(tabs + '\t' + 'if ({v}.{pn} == nil)'.format(v = var, pn = property.name))
    lines.append(tabs + '\t' + '{')
    lines.append(tabs + '\t' + '\t' + '{v}.{pn} = ({se} *)[NSEntityDescription insertNewObjectForEntityForName:@"{se}" inManagedObjectContext:context];'.format(v = var, pn = property.name, se = subentity))
    lines.append(tabs + '\t' + '}')
    lines.append(tabs + '\t' + '{se} *{sv} = {v}.{pn};'.format(se = subentity, sv = subvar, v = var, pn = property.name))
    lines.append(tabs + '\t' + '{se}DTO *{sv}DTO = {v}DTO.{pn};'.format(se = subentity, sv = subvar, v = var, pn = property.name))
    lines += generateSetPropertiesForSave(entity, property.relationship.entity, property.properties, tabs + '\t')
    lines.append(tabs + '}')
    return lines

def generateSetPropertiesForSave(rootentity, entity, properties, tabs):
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
            lines += generateSetPropertiesForToManyForSave(entity, property, tabs)
        
        if property.relationship.type == 'toOne':
            lines += generateSetPropertiesForToOneForSave(entity, property, tabs)
        
    return lines

def generateSaveMethod(model):
    lines = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        lines.append('- (void)save{e}DTO:({e}DTO *){v}DTO with{e}:({e} *){v} inContext:(NSManagedObjectContext *)context'.format(e = entity, v = var))
        
        lines.append('{')
        
        lines += generateSetPropertiesForSave(None, struct.entity, struct.properties, '\t')
        
        lines.append('}')
    
    return '\n'.join(lines)

def generateSaveDTOMethodsNames(model):
    methodsNames = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        methodsNames.append('- (void)save{e}DTO:({e}DTO *){v}DTO;'.format(e = entity, v = var))
    return methodsNames

def generateSaveDTOMethod(model):
    methods = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
    
        tryBlock = []
        tryBlock.append('{e} *{v} = ({e} *)[context objectWithID:{v}DTO.objectID];'.format(e = entity, v = var))
        tryBlock.append('[self save{e}DTO:{v}DTO with{e}:{v} inContext:context];'.format(e = entity, v = var))
        tryBlock.append('[context save:nil];')
    
        exceptionBlock = ['NSLog(@"%@", e);']
        finallyBlock = []
    
        methodName = '- (void)save{e}DTO:({e}DTO *){v}DTO'.format(e = entity, v = var)
    
        methods.append(methodName + '\n' + methodTemplate([], tryBlock, exceptionBlock, finallyBlock, []))
    return '\n'.join(methods)

