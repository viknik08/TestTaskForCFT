//
//  DetailViewModel.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 25.12.2022.
//

import Foundation

protocol DetailViewControllerProtocol: AnyObject {
    func showTaskDetail()
}

protocol DetailViewModelProtocol {
    var delegat: DetailViewControllerProtocol? { get set }
    func loadInfo()
    func updataInfo(id: String, title: String, descrip: String?, image: Data?)
}

class DetailViewModel: DetailViewModelProtocol {
    
    weak var delegat: DetailViewControllerProtocol?
    
    func loadInfo() {
        delegat?.showTaskDetail()
    }
    
    func updataInfo(id: String, title: String, descrip: String?, image: Data?) {
        CoreDataManager.shared.updataTask(id: id, title: title, descrip: descrip, image: image)
    }
}

