//
//  Coordinator.swift
//  doggiepedia
//
//  Created by Kevin Drake on 5/5/21.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: UIImage?

  init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
  }

  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = unwrapImage
     isCoordinatorShown = false
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}
