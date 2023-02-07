import Foundation

struct Task {
    let title: String
    let description: String?
    private(set) var date: Date?
    let location: Location?
    
    
    init(title: String, description: String? = nil,
         location: Location? = nil
    ) {
        self.title = title
        self.description = description
        self.date = Date()
        self.location = location
    }
}


extension Task: Equatable {     //  Исключаем date из сравнения (доли миллисекунд мешают корректно сравнивать объекты)
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
           lhs.description == rhs.description,
           lhs.location == rhs.location {
            return true
        }
        return false
    }
}
