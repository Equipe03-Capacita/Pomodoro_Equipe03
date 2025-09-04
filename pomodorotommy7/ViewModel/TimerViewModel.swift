//
//  TimerViewModel.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import SwiftUI
import AudioToolbox
import UserNotifications


@Observable
class TimerViewModel {
    // Controle do Timer
    var isTimerStarted: Bool = false
    var isBreakTime: Bool = false
    var timeRemaining: Int = 25 * 60
    var breakRemaining: Int = 5 * 60
    var progress: CGFloat = 0
    var config: ConfiguracoesViewModel
    var estatistica: EstatisticasViewModel
    
    private var timer: Timer?
    
    init(configuracoes: ConfiguracoesViewModel, estatistica: EstatisticasViewModel) {
        
        self.config = configuracoes
        self.estatistica = estatistica
        self.timeRemaining = config.focoMinutos * 60
                self.breakRemaining = config.pausaMinutos * 60
        resetTimers()
    }
    
    func resetTimers() {
        stopTimer()
        isTimerStarted = false
        timeRemaining = config.focoMinutos * 60
        breakRemaining = config.pausaMinutos * 60
        isBreakTime = false
        progress = 0
    }
    
    func startPauseToggle() {
        isTimerStarted.toggle()
        if isTimerStarted {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func tick() {
    
        if !isBreakTime {
                   if timeRemaining > 0 {
                       timeRemaining -= 1
                       progress = 1 - CGFloat(timeRemaining) / CGFloat(config.focoMinutos * 60)
                   } else {
                       // Fim da sessão de foco
                       estatistica.historico.append(Sessao(data: Date(), minutos: config.focoMinutos, tipo: "Foco"))
                       tocarAlerta()
                       config.enviarNotificacao(titulo: "Ciclo de foco finalizado!", mensagem: "Hora da pausa.")

                       isBreakTime = true
                       breakRemaining = config.pausaMinutos * 60
                       progress = 0
                   }
               } else {
                   if breakRemaining > 0 {
                       breakRemaining -= 1
                       progress = 1 - CGFloat(breakRemaining) / CGFloat(config.pausaMinutos * 60)
                   } else {
                       // Fim da pausa
                       estatistica.historico.append(Sessao(data: Date(), minutos: config.pausaMinutos, tipo: "Pausa"))
                       tocarAlerta()
                       config.enviarNotificacao(titulo: "Pausa finalizada!", mensagem: "Hora de voltar ao foco.")

                       isBreakTime = false
                       resetTimers()
                   }
               }
           }

           // MARK: - Alerta sonoro e vibratório
           private func tocarAlerta() {
               if config.somAtivo {
                   AudioServicesPlaySystemSound(SystemSoundID(1005))
               }
               let generator = UINotificationFeedbackGenerator()
               generator.notificationOccurred(.success)
           }

           // MARK: - Notificações quando o app sai do foreground
           func agendarNotificacaoAoSair() {
               guard isTimerStarted else { return }

               if !isBreakTime {
                   config.enviarNotificacao(
                       titulo: "Ciclo de foco finalizado!",
                       mensagem: "Hora da pausa.",
                       delay: TimeInterval(timeRemaining)
                   )
               } else {
                   config.enviarNotificacao(
                       titulo: "Pausa finalizada!",
                       mensagem: "Hora de voltar ao foco.",
                       delay: TimeInterval(breakRemaining)
                   )
               }
           }

           func cancelarNotificacoesPendentes() {
               UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
           }
       }
