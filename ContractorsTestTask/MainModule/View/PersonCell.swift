//
//  PersonCell.swift
//  ContractorsTestTask
//
//  Created by Максим Пасюта on 07.06.2022.
//

import SwiftUI

struct PersonCell: View {
    
    @ObservedObject var personItem:Persons
    
    var body: some View {
        HStack() {
            if let data = personItem.icon{
                Image(uiImage: (UIImage(data: data) ?? UIImage(named: "personNoImage"))!)
                    .resizable()
                    .frame(width: 75, height: 75)
            }
            else {
                Image("personNoImage")
                    .resizable()
                    .frame(width: 75, height: 75)
            }
            
            VStack(alignment: .leading){
                Text(personItem.name ?? "")
                    .font(.title)
                    .foregroundColor(Color("label"))
                Text(personItem.phone ?? "")
                    .foregroundColor(Color("label"))
                if let email = personItem.email{
                    Text(email)
                        .foregroundColor(Color("label"))
                }
                else {
                    Text(" ")
                }
            }
        }
    }
}
