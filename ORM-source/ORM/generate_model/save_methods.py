from generate_model.templates import methodTemplate
from helpers import upperCaseForFirstSymbol

def generateSaveMethod(model):
    lines = []
    for struct in model.structs:
        classesDefs = struct.classesDefs()
        for d in classesDefs:
            DTOName = d.name
            entity = d.entity.name
            entityVar = d.entity.name.lower()
            lines.append('- (void)save{e}:({e} *){ev} with{n}DTO:({n}DTO *)dto withContext:(ModelContext *)ctx'.format(n = DTOName, e = entity, ev = entityVar))
            lines.append('{')
            for property in d.properties:
                subEntity = property.relationship.entity.name if property.relationship != None else None
                subEntityVar = 'sub' + subEntity.lower() if subEntity != None else None
                subDTO = DTOName + upperCaseForFirstSymbol(property.name) + 'DTO'
                propertyName = property.name
                PropertyName = upperCaseForFirstSymbol(property.name)
                if property.id != None and len(property.properties) == 0:
                    dd = struct.classDefById(property.id)
                    subDTO = dd.name + "DTO"
                if property.relationship == None:
                    lines.append('\t' + '{ev}.{pn} = dto.{pn};'.format(pn = propertyName, ev = entityVar))
                elif property.relationship != None and property.relationship.type == 'toMany':
                    collectionName = property.relationship.entity.name.lower() + 'List'
                    lines.append('\t' + '{')
                    lines.append('\t\t' + 'NSMutableSet *{cn}New = [NSMutableSet set];'.format(cn = collectionName))
                    lines.append('\t\t' + 'NSMutableSet *{cn}Old = {ev}.{pn}.mutableCopy;'.format(cn = collectionName, ev = entityVar, pn = propertyName))
                    lines.append('\t\t' + 'for ({sd} *item in dto.{pn})'.format(sd = subDTO, pn = propertyName))
                    lines.append('\t\t' + '{')
                    lines.append('\t\t\t' + '{se} *{sev};'.format(se = subEntity, sev = subEntityVar))
                    lines.append('\t\t\t' + 'if ([ctx containsEntityObjectForDTO:item] == YES)')
                    lines.append('\t\t\t' + '{')
                    lines.append('\t\t\t\t' + '{sev} = ({se} *)[ctx entityObjectForDTO:item];'.format(se = subEntity, sev = subEntityVar))
                    lines.append('\t\t\t' + '}')
                    lines.append('\t\t\t' + 'else')
                    lines.append('\t\t\t' + '{')
                    lines.append('\t\t\t\t' + 'if (item.objectID == nil)')
                    lines.append('\t\t\t\t' + '{')
                    lines.append('\t\t\t\t\t' + '{sev} = ({se} *)[NSEntityDescription insertNewObjectForEntityForName:@"{se}" inManagedObjectContext:{ev}.managedObjectContext];'.format(se = subEntity, sev = subEntityVar, ev = entityVar))
                    lines.append('\t\t\t\t' + '}')
                    lines.append('\t\t\t\t' + 'else')
                    lines.append('\t\t\t\t' + '{')
                    lines.append('\t\t\t\t\t' + '{sev} = ({se} *)[{ev}.managedObjectContext objectWithID:item.objectID];'.format(sev = subEntityVar, se = subEntity, ev = entityVar))
                    lines.append('\t\t\t\t' + '}')
                    lines.append('\t\t\t\t' + '[ctx addEntityObject:{sev} forDTO:item];'.format(sev = subEntityVar))
                    lines.append('\t\t\t\t' + '[self save{se}:{sev} with{sd}:item withContext:ctx];'.format(se = subEntity, sev = subEntityVar, sd = subDTO))
                    lines.append('\t\t\t' + '}')
                    lines.append('\t\t\t' + '[{cn}New addObject:{sev}];'.format(cn = collectionName, sev = subEntityVar))
                    lines.append('\t\t' + '}')
                    lines.append('\t\t' + '{ev}.{pn} = {cn}New.copy;'.format(cn = collectionName, ev = entityVar, pn = propertyName))
                    lines.append('\t' + '}')
                elif property.relationship != None and property.relationship.type == 'toOne':
                    lines.append('\t' + '{')
                    lines.append('\t\t' + '{se} *{sev};'.format(se = subEntity, sev = subEntityVar))
                    lines.append('\t\t' + 'if ([ctx containsEntityObjectForDTO:dto.{pn}] == YES)'.format(pn = propertyName))
                    lines.append('\t\t' + '{')
                    lines.append('\t\t\t' + '{sev} = ({se} *)[ctx entityObjectForDTO:item];'.format(se = subEntity, sev = subEntityVar))
                    lines.append('\t\t' + '}')
                    lines.append('\t\t' + 'else')
                    lines.append('\t\t' + '{')
                    lines.append('\t\t\t' + 'if (dto.{pn}.objectID == nil)'.format(pn = propertyName))
                    lines.append('\t\t\t' + '{')
                    lines.append('\t\t\t\t' + '{sev} = ({se} *)[NSEntityDescription insertNewObjectForEntityForName:@"{se}" inManagedObjectContext:context];'.format(se = subEntity, sev = subEntityVar))
                    lines.append('\t\t\t' + '}')
                    lines.append('\t\t\t' + 'else')
                    lines.append('\t\t\t' + '{')
                    lines.append('\t\t\t\t' + '{sev} = ({se} *)[{ev}.managedObjectContext objectWithID:item.objectID];'.format(sev = subEntityVar, se = subEntity, ev = entityVar))
                    lines.append('\t\t\t' + '}')
                    lines.append('\t\t\t' + '[ctx addEntityObject:{sev} forDTO:dto.{pn}];'.format(sev = subEntityVar, pn = propertyName))
                    lines.append('\t\t\t' + '[self save{se}:{sev} with{sd}:dto.{pn} withContext:ctx];'.format(se = subEntity, sev = subEntityVar, sd = subDTO, pn = propertyName))
                    lines.append('\t\t' + '}')
                    lines.append('\t\t' + '{e}.{pn} = {sev};'.format(e = entityVar, pn = propertyName, sev = subEntityVar))
                    lines.append('\t' + '}')
            lines.append('}')
    return '\n'.join(lines)

