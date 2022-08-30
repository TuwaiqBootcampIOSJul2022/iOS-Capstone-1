


import Foundation

struct TaskList : Equatable{
    
    let id = UUID()
    var title :String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?


    static func == (lhs:TaskList ,rhs:TaskList) ->Bool{
        return lhs.id == rhs.id
}
    
    static func loads() -> [TaskList]?{
        return nil
    }
    
    static func loadSample() -> [TaskList]{

        return []
    }
}
