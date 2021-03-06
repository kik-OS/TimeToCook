//
//  Int+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 06.08.2021.
//

extension Int {
    
    func getStringTimeOfTimer() -> String {
        let minutes = self / 60
        let seconds = self - (minutes * 60)
        let stringSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        
        return self > 0
            ? "\(minutes):\(stringSeconds)"
            : "Готово!"
    }
}
