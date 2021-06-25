//
//  CameraRollView.swift
//  doggiepedia
//
//  Created by Kevin Drake on 4/23/21.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
 
    var sourceType: UIImagePickerController.SourceType = .camera
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
}

struct CameraRollView: View {
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
 
    var body: some View {
        VStack {
 
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
 
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
 
                    Text("Camera")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .camera)
            }
        }
    }
}

struct CameraRollView_Previews: PreviewProvider {
    static var previews: some View {
        CameraRollView()
    }
}
