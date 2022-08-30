//
//  ToDo.swift
//  capstoneFinal1
//
//  Created by AlenaziHazal on 01/02/1444 AH.
//

import Foundation
import UIKit

struct ToDo : Equatable , Codable{
    let id : UUID
    var title:String
    var isComplete:Bool
    var duwDate:Date
    var notes:String
     
    
    init(title:String,isComplate:Bool,dueDate:Date,notes:String?){
        self.id = UUID()
        self.title = title
        self.isComplete = isComplate
        self.duwDate = dueDate
        self.notes = notes!
    }
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    
    
    static func == (lhs: ToDo, rhs: ToDo)-> Bool{
        return lhs.id == rhs.id
    }
    static func loadToDos()->[ToDo]?{
        guard let codeToDos = try? Data(contentsOf: archiveURL) else { return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try?
        propertyListDecoder.decode(Array<ToDo>.self, from: codeToDos)
            }
    static func loadSampleToDos()-> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One", isComplate: false, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "To-Do Two", isComplate: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "To-Do Three", isComplate: false, dueDate: Date(), notes: "Notes 3")
        let tdo4 = ToDo(title: "jn,n", isComplate: false, dueDate: Date(), notes: "khbh")
        return [toDo1,toDo2,toDo3,tdo4]
    }
    static func saveToDo(_ toDos: [ToDo]){
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
}
