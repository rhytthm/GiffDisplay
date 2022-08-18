//
//  Parser.swift
//  GiffDisplay
//
//  Created by Rhytthm on 18/08/22.
//

import Foundation

// api key - O46ntDp4rxVsMLoTDp3ljQqO8dhu66Ol
// api link - https://api.giphy.com/v1/gifs/trending?offset=0&limit=10&api_key=O46ntDp4rxVsMLoTDp3ljQqO8dhu66Ol


struct ParserURL {
    // Function to Parse the Data
    func parserURL(completion:@escaping ([String]) -> ()){
        
        let api = URL(string: "https://api.giphy.com/v1/gifs/trending?offset=0&limit=10&api_key=O46ntDp4rxVsMLoTDp3ljQqO8dhu66Ol")
        URLSession.shared.dataTask(with: api!){
            data, response, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            do{
                let result = try JSONDecoder().decode(Root.self, from: data!)
                // variable which shall containg pp4 URL's
                var mp4URL:[String] = []
                
                for res in result.data{
                    let img = res.images
                    // adding just the mp4 url into mp4URL array
                    mp4URL.append(img.original.mp4)
                }
                
                DispatchQueue.main.async {
                    // returning mp4URL array through completion Handler
                    completion(mp4URL)
                }
                
            } catch {
                
            }
            
        }.resume()
    }
}
