//
//  TestView.swift
//  songHaven-IOS
//
//  Created by SongH on 29/11/2022.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import SwiftyJSON


struct TestView: View {
    @StateObject var viewModel = ProfileViewModel()
    private let adaptiveColumns = [GridItem (.adaptive(minimum: 170))
        
        
    ]
    
    @ObservedObject var obs = Observer()
    @State private var name = ""
    var body: some View {
        NavigationView{
            
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Artists & Bands")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                    HStack{
                        
                        TextField("Search...",text:$name)
                            .padding()
                            .frame(width: 300, height :50)
                            .background(Color.white.opacity(0.15))
                            .cornerRadius(50)
                            .foregroundColor(.white)
                        
                        Button(
                            
                            action:{
                            
                                
                            }, label:{
                                Label("", systemImage: "magnifyingglass")
                                    .foregroundColor(.white)
                                    .padding(.leading, -50.0)
                            })
                        
                    }.padding()
                    
                    HStack{
                        
                        HStack{
                            
                            NavigationLink( destination: ArtistSuggestionView()
                                .navigationBarBackButtonHidden(true)){
                               
                                Text("SUGGESTION")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .fixedSize()
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                              
                            }
            
                                Text("BANDS")
                                    .bold()
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                            
                            NavigationLink( destination:TestView()
                                .navigationBarBackButtonHidden(true)){
                                
                                Text("REQUESTS")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 130, height: 50)
                                    .background(Color.clear)
                                    .cornerRadius(15.0)
                                
                                
                            }
                        }

                    }
                    
                        ScrollView{
                            LazyVGrid(columns:adaptiveColumns, spacing: 20){
                                ForEach(obs.datas){ i in
                                    card(name: i.name, discription: i.discription)
                                }//.onDelete(perform:     )
                            }
                            
                        }.scrollIndicators(.hidden)
                    
            
                    }
            }
            
        }
    }
}
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}




class Observer : ObservableObject {
    @Published var datas = [datatype]()
    init(){
        AF.request("http://172.17.2.137:9090/band/getAllBand").responseData {
            (data) in
            let json = try! JSON(data: data.data!)
            for i in json ["bands"] {
                self.datas.append(datatype(id: i.1["_id"].stringValue, name: i.1["name"].stringValue,  discription: i.1["discription"].stringValue))
                print(i.1)
            }
         
        }
            }
}

struct datatype : Identifiable{
    var id : String
    var name : String
    var discription : String
}


struct card : View {
    @StateObject var viewModel = BandsViewModel()
    
    var name = "Cyrine"
    var discription = "Salem"
    var body: some View {

        ZStack{
            NavigationLink( destination: BandDetailView()
                .navigationBarBackButtonHidden(true)){
                    
                    Rectangle()
                        .foregroundColor(.gray)
                        .navigationBarBackButtonHidden(true)
                        .frame(width: 130, height: 130)
                        .opacity(0.20)
                        .cornerRadius(30)
                    
                    
                    
                }
            Rectangle()
                .foregroundColor(.gray)
                .navigationBarBackButtonHidden(true)
                .frame(width: 130, height: 130)
                .opacity(0.20)
                .cornerRadius(30)
            VStack(spacing:20){
             
                
                    
                AsyncImage(url:viewModel.bandImageUrl)
                {
                    Image in Image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .frame(width: 180,height: 180)
                
                HStack{
                   
                    Text(name).fontWeight(.heavy)

                 //   Text(discription).fontWeight(.heavy)
                }
            
        }
        

            


}
.padding(.horizontal)
.shadow(radius: 54)
.background(Color(.clear))
.cornerRadius(15)
.foregroundColor(.white)
.navigationBarBackButtonHidden(true)
.frame(width: 130, height: 130)



               
           }
           
           
           
       }
/*
func deleteItems ( at offsets: IndexSet){
obs.items.remove(atOffsets : offsets)

}
*/
