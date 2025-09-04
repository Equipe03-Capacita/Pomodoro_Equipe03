//
//  EstatisticasView.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import SwiftUI
import Charts

struct EstatisticasView: View {
    @Binding var config: ConfiguracoesViewModel
    @Binding var estatisticas: EstatisticasViewModel
    
    var body: some View {
        VStack {
            Text(localized("Estatísticas", config))
                .font(.largeTitle)
                .padding()
            
            if estatisticas.historico.isEmpty {
                Spacer()
                Text("Nenhuma sessão concluída ainda")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                Chart {
                    ForEach(agruparUltimos7Dias(), id: \.data) { dia in
                        // Barra Foco
                        BarMark(
                            x: .value("Dia", abreviarDia(dia.data)),
                            y: .value("Minutos", dia.foco)
                        )
                        .foregroundStyle(.red)
                        .position(by: .value("Tipo", "Foco"))
                        .annotation(position: .top) {
                            if dia.foco > 0 { Text("\(dia.foco)").font(.caption).foregroundColor(.red) }
                        }

                        // Barra Pausa
                        BarMark(
                            x: .value("Dia", abreviarDia(dia.data)),
                            y: .value("Minutos", dia.pausa)
                        )
                        .foregroundStyle(.blue)
                        .position(by: .value("Tipo", "Pausa"))
                        .annotation(position: .top) {
                            if dia.pausa > 0 { Text("\(dia.pausa)").font(.caption).foregroundColor(.blue) }
                        }
                    }
                }
                .frame(height: 300)
                .padding()
            }
            
            Spacer()
        } // VStack
    } // body
    
    // MARK: - Funções auxiliares fora do body
    private func abreviarDia(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "E"
        return formatter.string(from: date).capitalized
    }
    
    private func agruparUltimos7Dias() -> [DiaResumo] {
        let hoje = Calendar.current.startOfDay(for: Date())
        let seteDiasAtras = Calendar.current.date(byAdding: .day, value: -6, to: hoje)!
        
        let ultimos7 = estatisticas.historico.filter { $0.data >= seteDiasAtras }
        
        let agrupado = Dictionary(grouping: ultimos7) { sessao in
            Calendar.current.startOfDay(for: sessao.data)
        }
        
        let dias = agrupado.map { (data, sessoes) -> DiaResumo in
            let foco = sessoes.filter { $0.tipo == "Foco" }.map(\.minutos).reduce(0, +)
            let pausa = sessoes.filter { $0.tipo == "Pausa" }.map(\.minutos).reduce(0, +)
            return DiaResumo(data: data, foco: foco, pausa: pausa)
        }
        
        var resultado: [DiaResumo] = []
        for i in 0..<7 {
            let dia = Calendar.current.date(byAdding: .day, value: -i, to: hoje)!
            if let existente = dias.first(where: { Calendar.current.isDate($0.data, inSameDayAs: dia) }) {
                resultado.append(existente)
            } else {
                resultado.append(DiaResumo(data: dia, foco: 0, pausa: 0))
            }
        }
        
        return resultado.sorted { $0.data < $1.data }
    }
    
    struct DiaResumo {
        let data: Date
        let foco: Int
        let pausa: Int
    }
}

// MARK: - Preview deve ficar fora do struct
#Preview {
    EstatisticasView(
        config: .constant(.init()),
        estatisticas: .constant(.init())
    )
}
