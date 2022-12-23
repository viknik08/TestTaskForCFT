//
//  CoreDataManager.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 23.12.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
//   MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TestTaskForCFT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

//   MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    MARK: - CRUD
    
    func fetchTask() -> [TaskEntity] {
        var tasks: [TaskEntity] = []
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return tasks
    }
    
    func saveTask(_ text: String) {
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context) else { return }
        let taskObject = TaskEntity(entity: entity, insertInto: context)
        taskObject.title = text
        taskObject.id = UUID().uuidString
        saveContext()
    }
    
    func deleteTask(task: TaskEntity) {
        persistentContainer.viewContext.delete(task)
        saveContext()
        
    }
    
    func updataTask(id: String, title: String, discrip: String?, image: Date?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        if let tasks = try? persistentContainer.viewContext.fetch(fetchRequest) as? [TaskEntity], !tasks.isEmpty {
            guard let requiredTask = tasks.first else { return }
            requiredTask.setValue(title, forKey: "title")
            requiredTask.setValue(discrip, forKey: "discrip")
            requiredTask.setValue(image, forKey: "image")
            try? persistentContainer.viewContext.save()
        }
    }
}
