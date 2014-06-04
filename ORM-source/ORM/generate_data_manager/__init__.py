import os

def create_data_manager(entities, path):
    
    currDir = os.path.dirname(__file__)
    
    filePath = os.path.join(currDir, '../templates/DataManager.h.template')
    
    file = open(filePath, 'r')
    dataManagetHeaderFile = file.read()
    file.close()
    
    file = open(os.path.join(path, 'DataManager.h'), 'w+')
    file.write(dataManagetHeaderFile)
    file.close()
    
    entityPairs = []
    for entity in entities:
        properties = []
        for relationship in entity.relationships:
            relationshipFormat = '\t\t\t\t@{{@"property" : @"relationship", @"name" : @"{name}", @"inverse" : @"{inverse}", @"entity" : @"{entity}", @"type" : @"{type}"}},'
            properties.append(relationshipFormat.format(name = relationship.name, inverse = relationship.inverse, entity = relationship.entity.name, type = relationship.type))
        for field in entity.fields:
            fieldsFormat = '\t\t\t\t@{{@"property" : @"field", @"name" : @"{name}", @"type" : @"{type}"}},'
            properties.append(fieldsFormat.format(name = field.name, type = field.type))
        entityPairFormat = '@"{entityName}" : @[\n{properties}\n\t\t\t],'
        entityPairs.append(entityPairFormat.format(entityName = entity.name, properties = '\n'.join(properties)))
    
    filePath = os.path.join(currDir, '../templates/DataManager.m.template')
    file = open(filePath, 'r')
    dataManagetSourceFile = file.read().replace('__DICTENTITY__', '\n\t\t\t'.join(entityPairs))
    file.close()
    
    file = open(os.path.join(path, 'DataManager.m'), 'w+')
    file.write(dataManagetSourceFile)
    file.close()

