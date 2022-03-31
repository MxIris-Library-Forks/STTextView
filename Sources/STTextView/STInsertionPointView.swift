//  Created by Marcin Krzyzanowski
//  https://github.com/krzyzanowskim/STTextView/blob/main/LICENSE.md

import Foundation
import Cocoa

public protocol STInsertionPoint: NSView {
    var insertionPointColor: NSColor { get set }
    func enable()
    func disable()
}

open class STInsertionPointView: NSView, STInsertionPoint {
    private var timer: Timer?
    open var insertionPointWidth: CGFloat = 1 {
        didSet {
            frame.size.width = insertionPointWidth
        }
    }

    open var insertionPointColor: NSColor = .textColor {
        didSet {
            layer?.backgroundColor = insertionPointColor.cgColor
        }
    }

    public override var isFlipped: Bool {
        true
    }

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    convenience init(frame frameRect: NSRect, color: NSColor) {
        self.init(frame: frameRect)
        self.insertionPointColor = color
    }

    private func commonInit() {
        wantsLayer = true
        frame = frame.insetBy(dx: 0, dy: 1)
        frame.size.width = insertionPointWidth
        layer?.backgroundColor = insertionPointColor.cgColor
    }

    /*
    open override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        if superview == nil {
            disable()
        } else {
            enable()
        }
    }
    */

    open func enable() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.isHidden.toggle()
        }
    }

    open func disable() {
        timer = nil
    }
}