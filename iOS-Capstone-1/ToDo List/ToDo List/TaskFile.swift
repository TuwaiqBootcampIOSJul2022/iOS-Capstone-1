//
//  TaskFile.swift
//  ToDo List
//
//  Created by Kholoud Almutairi on 02/02/1444 AH.
//

import UIKit

struct Task : Codable{
    
    var tasktitle : String
    var details : String? = nil
    var date : String
    var checked = false
    var ldaet = false
    
}

