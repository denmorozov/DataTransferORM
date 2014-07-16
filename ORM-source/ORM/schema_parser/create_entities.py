import os

def createHeaderEntity(entity, directory):
    fileName = entity.name + '.h'
    file = open(os.path.join(directory, fileName), 'w+')
    file.write('#import <CoreData/CoreData.h>')
    file.write('\n')
    for r in entity.relationships:
        file.write('@class {en};'.format(en = r.entity.name))
        file.write('\n')
    file.write('\n')
    file.write('@interface {className} : NSManagedObject'.format(className = entity.name))
    file.write('\n')
    
    for field in entity.fields:
        type = None
        mutateAttr = None
        if field.type == 'string':
            type = 'NSString'
            mutateAttr = 'strong'
        if field.type == 'float':
            type = 'float'
            mutateAttr = 'assign'
        if field.type == 'boolean':
            type = 'BOOL'
            mutateAttr = 'assign'
        if field.type == 'date':
            type = 'NSDate'
            mutateAttr = 'strong'
        if field.type == 'double':
            type = 'double'
            mutateAttr = 'assign'
        if field.type == 'data':
            type = 'NSData'
            mutateAttr = 'strong'
        if field.type == 'integer32':
            type = 'int32_t'
            mutateAttr = 'assign'
        if field.type == 'integer64':
            type = 'int64_t'
            mutateAttr = 'assign'
        if type == None:
            print('Bad type "{t}"'.format(t = field.type))
        pointer = '*' if (mutateAttr == 'strong') else ''
        file.write('@property (nonatomic, {ma}) {t} {p}{n};'.format(ma = mutateAttr, t = type, p = pointer, n = field.name))
        file.write('\n')
    
    for r in entity.relationships:
        if r.type == 'toMany':
            file.write('@property (nonatomic, strong) NSSet *{name};'.format(name = r.name))
        if r.type == 'toOne':
            file.write('@property (nonatomic, strong) {e} *{n};'.format(e = r.entity.name, n = r.name))
        file.write('\n')
    
    file.write('@end')
    file.write('\n')
    file.close()

def createSourceFileEntity(entity, directory):
    fileName = entity.name + '.m'
    file = open(os.path.join(directory, fileName), 'w+')
    
    file.write('#import "{className}.h"'.format(className = entity.name))
    file.write('\n')
    file.write('\n')
    
    file.write('@implementation {className}'.format(className = entity.name))
    file.write('\n')
    
    for field in entity.fields:
        file.write('@dynamic {n};'.format(n = field.name))
        file.write('\n')
    
    for r in entity.relationships:
        file.write('@dynamic {n};'.format(n = r.name))
        file.write('\n')
    
    file.write('@end')
    file.write('\n')
    
    file.close()

def createEntities(entities, directory):
    if not os.path.exists(directory):
        os.makedirs(directory)
    for entity in entities:
        createHeaderEntity(entity, directory)
        createSourceFileEntity(entity, directory)