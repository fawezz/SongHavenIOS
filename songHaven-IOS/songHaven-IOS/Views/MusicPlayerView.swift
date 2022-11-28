//
//  MusicPlayerView.swift
//  songHaven-IOS
//
//  Created by zewaff on 20/11/2022.
//
import SwiftUI

fileprivate let HORIZONTAL_SPACING: CGFloat = 24

struct MusicPlayerView: View {
    
    @StateObject var viewModel: MusicPlayerViewModel
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            //Color.primary_color.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center) {
                    Button(action: {}) {
                        Image(systemName: "arrow.down").foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .padding(8).background(Color.main_color)
                            .cornerRadius(20)
                            .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                    }
                    Spacer()
                    Button(action: {  }) {
                        Image(systemName: "play.square.stack.fill")
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16)
                            .padding(12).background(Color.main_color)
                            .cornerRadius(20)
                            .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                    }
                }.padding(.horizontal, HORIZONTAL_SPACING).padding(.top, 12)
                
                ////////PlayerDiscView(coverImage: viewModel.model.coverImage)
                ZStack {
                    Circle().foregroundColor(.black)
                        .frame(width: 300, height: 300)
                    ForEach(0...15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: (150 + CGFloat((8 * i))) / 2)
                            .stroke(lineWidth: 0.1)
                            .foregroundColor(.white)
                            .frame(width: 150 + CGFloat((8 * i)),
                                   height: 150 + CGFloat((8 * i)))
                    }
                    AsyncImage(url:viewModel.SongImageUrl)
                    {
                        Image in Image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .frame(width: 180,height: 180)
                }
                //.frame(width: 120, height: 120).cornerRadius(60)
                
                Text("viewModel.model.name").foregroundColor(Color.main_color)
                    .padding(.top, 12)
                Text("viewModel.model.artistName").foregroundColor(Color.main_color.opacity(0.8))
                    .padding(.top, 12)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 12) {
                    Text(viewModel.slider.rounded().description).foregroundColor(Color.main_color)
                    Slider(value: $viewModel.slider, in: (0...100)) //viewModel.duration
                        .accentColor(Color.main_color)
                    Button(action: { viewModel.liked.toggle() }) {
                        Image(systemName: viewModel.liked ?  "heart.fill" : "heart").foregroundColor(.purple)
                            .frame(width: 20, height: 20)
                    }
                }.padding(.horizontal, 45)
                
                Spacer()
                
                MusicControleButtons(viewModel: viewModel).padding(.horizontal, 32)
            }.padding(.bottom, HORIZONTAL_SPACING).animation(.spring())
        }
        
    }
    struct MusicControleButtons: View {
        @ObservedObject var viewModel: MusicPlayerViewModel
        
        var body: some View {
            HStack(alignment: .center) {
                Button(action: {  }) {
                    Image("nextIcon").renderingMode(.template)
                        .resizable().frame(width: 18, height: 18)
                        .rotationEffect(Angle(degrees: 180))
                        .padding(20)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.main_color, lineWidth: 2))

                }
                .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                Spacer()
                Button(action: {
                    if(viewModel.isPlaying){
                        viewModel.player.pause()
                        viewModel.isPlaying = false
                    }else{
                        viewModel.player.play()
                        viewModel.isPlaying = true
                    }
                }) {
                    (
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                    )
                    .renderingMode(.template)
                    .resizable().frame(width: 28, height: 28)
                    .padding(40)
                    .foregroundColor(.purple)
                    .overlay(RoundedRectangle(cornerRadius: 60).stroke(Color.main_color, lineWidth: 2))
                }
                .shadow(color: Color.black,radius: 8, x: 0, y: 5)
                Spacer()
                Button(action: {  }) {
                    Image("nextIcon").renderingMode(.template)
                        .resizable().frame(width: 18, height: 18)
                        .padding(20)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.main_color, lineWidth: 2))
                    
                }
                .shadow(color: Color.black,radius: 8, x: 0, y: 5)
            }
            
            
        }
}
}


//
//struct MusicPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        //MusicPlayerView()
//    }
//}
