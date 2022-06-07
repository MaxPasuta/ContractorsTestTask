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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
