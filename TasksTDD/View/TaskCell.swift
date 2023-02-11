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
        
    func configure(withTask task: Task) {
        self.titleLabel.text = task.title
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        if let date = task.date {
            let dateString = df.string(from: date)
            dateLabel.text = dateString
        }
    }
}
