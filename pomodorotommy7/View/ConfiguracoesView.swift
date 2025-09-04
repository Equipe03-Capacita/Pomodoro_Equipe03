//
//  ConfiguracoesView.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import SwiftUI

// MARK: - Configurações
struct ConfiguracoesView: View {
    @Binding var config: ConfiguracoesViewModel
    @Binding var timerViewModel: TimerViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    Toggle(localized("Notificações", config), isOn: $config.notificacoesAtivas)
                    Toggle(localized("Som", config), isOn: $config.somAtivo)
                } header: {
                    Text(localized("Geral", config))
                }
                
                Section{
                    Stepper(
                        "\(localized("Foco", config)): \(config.focoMinutos) min",
                        onIncrement: {
                            if config.focoMinutos < 90 { config.focoMinutos += 5; timerViewModel.resetTimers() }
                        },
                        onDecrement: {
                            if config.focoMinutos > 25 { config.focoMinutos -= 5; timerViewModel.resetTimers() }
                        }
                    )
                    
                    Stepper(
                        "\(localized("Pausa", config)): \(config.pausaMinutos) min",
                        onIncrement: {
                            if config.pausaMinutos < 30 { config.pausaMinutos += 5; timerViewModel.resetTimers() }
                        },
                        onDecrement: {
                            if config.pausaMinutos > 5 { config.pausaMinutos -= 5; timerViewModel.resetTimers() }
                        }
                    )
                } header: {
                    Text(localized("Duração", config))
                }
                Section(header: Text(localized("Idioma", config))) {
                    Picker(selection: $config.idioma, label: Text(localized("Selecione o idioma", config))) {
                        ForEach(Idioma.allCases) { idioma in
                            Text(idioma.rawValue).tag(idioma)
                        }
                    }
                }
                
                Section(header: Text(localized("Tema", config))) {
                    Picker(selection: $config.tema, label: Text(localized("Selecione o tema", config))) {
                        ForEach(Tema.allCases) { tema in
                            Text(localized(tema.rawValue, config)).tag(tema)
                        }
                    }
                }
            }
            .navigationTitle(localized("Configurações", config))
        }
    }
}


#Preview {
    ConfiguracoesView(config: .constant(.init()), timerViewModel: .constant(.init(configuracoes: .init(), estatistica: .init())))
}
