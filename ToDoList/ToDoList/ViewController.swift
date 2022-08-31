//
//  ViewController.swift
//  ToDoList
//
//  Created by Farah Alyousef on 02/02/1444 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    

    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list item!", preferredStyle: .alert)
        alert.addTextField{ field in field.placeholder = "Enter Item..."
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {[weak self](_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                    var currentItem = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItem.append(text)
                        UserDefaults.standard.setValue(currentItem, forKey: "items")
                    self?.items.append(text)
                    self?.table.reloadData()
                }
            }
            }
        }))
        present(alert, animated: true)
    }
override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    table.frame = view.bounds
}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
            
        
        
        return cell
        }
    func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            tableView.beginUpdates()
//            items.remove(at:[indexPath], with: .fade)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
    }

}
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        items.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    }

    


