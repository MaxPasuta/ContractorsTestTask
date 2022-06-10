//
//  ContentView.swift
//  ContractorsTestTask
//
//  Created by Максим Пасюта on 07.06.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var mainViewModel:MainViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Persons.name, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Persons>
    
    @State private var showAddPerson = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    Button(action: {
                        mainViewModel.person = item
                        self.showAddPerson.toggle()
                    }, label: {
                        PersonCell(personItem: item)
                    }).sheet(isPresented: self.$showAddPerson) {
                        DetailPersonView()
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton().foregroundColor(Color("label"))
                }
                ToolbarItem {
                    Button(action: {
                        mainViewModel.person = nil
                        self.showAddPerson.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    }).foregroundColor(Color("label")).sheet(isPresented: self.$showAddPerson) {
                        DetailPersonView()
                    }
                    
                    .navigationTitle("Contractors")
                }
            }
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            mainViewModel.delete(context: viewContext)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
