//
//  InvitationView.swift
//  songHaven-IOS
//
//  Created by SongH on 13/12/2022.
//

import SwiftUI
import NavigationStack

struct InvitationsView: View {
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    @StateObject var viewModel = InvitationViewModel()
    @StateObject private var languageService = LocalizationService.shared
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    BackButton(action: {navigationStack.pop()})
                    Spacer()
                }
                .padding()
                Text("Ivitations".localized(languageService.language))
                    .bold()
                    .foregroundColor(.purple)
                    .font(.system(size: 34,weight: .light,design:.serif))

                VStack(alignment: .leading){
                    Spacer()
                    if(!$viewModel.invitations.isEmpty){
                        ScrollView(.vertical){
                            LazyVStack(spacing: 20){
                                ForEach($viewModel.invitations, id: \._id) { invitation in
                                    InvitationCard(actionAccept: {
                                        viewModel.acceptInvitation(invitation: invitation.wrappedValue)
                                    }, actionDecline: {
                                        viewModel.declineInviation(invitation: invitation.wrappedValue)
                                    }, band: invitation.requester.wrappedValue! )
                                }
                            }
                        }
                    }else{
                        HStack{
                            Text("You don't have any Invitations yet".localized(languageService.language))
                                .foregroundColor(.white.opacity(0.8))
                                .font(.title3)
                                .padding(.all, 50)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    
}

struct InvitationView_Previews: PreviewProvider {
    static var previews: some View {
        InvitationsView()
    }
}
