//
//  MainViewModel.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 23.12.2022.
//

import Foundation

protocol MainViewControllerProtocol: AnyObject {
    func updateTasks()
}

protocol MainViewModelProtocol {
    func saveTask(text: String?)
    func fetchTask()
    func deleteTask(index: IndexPath)
    var tasks: [TaskEntity]? { get set }
    var delegat: MainViewControllerProtocol? { get set }
}

class MainViewModel: MainViewModelProtocol {

    var tasks: [TaskEntity]? 
    
    weak var delegat: MainViewControllerProtocol?
    
    func saveTask(text: String?) {
        guard let text = text else { return }
        CoreDataManager.shared.saveTask(text)
        fetchTask()
    }
    
    func fetchTask() {
        tasks = CoreDataManager.shared.fetchTask()
        delegat?.updateTasks()
    }
    
    func deleteTask(index: IndexPath) {
        guard let task = tasks?[index.row] else { return }
        CoreDataManager.shared.deleteTask(task: task)
        tasks?.remove(at: index.row)
    }
}
