//
//  Transition.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 06.08.2021.
//

import UIKit

final class TabBarTransition: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: Properties

    private let viewControllers: [UIViewController]?
    private let transitionDuration: Double = 0.3

    // MARK: Init

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    // MARK: Methods

    private func getIndex(for viewController: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() where thisVC == viewController {
            return index
        }
        return nil
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(for: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(for: toVC)
        else {
            transitionContext.completeTransition(false)
            return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration,
                           delay: 0.3,
                           options: [.curveEaseOut, .transitionCrossDissolve, .preferredFramesPerSecond60],
                           animations: {
                            fromView.frame = fromFrameEnd
                            toView.frame = frame
                           }, completion: {success in
                            fromView.removeFromSuperview()
                            transitionContext.completeTransition(success)
                           })
        }
    }
    
}
