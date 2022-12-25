//
//  MainViewController.swift
//  TestTaskForCFT
//
//  Created by Виктор Басиев on 23.12.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    
//    MARK: - Outlets
    
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter you task"
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 10
        textField.font = .systemFont(ofSize: 17, weight: .bold)
        textField.setLeftIcon(UIImage(systemName: "pencil")!.withTintColor(.black, renderingMode: .alwaysOriginal))
        return textField
    }()
    
    private lazy var enterTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addTaskInTableView), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var taskTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return tableView
    }()
    
//    MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupHierarсhy()
        setupLayout()
        setupDelegat()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchTask()
    }
    
    init(viewModel: MainViewModelProtocol?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup
    
    private func setupHierarсhy() {
        view.addSubview(taskTextField)
        view.addSubview(enterTaskButton)
        view.addSubview(taskTableView)
    }
    
    private func setupLayout() {
        
        taskTextField.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        enterTaskButton.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-20)
            make.left.equalTo(view).offset(20)
            make.top.equalTo(taskTextField.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        taskTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(enterTaskButton.snp.bottom).offset(20)
        }
    }
    
    private func setupDelegat() {
        taskTableView.delegate = self
        taskTableView.dataSource = self
        viewModel?.delegat = self
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = .white
        title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    MARK: - Action
    
    @objc func addTaskInTableView() {
        if taskTextField.text != "" {
            viewModel?.saveTask(text: taskTextField.text)
            taskTextField.text = ""
        }
    }

}

//MARK: - Extension

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell
        cell?.task = viewModel?.tasks?[indexPath.row]
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskTableView.deselectRow(at: indexPath, animated: true)
        let task = viewModel?.tasks?[indexPath.row]
        let viewController = ModuleBuilder.creatDetailModule(task: task)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskTableView.beginUpdates()
            viewModel?.deleteTask(index: indexPath)
            taskTableView.deleteRows(at: [indexPath], with: .automatic)
            taskTableView.endUpdates()
        }
    }
    
}

extension MainViewController: MainViewControllerProtocol {
    func updateTasks() {
        taskTableView.reloadData()
    }
}

