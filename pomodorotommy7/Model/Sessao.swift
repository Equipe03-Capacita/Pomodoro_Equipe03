//
//  Sessao.swift
//  pomodorotommy7
//
//  Created by iredefbmac_20 on 29/08/25.
//

import Foundation

struct Sessao: Identifiable {
    let id = UUID()
    let data: Date
    let minutos: Int
    let tipo: String
}
