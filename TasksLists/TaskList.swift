//
//  TaskList.swift
//  TasksLists
//
//  Created by Ali Darwiche  on 3/8/17.
//  Copyright © 2017 Ali Darwiche . All rights reserved.
//

import UIKit
import CoreData

class TaskList {
    var taskLists: [NSManagedObject]!
    
    init(){
        taskLists = []
    }
    
    func add(name:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let taskList = NSEntityDescription.insertNewObject(forEntityName: "TaskList", into: managedContext)
        
        
        // Set the attribute values
        taskList.setValue(name, forKey: "name")
        
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
    
    func access() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskList")
        
        request.returnsObjectsAsFaults = false
        var fetchedResults:[NSManagedObject]? = nil
        do {
            try fetchedResults = managedContext.fetch(request) as? [NSManagedObject]
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
        
        
        if taskLists.count > 0 {
            
        }
    }
    
//    func get(name:String) -> NSManagedObject{
//        if taskLists.count > 0 {
//            
//        }
    
//        let firstName = candidates?[index].value(forKey: "firstName") as? String
//        let lastName = candidates?[index].value(forKey: "lastName") as? String
//        let state = candidates?[index].value(forKey: "state") as? String
//        let party = candidates?[index].value(forKey: "party") as? String
//        let result = [firstName, lastName, state, party]
//        
//        return result as! [String]
//    }
//    
//    func numOfCandidates() -> Int {
//        return (candidates?.count)!
//    }
    
}

