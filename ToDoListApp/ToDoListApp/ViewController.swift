//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Raneem Alkahtani on 26/08/2022.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter
}()

class ViewController: UIViewController {
    
  
    @IBOutlet weak var indicationDate: UIImageView!
    
    @IBOutlet weak var ToDoTabelView: UITableView!
    
    
    @IBOutlet weak var AddButtom: UIBarButtonItem!
 
    var toDoItems:[ToDoItem] = []
    //[ToDoItem(name:"Gorecery Shopping " , dateCreated:Date(), DueDate: Date(), notes: " Salt , Egg, Sugar", isCompleted : false) ,ToDoItem(name:"Gorecery Shopping " , dateCreated:Date(), DueDate: Date(), notes: " Salt , Egg, Sugar", isCompleted : false)]
    var datestring:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTabelView.delegate = self
        ToDoTabelView.dataSource = self
        loadData()
//        print(Date.now)     //   datestring = before("\(self.toDoItems[1].DueDate)")!
//  print(datestring)
    }
    
    func loadData(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL)else{return}
                let jsonDecoder = JSONDecoder()
        do{
            toDoItems = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
            ToDoTabelView.reloadData()
        }catch{
            print("error \(error.localizedDescription)")

        }
    }
    
    func saveData(){
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(toDoItems)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        }catch {
            print("error \(error.localizedDescription)")
        }
        
        
    }
    
    func checkDaueDate(){
      //  if toDoItem.DueDate == Date.now
            print(true)
    }
    
//    func before(_ string: String, date: Date = Date()) -> Bool? {
//        let locale = Locale(identifier: "en_US_POSIX")
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = locale
//        dateFormatter.dateFormat = "MMM dd, yyyy"
//
//        guard let inDate = dateFormatter.date(from: string) else {
//            return nil
//        }
//        var calendar = Calendar.current
//        calendar.locale = locale
//        return inDate < calendar.startOfDay(for: date)
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let destination = segue.destination as! ToDoTableViewController
            let selectedIndexPath = ToDoTabelView.indexPathForSelectedRow!
            destination.toDoItem = toDoItems[selectedIndexPath.row]
        }else{
            if let selectedIndexPath = ToDoTabelView.indexPathForSelectedRow{
                ToDoTabelView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue){
        let source = segue.source as! ToDoTableViewController
      if let selectedIndexPath = ToDoTabelView.indexPathForSelectedRow {
          toDoItems[selectedIndexPath.row] = source.toDoItem
            ToDoTabelView.reloadRows(at: [selectedIndexPath], with: .automatic)
      } else{
          let newIndexPath = IndexPath(row: toDoItems.count, section: 0)
          toDoItems.append(source.toDoItem)
          ToDoTabelView.insertRows(at: [newIndexPath], with: .bottom)
          ToDoTabelView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
      }
        saveData()
    }
    
   
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        if ToDoTabelView.isEditing{
            ToDoTabelView.setEditing(false, animated: true)
            sender.title = "Edit"
            AddButtom.isEnabled = true
        }else{
            ToDoTabelView.setEditing(true, animated: true)
            sender.title = "Done"
            AddButtom.isEnabled = false
        }
    }
    
    
}

extension ViewController:UITableViewDelegate , UITableViewDataSource , ListTabelViewCellDelegate{
    func checkBoxToggle(sender: listTableViewCell) {
        if let selectedIndexPath = ToDoTabelView.indexPath(for: sender){
            toDoItems[selectedIndexPath.row].isCompleted = !toDoItems[selectedIndexPath.row].isCompleted
            ToDoTabelView.reloadRows(at: [selectedIndexPath], with: .automatic)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! listTableViewCell
        cell.delegate = self
        cell.cellItemLabel.text = toDoItems[indexPath.row].name
        let dateshortformat = toDoItems[indexPath.row].DueDate
 let datshort =  dateFormatter.string(from: dateshortformat)
        cell.cellDatelabel.text = "Due Date: \(datshort)"
    
     //   for _ in 0..<toDoItems.count {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateWithTime = Date()
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateStyle = .short
            let currentDay = dateFormatter2.string(from: dateWithTime)
            
        if datshort.compare(currentDay) == .orderedAscending && !toDoItems[indexPath.row].isCompleted {
                cell.indication.isHidden = false
                
            }else{
            cell.indication.isHidden = true
            }
            print(toDoItems[indexPath.row])
            
//            if datshort <= currentDay && !toDoItems[indexPath.row].isCompleted {
//                cell.indication.isHidden = false
//            }else{
//                cell.indication.isHidden = true
//            }
//            print(datshort , currentDay)
         // }
//            if "\(toDoItems[indexPath.row].DueDate)" > currentDay {
//        cell.indication!.isHidden = false
//         //  cell.indicationDate!.image = !nil
//        }else{
//          cell.indication!.isHidden = true
//        }
        cell.checkBoxButton.isSelected = toDoItems[indexPath.row].isCompleted
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
    if editingStyle == .delete{
        toDoItems.remove(at: indexPath.row)
        ToDoTabelView.deleteRows(at: [indexPath], with: .fade)
        saveData()
    }
}
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoItems[sourceIndexPath.row]
        toDoItems.remove(at: sourceIndexPath.row)
        toDoItems.insert(itemToMove, at: destinationIndexPath.row)
        saveData()
        
    }
    }
