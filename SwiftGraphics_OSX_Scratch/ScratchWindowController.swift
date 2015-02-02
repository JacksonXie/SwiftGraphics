//
//  ScratchWindowController.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 2/1/15.
//  Copyright (c) 2015 schwa.io. All rights reserved.
//

import Cocoa

import SwiftGraphics

class ScratchWindowController: NSWindowController {

    var model:Model! {
        didSet {
            contentViewController?.representedObject = model
        }
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        model = Model()
    }

    @IBAction func insertShape(sender:AnyObject!) {
        println("Insert rectangle")

        var mouseLocation = self.window!.mouseLocationOutsideOfEventStream
        let view = contentViewController!.view
        mouseLocation = view.convertPoint(mouseLocation, fromView: nil)

        mouseLocation = mouseLocation.clamped(view.bounds.insetted(dx: 50, dy: 50))

        let thing = Thing(geometry:Rectangle(frame:CGRect(size:CGSize(w:100, h:100))))
        thing.center = mouseLocation


        model.addThing(thing)

    }

}
