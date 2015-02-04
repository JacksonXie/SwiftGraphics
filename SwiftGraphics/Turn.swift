//
//  Turn.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 9/17/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

public enum Turn : Int {
    case Left = 1
    case None = 0
    case Right = -1
}

extension Turn {
    public init(_ p:CGPoint, _ q:CGPoint, _ r:CGPoint) {
        self = Turn.turn(p,q,r)
    }

    static func turn(p:CGPoint, _ q:CGPoint, _ r:CGPoint) -> Turn {
        let c = (q.x - p.x) * (r.y - p.y) - (r.x - p.x) * (q.y - p.y)
        return c == 0 ? .None : (c > 0 ? .Left : .Right)
    }
}

extension Turn : Comparable {
}

public func < (lhs:Turn, rhs:Turn) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

extension Turn : Printable {
    public var description : String {
        get {
            switch self {
                case .None:
                    return "None"
                case .Left:
                    return "Left"
                case .Right:
                    return "Right"
            }
        }
    }
}