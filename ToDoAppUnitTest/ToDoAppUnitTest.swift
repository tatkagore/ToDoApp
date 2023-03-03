//
//  ToDoAppUnitTest.swift
//  ToDoAppUnitTest
//
//  Created by Tatiana Simmer on 01/03/2023.
//

import XCTest
import CoreData
import SwiftUI
@testable import ToDoApp

final class ToDoAppUnitTest: XCTestCase {
    
    let viewContext = PersistenceController(inMemory: true).container.viewContext
    @ObservedObject var vm = TaskViewModel()

    var task: Task!
    
    func testAddTask() throws {
        let taskTitle = "Test Task"
        let taskColor = "Yellow"
        let taskDeadline = Date()
        let taskType = "Basic"
        let result = vm.addTask(context: viewContext)
        
        vm.taskTitle = taskTitle
        vm.taskColor = taskColor
        vm.taskDeadline = taskDeadline
        vm.taskType = taskType
        XCTAssertTrue(result)
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        let tasks = try viewContext.fetch(request)
        XCTAssertEqual(tasks.count, 1)
        
        let task = tasks.first!
        XCTAssertEqual(task.color, taskColor)
        XCTAssertEqual(task.title, taskTitle)
        XCTAssertEqual(task.deadline, taskDeadline)
        XCTAssertEqual(task.type, taskType)
    }
}
