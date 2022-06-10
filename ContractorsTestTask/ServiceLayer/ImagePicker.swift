//
//  ImagePicker.swift
//  ContractorsTestTask
//
//  Created by Максим Пасюта on 08.06.2022.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var uiImage: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var uiImage: UIImage?
        
        init(presentationMode: Binding<PresentationMode>, uiImage: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _uiImage = uiImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let Image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            uiImage = Image
            presentationMode.dismiss()
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, uiImage: $uiImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}
