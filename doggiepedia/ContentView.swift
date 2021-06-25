//*******************************************************************************************************************************************************//
// ContentView.swift
//
// Doggy-pedia
//
// Creators: Kevin Drake and Cinthya Rosales
// Date created: 4/14/21
//
// Last Modified on: 5/11/21
//*******************************************************************************************************************************************************//

import SwiftUI
import UIKit
import CoreML
import Vision


struct ContentView: View {
    @ObservedObject private var doggiePediaViewModel = DoggiePediaViewModel()
    
    @State private var cameraRollButtonWasPressed: Bool = false
    @State private var takeAPhotoButtonWasPressed: Bool = false
    @State private var showCaptureImageView: Bool = false
    @State var image: UIImage?
    @State private var camera: Bool = false
    @State private var noPhoto: Bool = false
    
    var body: some View {
        if !noPhoto{
            
            VStack{
                Image("chooseFunction")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .overlay(HStack {
                        Button( action: {
                            print("\"Take a picture\" Button pressed")
                            self.showCaptureImageView.toggle()
                            camera = true
                            noPhoto = true
                            
                        })
                        {
                            Image("cameraIcon")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                        }
                        .foregroundColor(.black)
                        .position(x: UIScreen.main.bounds.size.width/2.75, y:UIScreen.main.bounds.size.height/2.45)
                        
                        Text("Take A Photo")
                            .foregroundColor(.black)
                            .position(x: UIScreen.main.bounds.size.width/9.0, y:UIScreen.main.bounds.size.height/2.45)
                    })
                    .overlay( HStack {
                        Button( action: {
                            print("\"camerRoll\" Button pressed")
                            self.showCaptureImageView.toggle()
                            camera = false
                            noPhoto = true
                        })
                        {
                            Image("cameraRollButton")
                                .resizable()
                                .frame(width: 75, height: 75, alignment: .center)
                        }
                        .foregroundColor(.black)
                        .position(x: UIScreen.main.bounds.size.width/2.85, y:UIScreen.main.bounds.size.height/1.525)
                        
                        Text("Choose A Photo")
                            .foregroundColor(.black)
                            .position(x: UIScreen.main.bounds.size.width/9.25, y:UIScreen.main.bounds.size.height/1.525)
                    })
            }
        }else if showCaptureImageView {
            CaptureImageView(isShown: $showCaptureImageView, image:$image, type:$camera)
        }
        else{
            classify()
        }
    }
    
    //*******************************************************************************************************************************************************//
    // Input:  takes a UIImage
    // Output: CVPixelBuffer
    // ML model only accepts cvpixelbuffers. This function converts a UIImage into a CVPixelBuffer
    //*******************************************************************************************************************************************************//
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
    
    
    //*******************************************************************************************************************************************************//
    // Input:  no input required
    // Output: Results view
    // This function creates the view for our results view. It displays the chosen image, breed classification, basic breed info, clickable link to breed
    // page on www.petfinder.com and clickable button to reset app for new input.
    //*******************************************************************************************************************************************************//
    func classify() -> some View{
        
        var imagePred: DoggiePediaModel_36_BreedsOutput = DoggiePediaModel_36_BreedsOutput(classLabelProbs: ["Error" : 0.0], classLabel: "Error")
        
        let pixel: CVPixelBuffer? = buffer(from: image!)

        
        do {
            let model = try DoggiePediaModel_36_Breeds(configuration: .init())
            imagePred = try
                model.prediction(image: pixel!)}
        catch {
            print("Error, select appropriate input.")
        }
        
        let retVal: [String : Double] = imagePred.classLabelProbs
        
        var arrayOfSortedValues: Array = [Double]()
        var arrayOfSortedKeys: Array = [String]()
        
        for (k,v) in (Array(retVal).sorted {$0.1 > $1.1}) {
            arrayOfSortedValues.append(v)
            arrayOfSortedKeys.append(k)
        }
        
        let breed: [String] = getBreed(breed: arrayOfSortedKeys[0])
        
        return VStack {
            Image("results")
                .resizable()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .overlay(VStack{
                    Image(uiImage: image!)
                        .resizable()
                        .frame(width: 175, height: 175, alignment: .center)
                        .position(x: UIScreen.main.bounds.size.width/1.95, y:UIScreen.main.bounds.size.height/2.45)
                    VStack{ Text("Breed: \(breed[0])")
                        Text( "Accuracy: \((arrayOfSortedValues[0]*100))%")
                        if breed[2].count > 20 {
                            let AKAArray = breed[2].components(separatedBy: " ")
                            Text("AKA: \(AKAArray[0])")
                            ForEach (AKAArray.indices) { word in
                                if word > 0 {
                                    Text("\(AKAArray[word])")
                                }
                            }
                        } else {
                            Text("AKA: \(breed[2])")
                        }
                        Text("Weight: \(breed[3]) lbs")
                        Text("Height: \(breed[4]) in.")
                        Button( action: {
                            guard let url = URL(string: breed[1]) else { return }
                            UIApplication.shared.open(url)
                        }) {
                            Text("Click For More Information")
                                .font(.headline)
                                .foregroundColor(Color(red: 22/255, green: 60/255, blue: 119/255, opacity: 1))
                            
                        }
                        Button( action: {
                            noPhoto = false
                            cameraRollButtonWasPressed = false
                            takeAPhotoButtonWasPressed = false
                            showCaptureImageView = false
                            camera = false
                        }){
                            Text("Start Over")
                                .font(.headline)
                                .padding()
                                .border(Color.black, width: 4.0)
                                .background(Color.gray)
                                .foregroundColor(Color.black)
                            
                        }
                    }
                    .position(x: UIScreen.main.bounds.size.width/1.95, y:UIScreen.main.bounds.size.height/5.45)
                })
        }
    }
    
