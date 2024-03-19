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
        case read
        case update(T, ModelContext)
        case delete(T, ModelContext)
    }
    
    let operationType: CRUDOperation
    
    init(operationType: CRUDOperation) {
        self.operationType = operationType
    }
    
    func performOperation() throws {
        switch operationType {
        case .create(let data, let context):
            try createOperation(for: data, context: context)
        case .read:
            readOperation()
        case .update(let data, let context):
            updateOperation(for: data, context: context)
        case .delete(let data, let context):
            try deleteOperation(for: data, context: context)
        }
    }
    
    func createOperation(for data: T , context: ModelContext) throws {
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
    
    func readOperation() {
        print("Performing read operation")
        // Implementation of read operation
    }
    
    func updateOperation(for data: T, context: ModelContext) {
        print("Performing update operation")
        // Implementation of update operation
    }
    
    func deleteOperation(for data: T, context: ModelContext) throws {
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
