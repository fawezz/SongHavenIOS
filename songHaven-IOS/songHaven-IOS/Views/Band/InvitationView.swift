////
////  InvitationView.swift
////  songHaven-IOS
////
////  Created by SongH on 13/12/2022.
////
//
//import SwiftUI
//import NavigationStack
//
//struct InvitationView: View {
//    @EnvironmentObject private var navigationStack: NavigationStackCompat
//    @StateObject var viewModel = InvitationViewModel()
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
//            VStack{
//                Text("Ivitations")
//                    .bold()
//                    .foregroundColor(.purple)
//                    .font(.system(size: 34,weight: .light,design:.serif))
//
//                VStack(alignment: .leading){
//                    Spacer()
//                    if(!$viewModel.userBands.isEmpty){
//                        ScrollView(.vertical){
//                            LazyVStack(spacing: 20){
//                                ForEach($viewModel.userBands, id: \._id) { band in
//                                    BandCard(band: band.wrappedValue)
//                                        .padding(.horizontal, 3)
//                                        .onTapGesture {
//                                            self.navigationStack.push(BandDetailView(viewModel: BandDetailViewModel(selectedBand: band.wrappedValue)))
//                                        }
//                                }
//                            }
//                        }
//                    }else{
//                        HStack{
//                            Text("You don't have any Invitations yet")
//                                .foregroundColor(.white)
//                                .font(.title3)
//                                .padding(.all, 50)
//                        }
//                    }
//                    Spacer()
//                }
//
//
//
//            }
//        }
//    }
//}
//
//struct InvitationView_Previews: PreviewProvider {
//    static var previews: some View {
//        InvitationView()
//    }
//}
