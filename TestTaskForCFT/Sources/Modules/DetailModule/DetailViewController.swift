//
//  DetailViewController.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 25.12.2022.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
    
    var viewModel: DetailViewModelProtocol?
    var task: TaskEntity?
    var isActive = true
    
//    MARK: - Outlets
    private lazy var viewForImage: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "no-image")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 100
        return image
    }()
    
    private lazy var buttonForImage: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        field.delegate = self
        field.isEnabled = false
        field.setLeftIcon(UIImage(systemName: "pencil.and.outline")!.withTintColor(.black, renderingMode: .alwaysOriginal))
        return field
    }()
    
    private lazy var descriptionField: UITextField = {
        let field = UITextField()
        field.placeholder = "Description"
        field.delegate = self
        field.isEnabled = false
        field.setLeftIcon(UIImage(systemName: "pencil.and.outline")!.withTintColor(.black, renderingMode: .alwaysOriginal))
        return field
    }()
    
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel?.delegat = self
        viewModel?.loadInfo()

        setupHierarchy()
        setupLayout()
        setupNavigationBarItem(isActive)
        
    }
    
    init(viewModel: DetailViewModelProtocol?, task: TaskEntity?) {
        self.viewModel = viewModel
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup
    
    @objc func chooseImage() {
        let view = UIImagePickerController()
        view.sourceType = .photoLibrary
        view.allowsEditing = true
        view.delegate = self
        present(view, animated: true)
    }
    
    @objc func editingInfo() {
        
        if isActive {
            buttonForImage.isHidden = false
            titleField.isEnabled = true
            titleField.setBottomDev(.systemGray4)
            descriptionField.isEnabled = true
            descriptionField.setBottomDev(.systemGray4)
        } else {
            buttonForImage.isHidden = true
            titleField.isEnabled = false
            titleField.setBottomDev(.white)
            descriptionField.isEnabled = false
            descriptionField.setBottomDev(.white)
            viewModel?.updataInfo(id: task?.id ?? "",
                                  title: titleField.text ?? "",
                                  descrip: descriptionField.text ?? nil,
                                  image: imageAvatar.image?.pngData() ?? nil)
        }
        
        isActive.toggle()
        setupNavigationBarItem(isActive)

    }
    
    private func setupHierarchy() {
        view.addSubview(viewForImage)
        viewForImage.addSubview(imageAvatar)
        viewForImage.addSubview(buttonForImage)
        view.addSubview(titleField)
        view.addSubview(descriptionField)
    }
    
    private func setupLayout() {
        viewForImage.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.bounds.height / 3)
        }
        imageAvatar.snp.makeConstraints { make in
            make.center.equalTo(viewForImage)
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        buttonForImage.snp.makeConstraints { make in
            make.bottom.equalTo(viewForImage)
            make.right.equalTo(imageAvatar.snp.right)
        }
        titleField.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(40)
            make.top.equalTo(viewForImage.snp.bottom).offset(20)
        }
        descriptionField.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.height.equalTo(40)
            make.top.equalTo(titleField.snp.bottom).offset(20)
        }
    }
    
    private func setupNavigationBarItem(_ isActive: Bool) {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editingInfo))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editingInfo))

        if isActive {
            navigationItem.rightBarButtonItem = editButton
        } else {
            navigationItem.rightBarButtonItem = doneButton
        }
    }
    
}

//  MARK: - Extension

extension DetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.setBottomDev(.systemGray)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBottomDev(.systemCyan)
    }
}

extension DetailViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageAvatar.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func showTaskDetail() {
        titleField.text = task?.title ?? ""
        descriptionField.text = task?.descrip ?? ""
        if let image = task?.image {
            imageAvatar.image = UIImage(data: image)
        }
    }
}
