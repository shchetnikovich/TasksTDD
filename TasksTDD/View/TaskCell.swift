//
//  TaskCell.swift
//  TasksTDD
//
//  Created by Anton Shchetnikovich on 07.02.2023.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
        
    func configure(withTask task: Task, done: Bool = false) {
        self.titleLabel.text = task.title
        self.locationLabel.text = task.location?.name
        
        if let date = task.date {
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
        }
    }
}
