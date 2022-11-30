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
    
    @ObservedObject var obs = Observer()
    var body: some View {
        NavigationView{
                /*List(obs.datas){
                i in
                //card(name: i.name, discription: i.discription)
                    Text(i.name)
                
            }.navigationTitle("Bands")*/
            ZStack{
                Color.purple.edgesIgnoringSafeArea(.all)
                VStack{
                        ScrollView{
                            ForEach(obs.datas){ i in
                                
                                card(name: i.name, discription: i.discription)
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
        AF.request("http://172.17.13.13:9090/band/getAllBand").responseData {
            (data) in
            let json = try! JSON(data: data.data!)
            for i in json ["bands"] {
                self.datas.append(datatype(id: i.1["_id"].stringValue, name: i.1["name"].stringValue,  discription: i.1["discription"].stringValue))
                print(i.1)
            }
            //print("1")
        }
        //print("2")
    }
}

struct datatype : Identifiable{
    var id : String
    var name : String
    var discription : String
}

struct card : View {
    
    var name = "Cyrine"
    var discription = "Salem"
    var body: some View {
        
        
HStack(spacing:20){
    
            Image("user")
        .resizable()
        .frame(width: 100,height: 100)
    VStack{
        Text(name).fontWeight(.heavy)

        Text(discription).fontWeight(.heavy)
    }
            


}
.padding(.horizontal)
.shadow(radius: 1)
.background(Color(.white))
.cornerRadius(15)
               
           }
           
           
           
       }
