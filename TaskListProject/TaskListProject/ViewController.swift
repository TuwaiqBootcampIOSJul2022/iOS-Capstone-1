//
//  ViewController.swift
//  TaskListProject
//
//  Created by Anaal Albeeshi on 02/02/1444 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var tasks = [String]()
    
    // Pull to Refresh Feature
    let refreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ----------titie == didTapAdd button--------------
        self.title = "Tasks"
        self.tasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
        tableView.dataSource = self
        tableView.delegate = self
        
        // Pull to Refresh Feature
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(getData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        
        // Setup
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // Get all current saved tasks
        updateTasks()
        
    }
    
    // Pull to Refresh Feature
    
    @objc func  getData(){
        //tasks.append("value \(tasks.count)")
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    
    // update
    func updateTasks(){
//        tasks.removeAll()
         
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            print("kkkkkkk")
            return
            // print("kkkkkkk")
        }
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        viewDidAppear(animated)
//        updateTasks()
//    }
    


    
    @IBAction func didTapAdd(_ sender: Any) {
        
        // اضافة التنبيه
        let alert = UIAlertController(title: "New Task", message: "Enter new to do list tasks!", preferredStyle: .alert)
        alert.addTextField{
            field in field.placeholder = "Enter task...."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler:{ [weak self](_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty{
                    print(text)
                    DispatchQueue.main.async {
                        var currentItems = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
                        currentItems.append(text)
                        // let newEntry = [text]
                        UserDefaults.standard.setValue(currentItems, forKey: "tasks")
                    self?.tasks.append(text)
                    }
                }
            }
        }))
       present(alert, animated: true)
//
//
//        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController_3
//        vc.title = "New Task"
//        vc.update = {
//            DispatchQueue.main.async {
//            self.updateTasks()
//            }
//        }
//        navigationController?.pushViewController(vc, animated: true)
    }
} // end class

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // delet
        let vc = storyboard?.instantiateViewController(identifier: "task") as! ViewController_2
        vc.title = "Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    // Rearrange items inside TableView
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // When you change the order of an element in the video table, it will change the order in the array
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tasks.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    // Swipe from the right
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletAction = UIContextualAction(style: .destructive, title: "حذف"){
           (action, view, CompletioHandler) in
            self.tasks.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            CompletioHandler(true)
        }
        let favoriteAction = UIContextualAction(style: .normal, title: ""){
            (_,_,_) in
            print(" user added to favorite")
        }
        
        deletAction.image = UIImage(systemName: "trash")
        favoriteAction.image = UIImage(systemName: "heart")
        favoriteAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [deletAction, favoriteAction])
    }
    
    
    // تعديل ارتفاع cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Pull to Refresh Feature
    
    
//    @objc
//    func addToFavorite(sender: UIButton){
//        print("button index = \(sender.tag)")
//        //  وضع البوتين بعد الضغط عليه ولكن اسم الصورة الموجودة ع البوتيبن مختلف
//        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//    }
    
    
    
}// end extension

