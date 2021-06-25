//
//  DoggiePediaModel.swift
//  doggiepedia
//
//  Created by Kevin Drake and Cinthya Rosales on 4/28/21.
//

import Foundation

struct DoggiePediaModel {
    var breedInfo : [[String]] = [
        ["Basenji", "https://www.petfinder.com/dog-breeds/basenji/", "Congo Terrier", "22-24", "16-17"],
        ["Basset Hound", "https://www.petfinder.com/dog-breeds/basset-hound/", " ","40-60", "14"],
        ["Beagle", "https://www.petfinder.com/dog-breeds/beagle/", "English Beagle", "18-30", "13"],
        ["Bernese Mountain Dog", "https://www.petfinder.com/dog-breeds/bernese-mountain-dog/", "Bernese Cattle Dog", "70-120", "23-27.5"],
        ["Bloodhound", "https://www.petfinder.com/dog-breeds/bloodhound/", "St. Hubertâs Hound", "80-90", "23-27"],
        ["Boxer", "https://www.petfinder.com/dog-breeds/boxer/", " " ,"50-80", "21-25" ],
        ["Bulldog", "https://www.petfinder.com/dog-breeds/american-bulldog/", " ", "60-120", "20-25"],
        ["Chihuahua", "https://www.petfinder.com/dog-breeds/chihuahua/", " ", "6", "6-9"],
        ["Collie", "https://www.petfinder.com/dog-breeds/collie/", " ", "50-75", "22-26"],
        ["Corgi", "https://www.petfinder.com/dog-breeds/pembroke-welsh-corgi/", " ", "27", " 10-12"],
        ["Doberman Pinscher", "https://www.petfinder.com/dog-breeds/doberman-pinscher/", "Dobermann", "65-90", "24-28"],
        ["German Shepherd", "https://www.petfinder.com/dog-breeds/german-shepherd/", "Deutscher Schäferhund", "75-95", "22-2"],
        ["German Shorthaired Pointer", "https://www.petfinder.com/dog-breeds/german-shorthaired-pointer/", "Deutscher Kurzhaariger Vorstehund", "45-70", "21-25"],
        ["Golden Retriever", "https://www.petfinder.com/dog-breeds/golden-retriever/", " ","55-75", "21.5-24"],
        ["Great Dane", "https://www.petfinder.com/dog-breeds/great-dane/", "German Mastiff", "110-180", "21-35"],
        ["Labrador Retriever", " https://www.petfinder.com/dog-breeds/labrador-retriever/", " ","55-80", "21.5-24.5"],
        ["Malinois", "https://www.petfinder.com/dog-breeds/belgian-malinois/", "Belgian Shepherd", "60-65", "22-2"],
        ["Maltese", "https://www.petfinder.com/dog-breeds/maltese/", "Bichon Maltiase", "4-6", "9-11"],
        ["Mastiff", "https://www.petfinder.com/dog-breeds/mastiff/", "English Mastiff", "175-190", "27.5-30"],
        ["Newfoundland", "https://www.petfinder.com/dog-breeds/newfoundland/"," ", "100-150", "26-28"],
        ["Pomeranian", "https://www.petfinder.com/dog-breeds/pomeranian/", " ", "3-7", "8-11"],
        ["Poodle", "https://www.petfinder.com/dog-breeds/poodle/", "Barbone", "45-65", "2"],
        ["Pug", "https://www.petfinder.com/dog-breeds/pug/", "Mops", "14-18", "10-11"],
        ["Retriever", "https://www.petfinder.com/dog-breeds/chesapeake-bay-retriever/", " ", "55-80", "21-26"],
        ["Rhodesian Ridgeback", "https://www.petfinder.com/dog-breeds/rhodesian-ridgeback/", "African Lion Hound", "70-85", "24-2"],
        ["Rottweiler", "https://www.petfinder.com/dog-breeds/rottweiler/", " ", "80-135", "22-27"],
        ["Saint Bernard", "https://www.petfinder.com/dog-breeds/saint-bernard/", "Alpine Mastiff", "120-200", "25.5-27.5"],
        ["Samoyed", "https://www.petfinder.com/dog-breeds/samoyed/", " ", "35-65", "19-23.5"],
        ["Schnauzer", "https://www.petfinder.com/dog-breeds/standard-schnauzer/", " ", "35-45", "17.5-19.5"],
        ["Shetland Sheepdog", "https://www.petfinder.com/dog-breeds/shetland-sheepdog/", "Sheltie", "20", "13-16"],
        ["Shih Tzu", "https://www.petfinder.com/dog-breeds/shih-tzu/", " ", "9-16", "8-11"],
        ["Siberian Husky", "https://www.petfinder.com/dog-breeds/siberian-husky/"," ", "35-60", "20-23.5"],
        ["English Cocker Spaniel", "https://www.petfinder.com/dog-breeds/english-cocker-spaniel/", " ", "26-34", "15-17"],
        ["Terrier", "https://www.petfinder.com/dog-breeds/yorkshire-terrier/", " ", "7", "8-9"],
        ["Toy Terrier", "https://www.petfinder.com/dog-breeds/toy-fox-terrier/", " ", "3.5-7", "8.5-11"],
        ["Weimaraner", "https://www.petfinder.com/dog-breeds/weimaraner/", " ", "55-90", "23-27"]
    ]
    
    //*******************************************************************************************************************************************************//
    // Input:  An Int corresponding to breed
    // Output: An Array of strings with info needed to build final view
    // To this function takes the row number associated with the breed and returns an array of strings the contain the breed name,
    // weblink petfinder.com breed page, breed aliases, weight, height.
    //*******************************************************************************************************************************************************//
    func getInfo(row: Int) -> [String]{
        return breedInfo[row]
    }
}
