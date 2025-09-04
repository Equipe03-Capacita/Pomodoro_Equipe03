//
//  pomodorotommy7App.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 28/08/25.
//

import SwiftUI

@main
struct pomodorotommy7App: App {
        @Environment(\.scenePhase) var scenePhase
        
        var config = ConfiguracoesViewModel()
        var estatisticas = EstatisticasViewModel()
        var timerViewModel: TimerViewModel
        
        init() {
            let c = ConfiguracoesViewModel()
            let e = EstatisticasViewModel()
            config = c
            estatisticas = e
            timerViewModel =  TimerViewModel(configuracoes: c, estatistica: e)
        }
        
        var body: some Scene {
            WindowGroup {
                ContentView(
                    config: config,
                    estatistica: estatisticas,
                    timerViewModel: timerViewModel
                    
                )
                .onAppear {
                    config.solicitarPermissaoNotificacoes()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .background:
                    timerViewModel.agendarNotificacaoAoSair()
                case .active:
                    timerViewModel.cancelarNotificacoesPendentes()
                default:
                    break
                }
            }
        }
    }
