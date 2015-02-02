//
//  Model.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 2/1/15.
//  Copyright (c) 2015 schwa.io. All rights reserved.
//

import Foundation
import SwiftGraphics

class Model: NSObject {
    dynamic var things:[Thing] = []
    var selectedThings:NSMutableIndexSet = NSMutableIndexSet()

    override init() {
//        things = [
////            Thing(geometry:Rectangle(frame:CGRect(x:0, y:0, width:100, height:100))),
//        ]
    }

    func objectForPoint(point:CGPoint) -> Thing? {
        for (index, thing) in enumerate(things) {
            if thing.contains(point) {
                return thing
            }
        }
        return nil
    }

    func addThing(thing:Thing) {
        self.things.append(thing)
    }
}
