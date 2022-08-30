
import UIKit
import ALProgressView

struct TaskStruct: Codable{
    var title: String
    var description: String
    let date: Date
    var isComplete: Bool
}

var taskList = [TaskStruct]()

class ViewController: UIViewController{
    
    private lazy var progressRing = ALProgressRing()

    @IBOutlet weak var progressNumber: UILabel!
    @IBOutlet weak var ToDoList: UICollectionView!
    
    var titleTask: UITextField?
    var descriptionTask: UITextField?

    var taskTitle: String?
    var taskDescription: String?
    var taskDate: Date?
    var isComplete: Bool?
    var taskListCount: Double?
    var isCompleteCount: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToDoList.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        if let myTasks = UserDefaults.standard.value(forKey: "Task") as? Data{
            taskList = try! PropertyListDecoder().decode(Array<TaskStruct>.self, from: myTasks)
        }
        
        progressRingDraw()
        ToDoList.delegate = self
        ToDoList.dataSource = self
        ToDoList.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(taskList), forKey: "Task")
        ToDoList.reloadData()
    }
    
    // --progressRing--
    func progressRingDraw(){
        view.addSubview(progressRing)
        view.addSubview(progressRing)
      
        // MARK: ALProgressRing
        // Setup layout
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        progressRing.centerXAnchor.constraint(equalTo: progressNumber.centerXAnchor).isActive = true
        progressRing.centerYAnchor.constraint(equalTo: progressNumber.centerYAnchor).isActive = true
        // Make sure to set the view size
        progressRing.widthAnchor.constraint(equalToConstant: 180).isActive = true
        progressRing.heightAnchor.constraint(equalToConstant: 180).isActive = true
        // Set track color
        // If you don't need a gradient, just set the same values for `startColor` and `endColor`
        progressRing.startColor = #colorLiteral(red: 1, green: 0.8746308684, blue: 0.7190521359, alpha: 1)
        progressRing.endColor = #colorLiteral(red: 0.9176144004, green: 0.6138867736, blue: 0.2074314356, alpha: 1)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailTask"{
            if let viewVC = segue.destination as? DetailTaskVC{
                viewVC.titleTaskVc = taskTitle
                viewVC.descriptionTaskVC = taskDescription
                viewVC.dateTaskVc = taskDate
            }
            
        }
    }
}

// --UICollectionViewDataSource--
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isCompleteCount = 0
        progressNumber.text = "0%"
        progressRing.setProgress(0.0, animated: true)
        return taskList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let currentTask = taskList[indexPath.row]
        cell.index = indexPath
        cell.delegate = self
        
        cell.titleLabel.text = currentTask.title

        let date = currentTask.date
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        cell.dayLabel.text = formatter.string(from: date)
        formatter.dateFormat = "dd"
        cell.dayNumberLabel.text = formatter.string(from: date)
        formatter.dateFormat = "MMM"
        cell.monthLabel.text = formatter.string(from: date)
        
        let now = Date.now
        
        cell.contentView.layer.cornerRadius = 20.0;
        
        calculteProgress(indx: indexPath.row)
        
        if taskList[indexPath.row].isComplete == true{
            cell.checkbox.checkState = .checked
            cell.checkbox.tintColor = .green
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9612619281, green: 0.7090802789, blue: 0.4539489746, alpha: 1)
        }else if now > date{
            cell.checkbox.checkState = .mixed
            cell.checkbox.tintColor = .red
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9948660731, green: 0.9459620118, blue: 0.8891398907, alpha: 1)
        }else{
            cell.checkbox.checkState = .unchecked
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.8746308684, blue: 0.7190521359, alpha: 1)
        }
        
        return cell
    }
    
    func calculteProgress(indx: Int){
        var Percentage = 0
        
        if taskList[indx].isComplete == true{
            isCompleteCount += 1
            taskListCount = Double(taskList.count)
            Percentage = Int((isCompleteCount/taskListCount!)*100)
            if Percentage <= 100{
            progressRing.setProgress(Float(isCompleteCount/taskListCount!), animated: true)
            progressNumber.text = "\(Percentage)%"
            }
    }
}
}
extension ViewController: DataCollectionProtocol {
    func actionData(index: Int) {
        
        taskTitle = taskList[index].title
        taskDescription = taskList[index].description
        taskDate = taskList[index].date
        
        let alert = UIAlertController(
            title: "Option",
            message: nil,
            preferredStyle: .actionSheet
        )
        // -EDIT ACTION-
        alert.addAction(
            .init(title: "Edit", style: .default) { _ in
                
                     let selectedTitleTask = taskList[index].title
                     let selectedDescriptionTask = taskList[index].description
                     let dialogMessage = UIAlertController(title: "Edit", message: "Edit Task ✏️", preferredStyle: .alert)
                     
                     let Update = UIAlertAction(title: "Update", style: .default){ (action) in
                         let editTitleTask = self.titleTask?.text!
                         let editDescriptionTask = self.descriptionTask?.text
                         taskList[index].title = editTitleTask!
                         taskList[index].description = editDescriptionTask!
                         
                         UserDefaults.standard.set(try? PropertyListEncoder().encode(taskList), forKey: "Task")
                             self.ToDoList.reloadData()
                         
                     }
                     let cancel = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
                     }
                     
                     dialogMessage.addAction(Update)
                     dialogMessage.addAction(cancel)
                     dialogMessage.addTextField{(textfield) in
                         self.titleTask = textfield
                         self.titleTask?.placeholder = "Edit Title Task Here"
                         self.titleTask?.text = selectedTitleTask
                     }
                     dialogMessage.addTextField{(textfield) in
                         self.descriptionTask = textfield
                         self.descriptionTask?.placeholder = "Edit Description Task Here"
                         self.descriptionTask?.text = selectedDescriptionTask
                     }
                     self.present(dialogMessage, animated: true, completion: nil)

            }
        )
        // -Detail ACTION-
        alert.addAction(.init(title: "Detail", style: .default) { _ in
            self.performSegue(withIdentifier: "DetailTask", sender: nil)
            }
        )

        // -Delete ACTION-
        alert.addAction(.init(title: "Delete", style: .destructive) { _ in
                taskList.remove(at: index)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(taskList), forKey: "Task")
                self.ToDoList.reloadData()
                   
            }
        )
        
        present(alert, animated: true)
    }
}

// --UICollectionViewDelegate--
extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            taskList[indexPath.row].isComplete.toggle()
        
        
        ToDoList.reloadData()
}
}
