//
//  TimeDiagram.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 12.08.2021.
//

import SwiftUI

struct TimeDiagram: View {
    let width: CGFloat
    let height: CGFloat
    let totalSeconds: Int
    let remainingSeconds: Int
    
    var toValue: CGFloat {
        (0.4 + CGFloat(remainingSeconds) / CGFloat(totalSeconds) * 0.6)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .trim(from: 0.4, to: 1)
                    .stroke(style: .init(lineWidth: 20, lineCap: .round,
                                         lineJoin: .round, miterLimit: 0,
                                         dash: [], dashPhase: 0))
                    .foregroundColor(Color(.systemGray4))
                
                Circle()
                    .trim(from: 0.4, to: toValue)
                    .stroke(style: .init(lineWidth: 20, lineCap: .round,
                                         lineJoin: .round, miterLimit: 0,
                                         dash: [], dashPhase: 0))
                    .foregroundColor(Color(VarkaColors.mainColor))
            }
            .rotationEffect(.degrees(18))
            .scaleEffect(0.8)
            
            Text(remainingSeconds.getStringTimeOfTimer())
                .font(.title)
        }
        .padding(.bottom, -50)
        .frame(width: width, height: height)
    }
}

struct TimeDiagram_Previews: PreviewProvider {
    static var previews: some View {
        TimeDiagram(width: 200,
                    height: 150,
                    totalSeconds: 600,
                    remainingSeconds: 307)
    }
}
