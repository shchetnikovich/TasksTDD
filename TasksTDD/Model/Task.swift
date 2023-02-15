import Foundation

struct Task {
    let title: String
    let date: Date
    let description: String?
    let location: Location?
    
    
    init(title: String,
         date: Date? = nil,
         description: String? = nil,
         location: Location? = nil
    ) {
        self.title = title
        self.date = date ?? Date()
        self.description = description
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
