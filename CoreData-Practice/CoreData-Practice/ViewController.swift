//
//  ViewController.swift
//  CoreData-Practice
//
//  Created by 김민 on 4/8/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.backgroundColor = .white

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        container = appDelegate.persistentContainer

        // create
        let entity = NSEntityDescription.entity(forEntityName: "Todo", in: container.viewContext)
        let newTodo = NSManagedObject(entity: entity!, insertInto: container.viewContext)
        newTodo.setValue("뉴늉투두", forKey: "title")
        newTodo.setValue(false, forKey: "isDone")

        try? container.viewContext.save()

        // Read
        let request = NSFetchRequest<NSManagedObject>(entityName: "Todo")
        let todos = try! container.viewContext.fetch(request)

        for todo in todos {
            let isDone = todo.value(forKey: "isDone") as! Bool
            let title = todo.value(forKey: "title") as! String

            print("완료 여부: \(isDone), 할일: \(title)")
        }

        // Update
        request.predicate = NSPredicate(format: "title == %@", "뉴투두")
        var results = try! container.viewContext.fetch(request)

        if let todoToUpdate = results.first {
            todoToUpdate.setValue("투두", forKey: "title")

            try? container.viewContext.save()
        }

        // Delete
        request.predicate = NSPredicate(format: "title == %@", "투두")
        results = try! container.viewContext.fetch(request)

        if let todo = results.first {
            container.viewContext.delete(todo)

            try? container.viewContext.save()
        }
    }
}

