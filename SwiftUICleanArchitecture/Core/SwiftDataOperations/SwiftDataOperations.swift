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
        case delete
    }
    
    let operationType: CRUDOperation
    
    init(operationType: CRUDOperation) {
        self.operationType = operationType
    }
    
    func performOperation() throws {
        switch operationType {
        case .create(let dataType, let context):
            print("CREATE ")
            try createOperation(for: dataType, context: context)
        case .read:
            readOperation()
        case .update(let dataType, let context):
            updateOperation(for: dataType, context: context)
        case .delete:
            deleteOperation()
        }
    }
    
    func createOperation(for dataType: T , context: ModelContext) throws {
        print("Performing create operation for type: \(dataType)")
        context.insert(dataType)
        do{
            try context.save()
        }
        catch {
            print("DEBUG: createOperation \(error)")
            throw error
        }
    }
    
    func readOperation() {
        print("Performing read operation")
        // Implementation of read operation
    }
    
    func updateOperation(for dataType: T, context: ModelContext) {
        print("Performing update operation")
        // Implementation of update operation
    }
    
    func deleteOperation() {
        print("Performing delete operation")
        // Implementation of delete operation
    }
}
