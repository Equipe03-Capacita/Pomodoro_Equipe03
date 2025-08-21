//
//  ContentView.swift
//  timer
//
//  Created by Eduardo Brilhante on 05/05/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    
    var body: some View {
        
        
        
            
            NavigationView {
                
                ZStack {
                    Color.bege
                    
                    VStack(spacing: 20) {
                        
                        Spacer()
                        
                        HStack {
                            Button(action:viewModel.increaseTime) {
                                Image(systemName: "arrowtriangle.up.square.fill")
                            }
                            .foregroundColor(Color.softOrange)
                            
                            Text(String(viewModel.formatTime(viewModel.time)))
                            
                            Button(action:viewModel.decreaseTime) {
                                Image(systemName: "arrowtriangle.down.square.fill")
                            }
                            .foregroundColor(Color.softOrange)
                            
                        }
                        .font(.system(size: 50))
                        .padding(30.0)
                        .clipShape(Rectangle())
                        .overlay {
                            Rectangle().stroke(.darkBrown, lineWidth: 2)
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        Spacer()
                        
                        NavigationLink(destination: CronometerView()) {
                            
                            
                            
                            VStack {
                                Image(systemName: "play.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 50))
                                
                            }
                        }
                        .padding()
                        .frame(width: 100.0, height: 100.0)
                        .background(Color.softRed)
                        .cornerRadius(50)
                        .shadow(color: .black, radius: 7)
                        
                        Spacer()
                        
                        HStack(spacing: 50) {
                            NavigationLink(destination: statsView()) {
                                Image(systemName: "text.page.fill")
                            }
                            
                            NavigationLink(destination: tommyView()) {
                                Image("tomateIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 60.0)
                                    
                            }
                            
                            NavigationLink(destination: configView()) {
                                Image(systemName: "gear")
                            }
                            
                        }
                        .font(.system(size: 50))
                        .foregroundColor(Color.softOrange)
                        .shadow(color: .black, radius: 2)
                        
                    }
                    .background(Color.bege)
                    
                }
                .background(Color.bege)
            }
            
            
        
        
        
    }

}



#Preview {
    HomeView()
}
