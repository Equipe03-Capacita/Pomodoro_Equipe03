//
//  ConfiguracoesViewModel.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import SwiftUI
import UserNotifications

@Observable
class ConfiguracoesViewModel {
    // MARK: - Propriedades
    var notificacoesAtivas: Bool = true {
        didSet {
            if !notificacoesAtivas {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
    }
    var somAtivo: Bool = true
    var focoMinutos: Int = 25
    var pausaMinutos: Int = 5
    var idioma: Idioma = .portugues
    var tema: Tema = .claro

    // MARK: - Permissão de notificações
    func solicitarPermissaoNotificacoes() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Erro ao solicitar permissão: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Enviar notificação
    func enviarNotificacao(titulo: String, mensagem: String, delay: TimeInterval? = nil) {
        guard notificacoesAtivas else { return }

        let content = UNMutableNotificationContent()
        content.title = titulo
        content.body = mensagem
        content.sound = somAtivo ? .default : nil

        let trigger: UNNotificationTrigger?
        if let delay = delay, delay > 0 {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, delay), repeats: false)
        } else {
            trigger = nil
        }

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar notificação: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Helper Pomodoro
    func agendarNotificacaoConclusao(tempoRestante: Int, estaEmPausa: Bool) {
        guard notificacoesAtivas else { return }
        let titulo = estaEmPausa ? "Pausa finalizada!" : "Ciclo de foco finalizado!"
        let mensagem = estaEmPausa ? "Hora de voltar ao foco." : "Hora da pausa."
        enviarNotificacao(titulo: titulo, mensagem: mensagem, delay: TimeInterval(max(1, tempoRestante)))
    }

    // MARK: - Cancelar notificações pendentes
    func cancelarNotificacoesPendentes() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}


