//
//  ArtistEvents.swift
//  songHaven-IOS
//
//  Created by SongH on 20/12/2022.
//

import SwiftUI
import NavigationStack

struct ArtistEvents: View {
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject var viewModel = ArtistEventsViewModel()
    private let  adaptiveColums = [ GridItem( .adaptive(minimum: 170))]
        var body: some View {
            NavigationStackView{
                ZStack{
                    LinearGradient(gradient: .init(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    VStack{
                        VStack{
                            Text("Your Events")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                         
                                
                                
                                PushView(destination: CreateEvent(), tag: "event", selection: $viewModel.navigator){}
                                
                                Button(action:{
                                    self.navigationStack.push(CreateEvent())})
                                {
                                    Text("Events")
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 30)
                                        .padding(8).background(Color.purple)
                                        .cornerRadius(20)
                                        .frame(width: 36,height: 36 )
                                        .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                                }
                                
                            }.padding(.all)
                      
                   
                        VStack(alignment: .leading){
                            Spacer()
                            if(!$viewModel.ArtistEvents.isEmpty){
                                ScrollView(.vertical){
                                    LazyVGrid(columns: adaptiveColums, spacing: 20){
                                        ForEach($viewModel.ArtistEvents, id: \._id) { event in
                                            EventCard(event: event.wrappedValue)
                                                .padding(.horizontal, 3)
                                                .onTapGesture {
//                                                    self.navigationStack.push(EventDetailView(viewModel: BandDetailViewModel(selectedBand: event.wrappedValue)))
                                                }
                                        }
                                    }
                                }
                            }else{
                                HStack{
                                    Text("You don't have any event yet")
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


struct ArtistEvents_Previews: PreviewProvider {
    static var previews: some View {
        ArtistEvents()
    }
}
