//
//  DoggiePediaViewModel.swift
//  doggiepedia
//
//  Created by Kevin Drake and Cinthya Rosales on 4/28/21.
//

import Foundation

class DoggiePediaViewModel: ObservableObject {
    @Published var doggiePediaModel = DoggiePediaModel()
    
    //*******************************************************************************************************************************************************//
    // Input:  A String from classifier identifying dog breed
    // Output: An Array of strings with info needed to build final view
    // To this function takes the breed name from the content and uses it to access breed info from Model. Returns an array of strings the contain the breed name,
    // weblink petfinder.com breed page, breed aliases, weight, height.
    //*******************************************************************************************************************************************************//
    func getRow(breed: String) -> [String]{
        var info: [String] = ["","","","",""]
        
        if(breed == "Basenji"){
            info = doggiePediaModel.getInfo(row: 0)
        }else if (breed == "Basset"){
            info = doggiePediaModel.getInfo(row: 1)
        }else if (breed == "Beagle"){
            info = doggiePediaModel.getInfo(row: 2)
        }else if (breed == "Bernese Mountain Dog"){
            info = doggiePediaModel.getInfo(row: 3)
        }else if (breed == "BloodHound"){
            info = doggiePediaModel.getInfo(row: 4)
        }else if (breed == "Boxer"){
            info = doggiePediaModel.getInfo(row: 5)
        }else if (breed == "Bulldog"){
            info = doggiePediaModel.getInfo(row: 6)
        }else if (breed == "Chihuahua"){
            info = doggiePediaModel.getInfo(row: 7)
        }else if (breed == "Collie"){
            info = doggiePediaModel.getInfo(row: 8)
        }else if (breed == "Corgi"){
            info = doggiePediaModel.getInfo(row: 9)
        }else if (breed == "Doberman"){
            info = doggiePediaModel.getInfo(row: 10)
        }else if (breed == "German Shepherd"){
            info = doggiePediaModel.getInfo(row: 11)
        }else if (breed == "German Shorthaired Pointer"){
            info = doggiePediaModel.getInfo(row: 12)
        }else if (breed == "Golden Retriever"){
            info = doggiePediaModel.getInfo(row: 13)
        }else if (breed == "Great Dane"){
            info = doggiePediaModel.getInfo(row: 14)
        }else if (breed == "Labrador Retriever"){
            info = doggiePediaModel.getInfo(row: 15)
        }else if (breed == "Malinois"){
            info = doggiePediaModel.getInfo(row: 16)
        }else if (breed == "Maltese"){
            info = doggiePediaModel.getInfo(row: 17)
        }else if (breed == "Mastiff"){
            info = doggiePediaModel.getInfo(row: 18)
        }else if (breed == "Newfoundland"){
            info = doggiePediaModel.getInfo(row: 19)
        }else if (breed == "Pomeranian"){
            info = doggiePediaModel.getInfo(row: 20)
        }else if (breed == "Poodle"){
            info = doggiePediaModel.getInfo(row: 21)
        }else if (breed == "Pug"){
            info = doggiePediaModel.getInfo(row: 22)
        }else if (breed == "Retriever"){
            info = doggiePediaModel.getInfo(row: 23)
        }else if (breed == "Rhodesian Ridgeback"){
            info = doggiePediaModel.getInfo(row: 24)
        }else if (breed == "Rottweiler"){
            info = doggiePediaModel.getInfo(row: 25)
        }else if (breed == "Saint Bernard"){
            info = doggiePediaModel.getInfo(row: 26)
        }else if (breed == "Samoyed"){
            info = doggiePediaModel.getInfo(row: 27)
        }else if (breed == "Schnauzer"){
            info = doggiePediaModel.getInfo(row: 28)
        }else if (breed == "Shetland Sheepdog"){
            info = doggiePediaModel.getInfo(row: 29)
        }else if (breed == "Shih Tzu"){
            info = doggiePediaModel.getInfo(row: 30)
        }else if (breed == "Siberian Husky"){
            info = doggiePediaModel.getInfo(row: 31)
        }else if (breed == "English Cocker Spaniel"){
            info = doggiePediaModel.getInfo(row: 32)
        }else if (breed == "Terrier"){
            info = doggiePediaModel.getInfo(row: 33)
        }else if (breed == "Toy Terrier"){
            info = doggiePediaModel.getInfo(row: 34)
        }else if (breed == "Weimaraner"){
            info = doggiePediaModel.getInfo(row: 35)
        }
        
        return info
    }
}
