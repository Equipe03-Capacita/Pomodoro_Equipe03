//
//  HomeView.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var config: ConfiguracoesViewModel
    @Binding var timerViewModel: TimerViewModel
    @State private var showExitAlert = false
    
    var body: some View {
        let isDark = (config.tema == .escuro)
        let bgColor = isDark ? Color.black : Color(red: 243/255, green: 232/255, blue: 187/255)
        let textColor = isDark ? Color.white : Color(red: 10/255, green:106/255, blue: 63/255)
        let trackColor = isDark ? Color.white.opacity(0.2) : Color.black.opacity(0.09)
        let ringColor: Color = isDark ? .blue : (timerViewModel.isBreakTime ? .blue : .red)
        
        ZStack {
            bgColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Botão Voltar
                HStack {
                    Button(action: { showExitAlert = true }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise")
                            Text(localized("Reiniciar", config))
                        }
                        .foregroundColor(.blue)
                        .padding()
                    }
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(trackColor, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .offset(y: -110)
                    
                    Circle()
                        .trim(from: 0, to: timerViewModel.progress)
                        .stroke(ringColor, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.degrees(-90))
                        .offset(y: -110)
                    
                    Text(formatTime())
                        .font(.custom("Avenir", size: 65))
                        .fontWeight(.bold)
                        .foregroundColor(textColor)
                        .offset(y: -110)
                    
                    PlayButtonView(config: $config, timerViewModel: $timerViewModel)
                        .offset(y: -50)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showExitAlert) {
            Alert(
                title: Text(localized("AVISO!", config)),
                message: Text(localized("Se reiniciar o cronômetro, perderá seu foco. Deseja mesmo sair?", config)),
                primaryButton: .destructive(Text(localized("Reiniciar", config))) {
                    timerViewModel.resetTimers()
                    timerViewModel.isTimerStarted = false
                },
                secondaryButton: .cancel(Text(localized("Cancelar", config)))
            )
        }
    }
    
    private func formatTime() -> String {
        let secondsToShow = !timerViewModel.isBreakTime ? timerViewModel.timeRemaining : timerViewModel.breakRemaining
        let minutes = secondsToShow / 60
        let seconds = secondsToShow % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
#Preview {
    HomeView(config: .constant(.init()), timerViewModel: .constant(.init(configuracoes: .init(), estatistica: .init())))
}

