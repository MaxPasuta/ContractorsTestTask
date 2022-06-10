//
//  DetailPersonView.swift
//  ContractorsTestTask
//
//  Created by Максим Пасюта on 08.06.2022.
//

import SwiftUI

struct DetailPersonView: View {
    
    @EnvironmentObject var mainViewModel:MainViewModel
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var uiImage: UIImage? = nil
    
    @State private var isShowImagePicker: Bool = false
    
    var body: some View {
        Form(){
            HStack{
                Spacer()
                VStack(){
                    if mainViewModel.personIcon != nil{
                        Image(uiImage: mainViewModel.personIcon!)
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    else {
                        Image("personNoImage")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    Button {
                        self.isShowImagePicker.toggle()
                        
                    } label: {
                        Text("change")
                    }
                    .font(.headline)
                    .sheet(isPresented: $isShowImagePicker) {
                        ImagePicker(uiImage: self.$mainViewModel.personIcon)
                    }
                    
                }
                Spacer()
            }
            
            HStack{
                Text("Name: ")
                TextField(
                    "Write your name",
                    text: $mainViewModel.peronName,
                    onEditingChanged: { isChanged in
                        if !isChanged {
                            if mainViewModel.textFieldValidatorName(mainViewModel.peronName) {
                                mainViewModel.isNameValid = true
                            } else {
                                mainViewModel.isNameValid = false
                                mainViewModel.peronName = ""
                            }
                        }
                    }
                ).padding()
                if !mainViewModel.isNameValid {
                    Text("Name is Not Valid")
                        .font(.caption2)
                        .foregroundColor(Color.red)
                }
                
            }
            HStack{
                Text("Phone:")
                TextField(
                    "Write your phone",
                    text: $mainViewModel.personPhone,
                    onEditingChanged: { isChanged in
                        if !isChanged {
                            if mainViewModel.textFieldValidatorPhone(mainViewModel.personPhone) {
                                mainViewModel.isPhoneValid = true
                            } else {
                                mainViewModel.isPhoneValid = false
                                mainViewModel.personPhone = ""
                            }
                        }
                    }
                    
                ).padding()
                    .keyboardType(.numberPad)
                if !mainViewModel.isPhoneValid {
                    Text("Phone is Not Valid")
                        .font(.caption2)
                        .foregroundColor(Color.red)
                }
                
            }
            HStack{
                Text("Email: ")
                TextField(
                    "Write your email",
                    text: $mainViewModel.peronEmail,
                    onEditingChanged: { isChanged in
                        if !isChanged {
                            if mainViewModel.textFieldValidatorEmail(mainViewModel.peronEmail) {
                                mainViewModel.isEmailValid = true
                            } else {
                                mainViewModel.isEmailValid = false
                                mainViewModel.peronEmail = ""
                            }
                        }
                    }
                ).padding().keyboardType(.emailAddress)
                if !mainViewModel.isEmailValid {
                    Text("Email is Not Valid")
                        .font(.caption2)
                        .foregroundColor(Color.yellow)
                }
                
            }
            ZStack {
                HStack {
                    Spacer()
                    Button("Save") {
                        refreshOrAddItem()
                    }
                    Spacer()
                }
            }
            
        }
    }
    
    private func refreshOrAddItem() {
        if (mainViewModel.isNameValid && mainViewModel.isPhoneValid){
            mainViewModel.createNewPerson(context: viewContext)
            self.presentation.wrappedValue.dismiss()
        }
        
    }
}

struct AddPersonView_Previews: PreviewProvider {
    @EnvironmentObject var mainViewModel:MainViewModel
    static var previews: some View {
        DetailPersonView()
    }
}



