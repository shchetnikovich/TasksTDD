//
//  TaskManager.swift
//  TasksTDD
//
//  Created by Anton Shchetnikovich on 07.02.2023.
//

import Foundation

class TaskManager {
    var taskCount: Int {
        return tasks.count
    }
    var doneTaskCount: Int {
        return doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func checkTask(at index: Int) {     //  Отметка о выполнении задачи
        let task = tasks.remove(at: index)     //  метод .remove возвращает элемент, _ - чтобы не ругался
        doneTasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
