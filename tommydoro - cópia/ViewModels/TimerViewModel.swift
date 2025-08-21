//
//  TimerViewModel.swift
//  timer
//
//  Created by Eduardo Brilhante on 15/05/25.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var time: Int
    @Published var isOn: Bool
    @Published var descansando: Bool
    @Published var estado: String
    private var timer: Timer?
    
    init() {
        self.time = 1500
        self.isOn = false
        self.descansando = false
        self.estado = "Tarefa"
        
    }
    
    
    
    func formatTime(_ seconds: Int) -> String {
        
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        return "\(minutes):\(remainingSeconds)"
    }
    
    func increaseTime() {
        self.time += 60
    }
    func decreaseTime() {
        self.time -= 60
    }
    
    func startTime() {
        self.isOn = true
        
        
        if self.descansando {
            
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.time -= 1
                
                if self.time == 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.descansando = false
                    self.time = 1500
                    self.estado = "Tarefa"
                    self.startTime()
                }
            }
        } else {
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.time -= 1
                
                if self.time == 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.descansando = true
                    self.time = 300
                    self.estado = "Descanso"
                    self.startTime()
                }
            }
        }
        
        
    }
    func stopTime() {
        self.isOn = false
        
        timer?.invalidate()
        timer = nil
    }
}
