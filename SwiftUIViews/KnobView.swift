//
//  KnobView.swift
//  SwiftUIFundementals
//
//  Created by baturay on 13.05.2024.
//

import SwiftUI

struct KnobView: View {
    //Bind external value and preferred range to knob.
    @Binding var value: Double
    var minVal : Double = 0
    var maxVal : Double = 1.0
    
    var knobSize : CGFloat = 100
    var color : Color = .white
    
    @State private var rotation = 0.0
    @State private var firstTap : CGPoint = CGPoint.zero
    
    private let pi : Double = 3.141592653589
    
    private func getDegree(point : CGPoint) -> Double {
        var tempPoint : CGPoint = point
        //View's origin start from upper left corner, so we need to shift tapping's relative coordinates to bigger circle's center before doing any calculation.
        let radius: CGFloat = knobSize/2
        tempPoint.x -= radius
        tempPoint.y -= radius
        //We need to invert y coordinate because y increases top to bottom.
        tempPoint.y *= -1
        //And we are dividing tap coordinates by radius for getting values between -1,1
        tempPoint.x /= radius
        tempPoint.y /= radius
        var degree = atan2(tempPoint.y,tempPoint.x)
        //atan2's range is between -pi and pi, so if our tap coordinates are below x axis (when y is negative) we have to add 2pi to get full 360 degree.
        if tempPoint.y < 0 {
            degree += 2*pi
        }
        //Finally convert radian angle to degree.
        degree *= 180 / pi
        return degree
    }
    private func setVal(){
        //Turn rotation angle to preferred range and set value for external usage.
        value = ((maxVal-minVal)/360) * rotation
        //print(value)
    }
    
    var body: some View {
        ZStack{
                Circle()
                    .fill(color)
                    .frame(width:knobSize,height:knobSize)
                    .gesture(
                        DragGesture()
                            .onChanged{
                                gesture in
                                let degree = getDegree(point: gesture.location)
                                rotation = degree
                                setVal()
                            }
                    )
                    .onTapGesture (coordinateSpace: .local){
                        location in
                        let degree = getDegree(point: location)
                        rotation = degree
                        setVal()
                        //print("\(degree)")
                        //print("tapped \(firstTap)")
                    }
                    Circle()
                .fill(Color.accentColor)
                    .frame(width:(10/100)*knobSize,height:(10/100)*knobSize)
                    .offset(x:(knobSize/2)-(10/100)*knobSize,y:0)
                    .rotationEffect(.degrees(-rotation), anchor: .center)
            }
        .padding()
    }
}
