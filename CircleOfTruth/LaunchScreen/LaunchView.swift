//
//  LaunchView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/16/22.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var degrees: CGFloat = 0
    @State private var degrees2: CGFloat = 0
    @State private var ellip: [String] = "...".map { String($0) }
    @State private var counter: Int = 0
    @Binding var showLaunchView: Bool
                               
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let timer2 = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    func rotating() {
        if degrees < 30 {
            degrees += 1
            degrees2 += 0.4
        } else {
            showLaunchView = false
        }
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            ZStack {
                ZStack {
                    Image("outerRing")
                        .resizable()
                        .animation(.linear, value: degrees2)
                        .rotationEffect(Angle(degrees: degrees2))
                        
                    Image("middleRing")
                        .resizable()
                        .animation(.linear, value: degrees)
                        .rotationEffect(Angle(degrees: -degrees))
                    Image("innerRing")
                        .resizable()
                        .animation(.linear, value: degrees)
                        .rotationEffect(Angle(degrees: degrees))
                }
                .scaledToFit()
                .padding()
                
                Text("Circle of Truth")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(Color.theme.accent)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text("Loading")
                    
                    ForEach(ellip.indices, id: \.self) { index in
                            Text(ellip[index])
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -3 : 0)
                        }
                    
                }
                .frame(alignment: .bottom)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color.theme.accent)
                .offset(y: 300)
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                rotating()
            }
        }
        .onReceive(timer2) { _ in
            withAnimation(.linear) {
                let lastIndex = ellip.count - 1
                if counter == lastIndex {
                    counter = 0
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
