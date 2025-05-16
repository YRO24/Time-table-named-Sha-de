//
//  TodoListViewController.swift
//  shade
//
//  Created by Yashraj Parag Ola on 13/05/25.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dayAndTime: String?
    var todoItems: [String] = []
    @IBOutlet weak var todoTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupTableView()
        setupNavigationBar()

        if let dayAndTime = dayAndTime {
            print("Selected Day and Time in TodoListVC: \(dayAndTime)")
            loadTodoItems(for: dayAndTime)
        }
    }

    func setupBackground() {
        // Set the background image
        if let image = UIImage(named: "daysbg.jpeg") {
            view.backgroundColor = UIColor(patternImage: image)
        } else {
            view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
            print("Error: Could not load background image!")
        }
    }

    func setupNavigationBar() {
        // Use a smaller, bold, and white font for the title
        let titleLabel = UILabel()
        titleLabel.text = dayAndTime
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodoItem))
    }

    func setupTableView() {
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        todoTableView.backgroundColor = .clear
        todoTableView.separatorStyle = .none
    }

    // MARK: - Data Persistence (Using UserDefaults)
    var allTodos: [String: [String]] = [:]
    var completedItems: [IndexPath: Bool] = [:]

    func loadTodoItems(for key: String) {
        if let savedTodos = UserDefaults.standard.dictionary(forKey: "allTodosData") as? [String: [String]] {
            allTodos = savedTodos
            todoItems = allTodos[key] ?? []
        } else {
            todoItems = []
            allTodos = [:]
        }

        if let savedCompleted = UserDefaults.standard.dictionary(forKey: "completedItemsData") as? [String: Bool] {
            completedItems = savedCompleted.reduce(into: [:]) { (result, element) in
                let keyString = element.key
                let components = keyString.components(separatedBy: ",")
                if components.count == 2,
                   let section = Int(components[0].trimmingCharacters(in: .whitespacesAndNewlines)),
                   let row = Int(components[1].trimmingCharacters(in: .whitespacesAndNewlines)) {
                    let indexPath = IndexPath(row: row, section: section)
                    result[indexPath] = element.value
                }
            }
        } else {
            completedItems = [:]
        }
        todoTableView.reloadData()
    }

    func saveTodoItem(_ item: String, for key: String) {
        print("saveTodoItem called with item: \(item), key: \(key)")
        if var existingItems = allTodos[key] {
            existingItems.append(item)
            allTodos[key] = existingItems
        } else {
            allTodos[key] = [item]
        }
        todoItems = allTodos[key] ?? []
        UserDefaults.standard.set(allTodos, forKey: "allTodosData")

        let completedDict = completedItems.reduce(into: [String: Bool]()) { (result, element) in
            let keyString = "\(element.key.section),\(element.key.row)"
            result[keyString] = element.value
        }
        UserDefaults.standard.set(completedDict, forKey: "completedItemsData")
    }

    @objc func addTodoItem() {
        let alertController = UIAlertController(title: "Add New Task", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter task description"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first,
               let newItem = textField.text,
               !newItem.isEmpty,
               let currentKey = self?.dayAndTime {
                self?.saveTodoItem(newItem, for: currentKey)
                print("Item saved: \(newItem) for key: \(currentKey ?? "nil")")
                print("Current allTodos dictionary: \(self?.allTodos ?? [:])")
                print("Current todoItems array: \(self?.todoItems ?? [])")
                self?.todoTableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        print("Presenting Alert Controller")
        present(alertController, animated: true)
    }

    // MARK: - Table View Delegate and Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Creating cell for row: \(indexPath.row), todoItems count: \(todoItems.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)

        let item = todoItems[indexPath.row]
        let isCompleted = completedItems[indexPath] == true

        // Apply strikethrough if completed
        if isCompleted {
            let attributedString = NSAttributedString(
                string: item,
                attributes: [
                    NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
                    NSAttributedString.Key.foregroundColor: UIColor.gray //keep color
                ]
            )
            cell.textLabel?.attributedText = attributedString
        } else {
            cell.textLabel?.text = item
            cell.textLabel?.textColor = .white // Ensure text is white
        }

        cell.backgroundColor = .clear // Make cell background clear
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none

        // Add a delete button to the cell
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .red
        deleteButton.frame = CGRect(x: cell.contentView.bounds.width - 40, y: (cell.contentView.bounds.height - 30) / 2, width: 30, height: 30)
        deleteButton.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin]
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:event:)), for: .touchUpInside)
        cell.contentView.addSubview(deleteButton)

        // Adjust the text label's frame.  Use the cell's contentView bounds.
        cell.textLabel?.frame = CGRect(x: cell.contentView.bounds.origin.x + 16,
                                     y: cell.contentView.bounds.origin.y,
                                     width: cell.contentView.bounds.width - 80,
                                     height: cell.contentView.bounds.height)

        return cell
    }

    @objc func deleteButtonTapped(_ sender: UIButton, event: UIEvent) {
        if let touch = event.touches(for: sender)?.first,
           let cell = touch.view?.superview?.superview as? UITableViewCell,
           let indexPath = todoTableView.indexPath(for: cell),
           let currentKey = dayAndTime {

            todoItems.remove(at: indexPath.row)
            allTodos[currentKey]?.remove(at: indexPath.row)
            if allTodos[currentKey]?.isEmpty == true {
                allTodos.removeValue(forKey: currentKey)
            }
            completedItems.removeValue(forKey: indexPath)

            UserDefaults.standard.set(allTodos, forKey: "allTodosData")
            let completedDict = completedItems.reduce(into: [String: Bool]()) { (result, element) in
                let keyString = "\(element.key.section),\(element.key.row)"
                result[keyString] = element.value
            }
            UserDefaults.standard.set(completedDict, forKey: "completedItemsData")

            todoTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completedItems[indexPath] = !(completedItems[indexPath] == true)
        
         let completedDict = completedItems.reduce(into: [String: Bool]()) { (result, element) in
            let keyString = "\(element.key.section),\(element.key.row)"
            result[keyString] = element.value
        }
        UserDefaults.standard.set(completedDict, forKey: "completedItemsData")

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
