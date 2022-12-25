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
                descripLable.text = task.descrip
                if let image = task.image {
                    imageAvatar.image = UIImage(data: image)
                }
            }
        }
    }
    
//    MARK: - Outlets
    private lazy var imageAvatar: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var descripLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .light)
        lable.numberOfLines = 1
        lable.textColor = .systemGray
        return lable
    }()
    
    private lazy var titleLable: UILabel = {
        let lable = UILabel()
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
        addSubview(imageAvatar)
        addSubview(titleLable)
        addSubview(descripLable)
    }
    
    private func setupLayout() {
        imageAvatar.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        titleLable.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(imageAvatar.snp.right).offset(20)
        }
        descripLable.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(titleLable.snp.right).offset(20)
            make.right.equalTo(self).offset(-40)
        }
    }
    
}