def generateSaveDTOMethodsNames(model):
    methodsNames = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        methodsNames.append('- (void)save{mn}{e}DTO:({mn}{e}DTO *){v}DTO;'.format(e = entity, v = var, mn = model.name))
    return methodsNames

def generateSaveDTOMethod(model):
    methods = []
    for struct in model.structs:
        entity = struct.entity.name
        var = struct.entity.name.lower()
        
        tryBlock = []
        tryBlock.append('{e} *{v};'.format(e = entity, v = var))
        tryBlock.append('if ({v}DTO.objectID != nil)'.format(v = var))
        tryBlock.append('{')
        tryBlock.append('\t{v} = ({e} *)[context objectWithID:{v}DTO.objectID];'.format(e = entity, v = var))
        tryBlock.append('}')
        tryBlock.append('else')
        tryBlock.append('{')
        tryBlock.append('\t{v} = ({e} *)[NSEntityDescription insertNewObjectForEntityForName:@"{e}" inManagedObjectContext:context];'.format(e = entity, v = var))
        tryBlock.append('}')
        tryBlock.append('ModelContext *ctx = [ModelContext new];')
        tryBlock.append('[ctx addEntityObject:{v} forDTO:{v}DTO];'.format(v = var));
        tryBlock.append('[self save{e}:{v} with{n}DTO:{v}DTO withContext:ctx];'.format(e = entity, v = var, n = model.name + entity))
        tryBlock.append('[context save:nil];')
        
        exceptionBlock = ['NSLog(@"%@", e);']
        finallyBlock = []
        
        methodName = '- (void)save{mn}{e}DTO:({mn}{e}DTO *){v}DTO'.format(e = entity, v = var, mn = model.name)
        
        methods.append(methodName + '\n' + methodTemplate([], tryBlock, exceptionBlock, finallyBlock, []))
    return '\n'.join(methods)

