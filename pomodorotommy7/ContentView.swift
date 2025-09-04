//
//  ContentView.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 28/08/25.
//

import SwiftUI
import Charts
import AVFoundation
import AudioToolbox
import UserNotifications

enum Idioma: String, CaseIterable, Identifiable {
    case portugues = "Português"
    case ingles = "English"
    var id: String { self.rawValue }
}

enum Tema: String, CaseIterable, Identifiable {
    case claro = "Claro"
    case escuro = "Escuro"
    var id: String { self.rawValue }
}

// Sessão concluída


// MARK: - Função simples de tradução
func localized(_ key: String, _ config: ConfiguracoesViewModel) -> String {
    switch config.idioma {
    case .portugues: return key
    case .ingles:
        switch key {
        case "Início": return "Home"
        case "Estatísticas": return "Statistics"
        case "Configurações": return "Settings"
        case "Geral": return "General"
        case "Notificações": return "Notifications"
        case "Som": return "Sound"
        case "Duração": return "Duration"
        case "Foco": return "Focus"
        case "Pausa": return "Break"
        case "Idioma": return "Language"
        case "Selecione o idioma": return "Select language"
        case "Tema": return "Theme"
        case "Selecione o tema": return "Select theme"
        case "Voltar": return "Back"
        case "AVISO!": return "WARNING!"
        case "Se reiniciar o cronômetro, perderá seu foco. Deseja mesmo sair?":
            return "If you leave the app you will lose your focus. Do you really want to exit?"
        case "Sair": return "Exit"
        case "Reiniciar": return "Reset"
        case "Play": return "Play"
        case "Pause": return "Pause"
        case "Claro": return "Light"
        case "Escuro": return "Dark"
        default: return key
        }
    }
}

// MARK: - ContentView com Tab Bar
struct ContentView: View {
    @State var config: ConfiguracoesViewModel
    @State var timerViewModel: TimerViewModel
    @State var estatisticasViewModel: EstatisticasViewModel
    
    init(config: ConfiguracoesViewModel = .init(), estatistica: EstatisticasViewModel = .init(), timerViewModel: TimerViewModel = .init(configuracoes: .init(), estatistica: .init())) {
        
        _config = .init(wrappedValue: config)
        _timerViewModel = .init(wrappedValue: timerViewModel)
        _estatisticasViewModel = .init(wrappedValue: estatistica)
    }
    
    var body: some View {
        TabView {
            HomeView(config: $config, timerViewModel: $timerViewModel)
                .tabItem {
                    Image(systemName: "timer")
                    Text(localized("Início", config))
                }
            
            EstatisticasView(config: $config, estatisticas: $estatisticasViewModel)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text(localized("Estatísticas", config))
                }
            
            ConfiguracoesView(config: $config, timerViewModel: $timerViewModel)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text(localized("Configurações", config))
                }
        }
        
        .preferredColorScheme(
                    config.tema == .escuro ? .dark :
                    config.tema == .claro ? .light :
                    nil
                    )
    }
}


#Preview {
     ContentView()
}
