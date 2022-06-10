//
//  MainViewModel.swift
//  ContractorsTestTask
//
//  Created by Максим Пасюта on 08.06.2022.
//

import Foundation
import CoreData
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var peronName = ""
    @Published var peronEmail = ""
    @Published var personPhone = ""
    @Published var personIcon: UIImage? = nil
    
    @Published var isEmailValid : Bool = true
    @Published var isNameValid : Bool = true
    @Published var isPhoneValid : Bool = true
    
    @Published var person:Persons?{
        
        didSet{
            if let person = person {
                peronName = person.name ?? ""
                peronEmail = person.email ?? ""
                personPhone = person.phone ?? ""
                
                if let data = person.icon{
                    personIcon = UIImage(data: data)
                }
                isNameValid = true
                isPhoneValid = true
            }
            else{
                peronName = ""
                peronEmail = ""
                personPhone = ""
                personIcon = nil
                
                isNameValid = false
                isPhoneValid = false
                isEmailValid = false
            }
        }
    }
    
    func createNewPerson(context:NSManagedObjectContext){
        
        if let person = person {
            person.name = peronName
            person.phone = personPhone
            person.email = peronEmail
            
            DispatchQueue.global().async { [weak self] in
                person.icon = self?.personIcon?.pngData()
                self?.save(context: context)
            }
        }
        else{
            
            let newItem = Persons(context: context)
            newItem.name = peronName
            newItem.phone = personPhone
            newItem.email = peronEmail
            
            DispatchQueue.global().async { [weak self] in
                newItem.icon = self?.personIcon?.pngData()
                self?.save(context: context)
            }
        }
        save(context: context)
    }
    
    func delete(context:NSManagedObjectContext){
        save(context: context)
    }
    
    func save(context:NSManagedObjectContext){
        DispatchQueue.main.async {
            do{
                try context.save()
            }
            catch{
                print(error)
            }
        }
        
    }
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func textFieldValidatorName(_ string: String) -> Bool {
        if string.count > 100 || string.count <= 1{
            return false
        }
        return true
    }
    
    func textFieldValidatorPhone(_ string: String) -> Bool {
        if string.count < 11{
            return false
        }
        let phoneFormat = "^((8|\\+7)[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{7,10}$"
        
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneFormat)
        return phonePredicate.evaluate(with: string)
    }
}
