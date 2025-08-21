//
//  PersonDetailView.swift
//  timer
//
//  Created by Eduardo Brilhante on 15/05/25.
//

import SwiftUI

struct CronometerView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        
        ZStack {
            Color.bege
            
            VStack() {
                
                Text(viewModel.estado)
                    .font(.title)
                    .padding(.top, 50)
                
                HStack {
                    Button(action:viewModel.increaseTime) {
                        Image(systemName: "arrowtriangle.up.square.fill")
                    }
                    
                    
                    Text(String(viewModel.formatTime(viewModel.time)))
                    
                    Button(action:viewModel.decreaseTime) {
                        Image(systemName: "arrowtriangle.down.square.fill")
                    }
                    
                    
                }
                .font(.system(size: 50))
                .padding(.top, 20.0)
                
                HStack {
                    Button("start", action: viewModel.startTime)
                    Button("stop", action: viewModel.stopTime)
                }
                .font(.title2)
                .padding(.top, 300)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CronometerView()
}
