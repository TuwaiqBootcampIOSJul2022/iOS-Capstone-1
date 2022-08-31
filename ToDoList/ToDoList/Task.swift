//
//  Task.swift
//  ToDoList
//
//  Created by NosaibahMW on 01/02/1444 AH.
//

import Foundation

struct Task: Codable {
    
    var title: String
    var description: String
    var isCompleted: Bool
    var dueDate: String
    var isPastDue: Bool
    
}
