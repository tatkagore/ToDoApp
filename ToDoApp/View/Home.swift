//
//  Home.swift
//  ToDoApp
//
//  Created by Tatiana Simmer on 04/01/2023.
//

import SwiftUI

struct Home: View {
    @StateObject var taskModel: TaskViewModel = .init()
    @Environment(\.self) var env

    @State var isShowingSheet = false
    //MARK: Matched Geometry Namespace
    @Namespace var animation
    
    //MARK: Fetching Task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome back")
                        .font(.callout)
                    Text("Here's Update Today")
                        .font(.title.bold())
                    CustomSegmentedBar()
                        .padding(.top, 5)
                    //MARK: Task view
                    TaskView()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            }
            .padding( )
        }
        .overlay(alignment: .bottom) {
            // MARK: Add button
            Button{
                taskModel.resetTaskData()
                isShowingSheet = true
//                taskModel.openEditTask.toggle()
            } label: {
                Label {
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                    
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(.black, in: Capsule())
            }
            .sheet(isPresented: $isShowingSheet) {
                
                AddNewTask()
                    .environmentObject(taskModel)
            }
            // MARK: Linear Gradient BG
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            .background{
                LinearGradient(colors: [
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
//        .fullScreenCover(isPresented: $isShowingSheet) {
//            print(3)
////            DispatchQueue.main.async{
//                print(4)
//                taskModel.resetTaskData()
//                print(5)
////            }
//        } content: {
//            AddNewTask()
//                .environmentObject(taskModel)
//        }
    }
    
    
    
    private func deleteItems2(_ item: Task) {
        if let ndx = tasks.firstIndex(of: item) {
            env.managedObjectContext.delete(tasks[ndx])
            do {
                try env.managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    //MARK: TaskView
    @ViewBuilder
    func TaskView()->some View{
        
        LazyVGrid(columns:[GridItem(),GridItem()]){
            DynamicFilteredView(currentTab: taskModel.currentTab){
                (task:Task) in
                TaskRowView(task: task)
            }
        }
    }
    
    //MARK: Task Row View
    @ViewBuilder
    func TaskRowView(task: Task)->some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                Spacer()
                
                Menu {
                    Button("Edit", action: {
                        taskModel.openEditTask = true
                        if taskModel.openEditTask{
                            taskModel.editTask = task


                            taskModel.setupTask()
                            isShowingSheet = true
                        }
                    })
                    Button("Delete", action: {deleteItems2(task)})
                    Button("Cancel", action: {})
                } label: {
                    Image(systemName: "ellipsis.circle")

                        .font(.system(size: 26.0, weight: .light))
                        .foregroundColor(.black)
                }
                
//                MARK: Edit Button Only for Non Completed Tasks
                
//                    Button{
//                        taskModel.editTask = task
//                        isShowingSheet = true
//                        taskModel.setupTask()
//                    } label: {
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(.black)
//                    }
                
            }
            Text(task.title ?? "")
                .font(.title3)
                .foregroundColor(.black)
                .padding(.vertical, 10)
            HStack(alignment:.bottom,spacing: 0){
                VStack(alignment:.leading,spacing: 10){
                    Label{
                        Text((task.deadline ?? Date()).formatted(date: .long, time:.omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    Label{
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time:.shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }.font(.caption)
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                if !task.isCompleted{
                    Button{
                        //MARK: Updating Core Data
                        task.isCompleted.toggle()
                        try? env.managedObjectContext.save()
                    }label: {
                        Circle()
                            .strokeBorder(.black,lineWidth: 1.5)
                            .frame(width:25, height:25)
                            .contentShape(Circle())
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Yellow"))
        }
    }
    
    //MARK: Custom Segmented Bar
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today", "Upcoming", "Task Done"]
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background{
                        if taskModel.currentTab == tab{
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {taskModel.currentTab = tab}
                    }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
