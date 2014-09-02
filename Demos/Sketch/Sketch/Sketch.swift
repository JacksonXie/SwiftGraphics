//
//  Sketch.swift
//  Sketch
//
//  Created by Jonathan Wight on 8/31/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation

import SwiftGraphics

@objc protocol Shape {
    var frame : CGRect { get }
}

@objc protocol Node : class {
    weak var parent : Node? { get set }
}

@objc protocol GroupNode : Node {
    var children : [Node] { get set }
}

@objc protocol GeometryNode : Node, Named {
    var frame : CGRect { get }
}

@objc protocol Named {
    var name : String? { get }
}

class Group : GroupNode, GeometryNode {
    var parent : Node?
    var children : [Node] = []
    var name : String?
    var frame : CGRect { get {
        let geometryChildren = self.children as [GeometryNode]
        
        let rects = geometryChildren.map {
            (child:GeometryNode) -> CGRect in
            return child.frame
        }

        return CGRect.UnionOfRects(rects)
    } }

    init() {
    }
}

class Circle : Shape, Node, GeometryNode {
    var name : String?
    var frame : CGRect { get { return CGRect(center:center, radius:radius) } }

    var center : CGPoint
    var radius : CGFloat
    var parent : Node?
    
    init(name:String, center:CGPoint, radius:CGFloat) {
        self.name = name
        self.center = center
        self.radius = radius
    }
}

class Line : Shape, Node, GeometryNode {
    var name : String?
    var frame : CGRect { get { return CGRect(P1:self.start, P2:self.end) } }

    var start : CGPoint
    var end : CGPoint
    var parent : Node?
    
    init(name:String, start:CGPoint, end:CGPoint) {
        self.name = name
        self.start = start
        self.end = end
    }
}

class Rectangle : Shape, Node, GeometryNode {
    var name : String?
    var frame : CGRect

    var parent : Node?
    
    init(name:String, frame:CGRect) {
        self.name = name
        self.frame = frame
    }
}

extension Line : Printable {
    var description: String { get { return "Line(\(name))" } }
}
