//
//  ToDo.swift
//  capstoneFinal1
//
//  Created by AlenaziHazal on 01/02/1444 AH.
//

import Foundation
import UIKit

struct ToDo : Equatable{
    let id = UUID()
    var title:String
    var isComplete:Bool
    var duwDate:Date
    var notes:String
    
    static func == (lhs: ToDo, rhs: ToDo)-> Bool{
        return lhs.id == rhs.id
    }
    static func loadToDos()->[ToDo]?{
//        guard let codeToDos = try? Data(contentsOf: archiveURL) else {
//            return nil}
//        let propertyListDecoder = PropertyListDecoder()
//        try?
//        propertyListDecoder.decode(Array<ToDo>.self, from: codeToDos)
        return nil
    }
    static func loadSampleToDos()-> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One", isComplete: false, duwDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "To-Do Two", isComplete: false, duwDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "To-Do Three", isComplete: false, duwDate: Date(), notes: "Notes 3")
        return [toDo1,toDo2,toDo3]
    }
    static func saveToDo(_ toDos:[ToDo]){
        let propertyListEncoder = PropertyListEncoder()
//        let codedToDos = try? propertyListEncoder.encode(toDos)
//        try? codedToDos.write(to:archiveURL, Optional: .noFileProtection)
    }
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathComponent("plist")
}
