//
//  TaskListEntity.swift
//  TasksLists
//
//  Created by Ali Darwiche  on 3/12/17.
//  Copyright © 2017 Ali Darwiche . All rights reserved.
//

import UIKit
import CoreData

class TaskListEntity {
    private var taskLists: [TaskList]!
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    
    init(){
        taskLists = []
    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskList")
        
        request.returnsObjectsAsFaults = false
        var fetchedResults:[TaskList]? = nil
        do {
            try fetchedResults = managedContext.fetch(request) as? [TaskList]
        } catch {
            //what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        if let results = fetchedResults {
            taskLists = results
        } else {
            taskLists = []
        }
    }
    
    func add(name:String){
        access()
        let taskList = TaskList(context: managedContext)
        
        // Set the attribute values
        taskList.name = name
        taskList.priorityCount = 0
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    
    func remove(name:String) {
        access()
        if taskLists.count > 0 {
            for taskList in taskLists {
                if taskList.name == name {
                    managedContext.delete(taskList as NSManagedObject)
                    do {
                        try managedContext.save()
                    } catch {
                        // what to do if an error occurs?
                        let nserror = error as NSError
                        NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                        abort()
                    }
                    return
                }
            }
        }
    }
    
    func get(name:String) -> TaskList {
        access()
        if taskLists.count > 0 {
            for taskList in taskLists {
                if taskList.name == name {
                    return taskList
                }
            }
        }
        return TaskList()
    }
    
    func numOfTaskLists() -> Int {
        access()
        return taskLists.count
    }
}

class TaskEntity {
    private var tasks: [Task]!
    private var taskList: TaskList!
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    
    init(taskList: TaskList) {
        self.taskList = taskList
        access()
    }
    
    func access() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
        let sortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
        let sortArray = [sortDescriptor]
        tasks = taskList.tasks?.sortedArray(using: sortArray) as! [Task]!
    }
    
    func add(text:String) {
        access()
        let task = Task(context: managedContext)
        
        // Set the attribute values
        task.text = text
        task.priority = taskList.priorityCount
        taskList.priorityCount += 1
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func remove(text:String) {
        access()
        if tasks.count > 0 {
            for task in tasks {
                if task.text == text {
                    taskList.removeFromTasks(task)
                }
            }
        }
    }
    
    func remove(task:Task) {
        access()
        taskList.removeFromTasks(task)
    }
    
    func get(text:String) -> Task {
        access()
        if tasks.count > 0 {
            for task in tasks {
                if task.text == text {
                    return task
                }
            }
        }
        return Task()
    }
    
    func numOfTasks() -> Int {
        access()
        return tasks.count
    }    
}