    //*******************************************************************************************************************************************************//
    // Input:  A String from classifier identifying dog breed
    // Output: An Array of strings with info needed to build final view
    // This function takes the breed name from the classifer and returns an array of strings the contain the breed name, weblink to petfinder.com breed page,
    // breed aliases, weight, height.
    //*******************************************************************************************************************************************************//
    func getBreed(breed: String) -> [String] {
        switch breed {
        case "basenji":
            return doggiePediaViewModel.getRow(breed: "Basenji")
        case "basset":
            return doggiePediaViewModel.getRow(breed: "Basset")
        case "beagle":
            return doggiePediaViewModel.getRow(breed: "Beagle")
        case "bernese_mountain_dog":
            return doggiePediaViewModel.getRow(breed: "Bernese Mountain Dog")
        case "bloodhound":
            return doggiePediaViewModel.getRow(breed: "Bloodhound")
        case "boxer":
            return doggiePediaViewModel.getRow(breed: "Boxer")
        case "bulldog":
            return doggiePediaViewModel.getRow(breed: "Bulldog")
        case "chihuahua":
            return doggiePediaViewModel.getRow(breed: "Chihuahua")
        case "collie":
            return doggiePediaViewModel.getRow(breed: "Collie")
        case "corgi":
            return doggiePediaViewModel.getRow(breed: "Corgi")
        case "doberman":
            return doggiePediaViewModel.getRow(breed: "Doberman")
        case "german_shepherd":
            return doggiePediaViewModel.getRow(breed: "German Shepherd")
        case "german_short-haired_pointer":
            return doggiePediaViewModel.getRow(breed: "German Shorthaired Pointer")
        case "golden_retriever":
            return doggiePediaViewModel.getRow(breed: "Golden Retriever")
        case "great_dane":
            return doggiePediaViewModel.getRow(breed: "Great Dane")
        case "labrador_retriever":
            return doggiePediaViewModel.getRow(breed: "Labrador Retriever")
        case "malinois":
            return doggiePediaViewModel.getRow(breed: "Malinois")
        case "maltese":
            return doggiePediaViewModel.getRow(breed: "Maltese")
        case "mastiff":
            return doggiePediaViewModel.getRow(breed: "Mastiff")
        case "newfoundland":
            return doggiePediaViewModel.getRow(breed: "Newfoundland")
        case "pomeranian":
            return doggiePediaViewModel.getRow(breed: "Pomeranian")
        case "poodle":
            return doggiePediaViewModel.getRow(breed: "Poodle")
        case "pug":
            return doggiePediaViewModel.getRow(breed: "Pug")
        case "retriever":
            return doggiePediaViewModel.getRow(breed: "Retriever")
        case "rhodesian_ridgeback":
            return doggiePediaViewModel.getRow(breed: "Rhodesian Ridgeback")
        case "rottweiler":
            return doggiePediaViewModel.getRow(breed: "Rottweiler")
        case "saint_bernard":
            return doggiePediaViewModel.getRow(breed: "Saint Bernard")
        case "samoyed":
            return doggiePediaViewModel.getRow(breed: "Samoyed")
        case "schnauzer":
            return doggiePediaViewModel.getRow(breed: "Schnauzer")
        case "shetland_sheepdog":
            return doggiePediaViewModel.getRow(breed: "Shetland Sheepdog")
        case "shih-tzu":
            return doggiePediaViewModel.getRow(breed: "Shih Tzu")
        case "siberian_husky":
            return doggiePediaViewModel.getRow(breed: "Siberian Husky")
        case "spaniel":
            return doggiePediaViewModel.getRow(breed: "English Cocker Spaniel")
        case "terrier":
            return doggiePediaViewModel.getRow(breed: "Terrier")
        case "toy_terrier":
            return doggiePediaViewModel.getRow(breed: "Toy Terrier")
        case "weimaraner":
            return doggiePediaViewModel.getRow(breed: "Weimaraner")
        default:
            return ["Error,\n could not identify your 🐶", "https://www.petfinder.com/", "", "", ""]
        }
    }
}





struct CaptureImageView {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    @Binding var type: Bool
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        if !type {
            picker.sourceType = .photoLibrary
            
        }
        else {
            picker.sourceType = .camera
            
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
