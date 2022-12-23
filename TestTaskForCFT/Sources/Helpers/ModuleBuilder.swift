//
//  ModuleBuilder.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 23.12.2022.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func creatMainModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    static func creatMainModule() -> UIViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        return viewController
    }

}
