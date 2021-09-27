//
//  MultiTappable.swift
//  Motivation
//
//  Created by Zain Sidhu on 27/09/2021.
//

import UIKit

protocol MultiTappableDelegate: class {
    func singleTapDetected(in view: MultiTappable)
    func doubleTapDetected(in view: MultiTappable)
    func longTapDetected(in view: MultiTappable)
}

class ThreadSafeValue<T> {
    private var _value: T
    private lazy var semaphore = DispatchSemaphore(value: 1)
    init(value: T) { _value = value }
    var value: T {
        get {
            semaphore.signal(); defer { semaphore.wait() }
            return _value
        }
        set(value) {
            semaphore.signal(); defer { semaphore.wait() }
            _value = value
        }
    }
}

protocol MultiTappable: UIView {
    var multiTapDelegate: MultiTappableDelegate? { get set }
    var tapCounter: ThreadSafeValue<Int> { get set }
}

extension MultiTappable {
    func initMultiTap() {
        if let delegate = self as? MultiTappableDelegate { multiTapDelegate = delegate }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.multitapActionHandler))
        addGestureRecognizer(tap)
        
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(UIView.longTapHandler))
        longTap.minimumPressDuration = 0.5
        addGestureRecognizer(longTap)
    }

    func multitapAction() {
        if tapCounter.value == 0 {
            DispatchQueue.global(qos: .utility).async {
                usleep(250_000)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if self.tapCounter.value > 1 {
                        self.multiTapDelegate?.doubleTapDetected(in: self)
                    } else {
                        self.multiTapDelegate?.singleTapDetected(in: self)
                    }
                    self.tapCounter.value = 0
                }
            }
        }
        tapCounter.value += 1
    }
    
    func longTapAction() {
        self.multiTapDelegate?.longTapDetected(in: self)
    }
}

private extension UIView {
    @objc func multitapActionHandler() {
        if let tappable = self as? MultiTappable { tappable.multitapAction() }
    }
    
    @objc func longTapHandler(sender:UILongPressGestureRecognizer) {

        if (sender.state == .began) {
            if let tappable = self as? MultiTappable { tappable.longTapAction() }
        }
    }
}
