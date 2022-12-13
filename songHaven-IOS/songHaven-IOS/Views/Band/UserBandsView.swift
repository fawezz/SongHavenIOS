//
//  TestView.swift
//  songHaven-IOS
//
//  Created by SongH on 29/11/2022.
//

import SwiftUI
import Alamofire
import NavigationStack



struct UserBandsView: View {
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject var viewModel = UserBandsViewModel()
    private let  adaptiveColums = [ GridItem( .adaptive(minimum: 170))]
    
    
    var body: some View {
        NavigationStackView{
            ZStack{
                LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack{
                    HStack(spacing: 60){
                        Text("Your Bands")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                        
                        PushView(destination: AddBandView(), tag: "addBand", selection: $viewModel.navigator){}
                        
                        Button(action:{
                            self.navigationStack.push(AddBandView())})
                        {
                            Image(systemName: "cross.circle.fill").foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .padding(8).background(Color.green)
                                .cornerRadius(20)
                                .frame(width: 36,height: 36 , alignment: .trailing)
                                .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                        }
                    }
                 
                    VStack(alignment: .leading){
                        Spacer()
                        if(!$viewModel.userBands.isEmpty){
                            ScrollView(.vertical){
                                LazyVGrid(columns: adaptiveColums, spacing: 20){
                                    ForEach($viewModel.userBands, id: \._id) { band in
                                        BandCard(band: band.wrappedValue)
                                            .padding(.horizontal, 3)
                                            .onTapGesture {
                                                self.navigationStack.push(BandDetailView(viewModel: BandDetailViewModel(selectedBand: band.wrappedValue)))
                                            }
                                    }
                                }
                            }
                        }else{
                            HStack{
                                Text("You don't have any bands yet")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .padding(.all, 50)
                            }
                        }
                        Spacer()
                    }
                }
                .padding(8)
            }
            }
        }
    }

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        UserBandsView()
    }
}




