//
//  ContractorsTestTaskApp.swift
//  ContractorsTestTask
//
//  Created by Максим Пасюта on 07.06.2022.
//

import SwiftUI

@main
struct ContractorsTestTaskApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject var mainViewModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(mainViewModel)
        }
    }
}
