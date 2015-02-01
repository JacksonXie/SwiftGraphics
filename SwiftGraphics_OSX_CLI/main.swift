//
//  main.swift
//  SwiftGraphics_OSX_CLI
//
//  Created by Jonathan Wight on 1/31/15.
//  Copyright (c) 2015 schwa.io. All rights reserved.
//

import Foundation

let points = [
    CGPoint(x:120,y:160),
    CGPoint(x:35,y:200),
    CGPoint(x:220,y:260),
    CGPoint(x:220,y:40),
]

func timeit(block:Void -> Void) {

    let start = CFAbsoluteTimeGetCurrent()
    for var N = 0; N != 10000; ++N {
        block()
    }
    let end = CFAbsoluteTimeGetCurrent()
    println(end - start)
}

timeit() {
    BezierCurve.pointAlongCurveDeCasteljaus(points, t: 0.5)
    return
}

timeit() {
    BezierCurve.pointAlongCurveMatrix(points, t: 0.5)
    return
}

println(BezierCurve.pointAlongCurveDeCasteljaus(points, t: 0.5))
println(BezierCurve.pointAlongCurveMatrix(points, t: 0.5))