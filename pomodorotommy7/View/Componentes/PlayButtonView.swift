//
//  PlayButtonView.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import SwiftUI

// MARK: - Botão Play/Pause
struct PlayButtonView: View {
    
    @Binding var config: ConfiguracoesViewModel
    @Binding var timerViewModel: TimerViewModel
    
    var body: some View {
        Button(action: { timerViewModel.startPauseToggle() }) {
            VStack(spacing: 20) {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(red: 219/255, green: 56/255, blue: 56/255))
                        .frame(width: 200, height: 122)
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 74, height: 74)
                        .foregroundColor(Color(red: 45/255, green: 139/255, blue: 72/255))
                        .offset(y: -52)
                    
                    Image(systemName: timerViewModel.isTimerStarted ? "pause.fill" : "play.fill")
                        .font(.system(size: 37))
                        .foregroundColor(Color(red: 243/255, green: 232/255, blue: 187/255))
                }
                
                Text(localized( timerViewModel.isTimerStarted ? "Pause" : "Play", config))
                    .font(.custom("Avenir", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 219/255, green: 56/255, blue: 56/255))
            }
        }
    }
}

#Preview {
    PlayButtonView(config: .constant(.init()), timerViewModel: .constant(.init(configuracoes: .init(), estatistica: .init())))
}
