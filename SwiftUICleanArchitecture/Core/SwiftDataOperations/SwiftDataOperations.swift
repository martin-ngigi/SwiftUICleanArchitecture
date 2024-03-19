//
//  SwiftDataOperations.swift
//  SwiftUICleanArchitecture
//
//  Created by Martin Wainaina on 19/03/2024.
//

import Foundation
import SwiftData
import SwiftUI


struct SwiftDataOperations<T: PersistentModel> { // can remove ": PersistentModel" to remain with <T> which can be any data type
    
    enum CRUDOperation {
        case create(T, ModelContext) // Accept any data type using Any.Type
        case readList(FetchDescriptor<T>, ModelContext)
        case update(T, ModelContext)
        case delete(T, ModelContext)
    }
    
    let operationType: CRUDOperation
    
    init(operationType: CRUDOperation) {
        self.operationType = operationType
    }
    
    func performOperation() throws -> [T] { // add return statement i.e. "-> [T]" for the sake of .readList since it has a return statement
        switch operationType {
        case .create(let data, let context):
            try createOperation(data: data, context: context)
        case .readList(let fetchDescriptor, let context):
            return try readListOperation(fetchDescriptor: fetchDescriptor, context: context)
        case .update(let data, let context):
            updateOperation(data: data, context: context)
        case .delete(let data, let context):
            try deleteOperation(data: data, context: context)
        }
        
        return [] // Default return if no operation is performed
    }
    
    func createOperation(data: T , context: ModelContext) throws {
        print("DEBUG: Performing create operation for type: \(data)")
        context.insert(data)
        do{
            try context.save()
        }
        catch {
            print("DEBUG: createOperation failed with error \(error)")
            throw error
        }
    }
    
    func readListOperation(fetchDescriptor: FetchDescriptor<T>, context: ModelContext) throws -> [T] {
        print("DEBUG: Performing read operation")
        var dataLists : [T] = []
        do {
            dataLists = try context.fetch(fetchDescriptor)
        }
        catch {
            dataLists = []
            print("DEBUG: readListOperation failed with error \(error)")
            throw error
        }
        return dataLists
    }
    
    func updateOperation(data: T, context: ModelContext) {
        print("Performing update operation")
        // Implementation of update operation
    }
    
    func deleteOperation(data: T, context: ModelContext) throws {
        print("DEBUG: Performing delete operation")
        context.delete(data)
        do{
            try context.save()
        }
        catch {
            print("DEBUG: deleteOperation failed with error \(error)")
            throw error
        }
    }
}
