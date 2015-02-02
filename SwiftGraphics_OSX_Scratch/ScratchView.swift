//
//  ScratchView.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 1/25/15.
//  Copyright (c) 2015 schwa.io. All rights reserved.
//

import Cocoa

import SwiftGraphics


class ScratchView: NSView {

    var model:Model! {
        didSet {
            model.addObserver(self, forKeyPath: "things", options: NSKeyValueObservingOptions(), context: nil)
            dragging.model = model
        }
    }
    var dragging = Dragging()

    required init?(coder: NSCoder) {
        super.init(coder:coder)

        dragging.view = self
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let context = NSGraphicsContext.currentContext()!.CGContext

        for (index, thing) in enumerate(model.things) {
            if model.selectedThings.containsIndex(index) {
                context.strokeColor = CGColor.redColor()
            }
            thing.drawInContext(context)
        }
    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        self.needsDisplay = true
    }

}

// MARK: -

class Dragging: NSObject {

    var view:NSView! {
        didSet {
            view.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: Selector("click:")))
            view.addGestureRecognizer(NSPanGestureRecognizer(target: self, action: Selector("pan:")))
        }
    }
    var model:Model!

    func click(gestureRecognizer:NSClickGestureRecognizer) {
        let location = gestureRecognizer.locationInView(view)

        for (index, thing) in enumerate(model.things) {
            if thing.contains(location) {
                model.selectedThings.addIndex(index)
                view.needsDisplay = true
                return
            }
        }

        model.selectedThings.removeAllIndexes()
        view.needsDisplay = true
    }

    var draggedObject:Thing? = nil
    var offset:CGPoint = CGPointZero

    func pan(recognizer:NSPanGestureRecognizer) {
        let location = recognizer.locationInView(view)

        switch recognizer.state { 
            case .Began:
                draggedObject = model.objectForPoint(location)
                if let draggedObject = draggedObject {
                    offset = location - draggedObject.center
                }
            case .Changed:
                if let draggedObject = draggedObject {
                    draggedObject.center = location - offset
                }
                break
            case .Ended:
                draggedObject = nil
                offset = CGPointZero
//                dragDidFinish?()
            default:
                break
        }


        view.needsDisplay = true
    }

}

