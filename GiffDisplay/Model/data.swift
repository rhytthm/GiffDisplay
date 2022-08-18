//
//  data.swift
//  GiffDisplay
//
//  Created by Rhytthm on 18/08/22.
//


import Foundation

//{
//    "data": [
//        { "id":
//          "title":
//          "images":
//                { "original":{ "mp4":}
//                  "looping":{ "mp4":}
//                }
//        }
//    ]
//}


struct Root : Codable{
    let data : [DATA]
}

struct DATA : Codable, Identifiable  {
    let id = UUID()
    let title: String
    let images: IMAGES
}

struct IMAGES : Codable{
    let looping: LOOP
    let original: Original
}

struct LOOP : Codable {
    let mp4: String
}

struct Original : Codable {
    let mp4: String
}



