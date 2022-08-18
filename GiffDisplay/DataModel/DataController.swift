//
//  DataController.swift
//  GiffDisplay
//
//  Created by Rhytthm on 18/08/22.
//

import Foundation
import CoreData

// GifModel - id(UUID) , urlName(String)

class DataController: ObservableObject{
    // creating container for GifModel
    let container = NSPersistentContainer(name: "GifModel")
    
    init(){
        //Loading the data
        container.loadPersistentStores{ desc, error in
            if let error = error{
                print("Failed to Load the data - \(error.localizedDescription)")
            }
        }
    }
    
    // function to save the data into database
    func save( context: NSManagedObjectContext ){
        do{
            try context.save()
            print("Data Saved !")
        }catch{
            print("Data could not be saved.")
        }
    }
    
    // function to add the URL into database
    func addToDatabase(url: String, context: NSManagedObjectContext){
        let Url = UrlEntity(context: context)
        Url.id = UUID()
        Url.urlName = url
        
        //after adding the values we will save into the database
        save(context: context)
    }

}
