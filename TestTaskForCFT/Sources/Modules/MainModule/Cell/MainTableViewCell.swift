//
//  MainTableViewCell.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 23.12.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifier = "MainTableViewCell"
    
    var task: TaskEntity? {
        didSet {
            if let task = task {
                titleLable.text = task.title
            }
        }
    }
    
//    MARK: - Outlets
    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Task"
        lable.font = .systemFont(ofSize: 20, weight: .bold)
        lable.textColor = .black
        return lable
    }()
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(titleLable)
    }
    
    private func setupLayout() {
        titleLable.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
    }
    
}
