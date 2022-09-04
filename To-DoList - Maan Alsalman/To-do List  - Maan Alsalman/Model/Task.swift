//
//  Task.swift
//  To-do List  - Maan Alsalman
//
//  Created by Maan Abdullah on 27/08/2022.
//

import Foundation

struct Task: Codable{
    // MARK: - Save the documents directory of the app in constant
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static  let archiveURL = documentsDirectory.appendingPathComponent("to-Do List").appendingPathExtension("plist")
    var title: String
    var notes: String?
    var isCompleted: Bool
    var dueDate: Date?
    
    
    static func loadTasksData() -> [Task]?{
        guard let data = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Task>.self, from: data)
    }
    
    static func saveTasksData(_ toDoList: [Task]){
       let propertyListEncoder = PropertyListEncoder()
       let ecnodedData = try? propertyListEncoder.encode(toDoList)
       try? ecnodedData?.write(to: archiveURL, options: .noFileProtection)
    }
}
