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

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func insertShape(sender:AnyObject!) {
        println("Insert rectangle")

        model.addThing(Thing(geometry:Rectangle(frame:CGRect(x:0, y:0, width:100, height:100))))

    }

}
