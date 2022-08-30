


import Foundation

struct TaskList : Equatable, Codable{
    
    let id : UUID
    var title :String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?

    init(title: String, isComplete: Bool, dueDate: Date, notes:String? ){
        
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
        
    }
    
    static let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = directory.appendingPathComponent("taskArray").appendingPathExtension("plist")
    
    
    
    static func == (lhs:TaskList ,rhs:TaskList) ->Bool{
        return lhs.id == rhs.id
}
    
    
    static func saveTaskList(_ taskArray: [TaskList]){
        
        let propertyEncoder = PropertyListEncoder()
        let codedTaskArray = try? propertyEncoder.encode(taskArray)
        try? codedTaskArray?.write(to: archiveURL, options: .noFileProtection)
    }

    
    static func loads() -> [TaskList]?{
        
        guard let codedTaskArray = try? Data (contentsOf: archiveURL) else {return nil}
        let propertyDecoder = PropertyListDecoder()
        
        return try? propertyDecoder.decode(Array<TaskList>.self, from: codedTaskArray)
    }
    
    
    static func loadSample() -> [TaskList]{

        return []
    }
}
