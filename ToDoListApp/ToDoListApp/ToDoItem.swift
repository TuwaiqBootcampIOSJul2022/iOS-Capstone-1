//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Raneem Alkahtani on 26/08/2022.
//

import Foundation

struct ToDoItem: Codable {
    var name:String
    var dateCreated: Date
    var DueDate: Date
    var notes: String
    var isCompleted: Bool
}


