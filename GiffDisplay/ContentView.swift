//
//  ContentView.swift
//  GiffDisplay
//
//  Created by Rhytthm on 17/08/22.
//

import SwiftUI
import CoreData
import NukeUI

// using NUKEUI to render GIF's

struct ContentView: View {

    // To start app from GIF's TAB ie tag 0
    @State var SelectedTab: Int = 0

    
    var body: some View {
        VStack{
            TabView(selection: $SelectedTab){
                
                //GIF's TAB
                GIF()
                    .tabItem{
                    Image(systemName: "tray.fill")
                    Text("GIFs")
                    }
                    .tag(0)
                
                // Favourite TAB
                FavouriteView()
                    .tabItem{
                    Image(systemName: "heart.fill")
                    .foregroundColor(Color.pink)
                    Text("Favourite")
                    }
                    .tag(1)
                    
            }
            
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GIF: View  {
    
    // To save data in Database
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var parserUrl = ParserURL()
    @State var mp4Url : [String] = []

    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                List {
                    // Traversing mp4Url array
                    ForEach(mp4Url) { url in
                        VStack(alignment: .leading){
                            LazyImage(source: URL(string: url)).frame(idealHeight: UIScreen.main.bounds.width / 2)
                        }.swipeActions {
                            Button("Like") {
                                // on Button click adding the url to Database
                                DataController().addToDatabase(url: url, context: managedObjContext)
                            }.tint(.green)
                        }
                        
                    }
      
                }
            }.navigationTitle("Trending GIF's")
            .onAppear{
                //getting data from parseURL and saving in mp4Url
                parserUrl.parserURL{ (result) in
                    self.mp4Url = result
                }
            }
        }
        
    }
    
}


struct FavouriteView: View {
    
    // To get data from Database
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.urlName,order: .reverse)]) var Url: FetchedResults<UrlEntity>

    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                List{
                    ForEach(Url){ url in
                        VStack(alignment: .leading){
                            // Displaying the Gif from  the URL which we get from Url array
                            LazyImage(source: URL(string: url.urlName ?? "http://www.tea-tron.com/antorodriguez/blog/wp-content/uploads/2016/04/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png")).frame(idealHeight: UIScreen.main.bounds.width / 2)
                                    
                        }
                    }.onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Favourites")
        }
         
    }
    // Function to delete the item when .onDelete is performed
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            print("Deleting")
            offsets.map{Url[$0]}.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
            
        }
    }
}

extension String: Identifiable {
    public var id: String {
        self
    }
}
