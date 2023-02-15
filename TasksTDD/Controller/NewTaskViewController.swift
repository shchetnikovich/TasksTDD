//
//  NewTaskViewController.swift
//  TasksTDD
//
//  Created by Anton Shchetnikovich on 13.02.2023.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    var dateFormatter: DateFormatter?
    
    var completion: (() -> Void)?
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func save () {
        let titleString = titleTextField.text ?? ""
        let locationString = locationTextField.text ?? ""
        let df = dateFormatter ?? getDefaultDateFormatter()
        let date = df.date(from: dateTextField.text ?? "")
        let descriptionString = descriptionTextField.text
        let addressString = addressTextField.text ?? ""
        
        geocoder.geocodeAddressString(addressString) { [unowned self] (placemarks, error) in      //  Избавляемся от зацикливания
            guard error == nil else {
                print(error ?? "")
                return
            }
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString, coordinate: coordinate)
            if let date = date {
                let task = Task(title: titleString, date: date, description: descriptionString, location: location)
                self.taskManager.add(task: task)
            } else {
                let task = Task(title: titleString, description: descriptionString, location: location)
                self.taskManager.add(task: task)
            }
        }
    }
    
    private func getDefaultDateFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
}
