//
//  Coordinator.swift
//  MovieApp
//
//  Created by Kenan on 21.12.24.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    
    func childDidFinish(_ coordinator : Coordinator){
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
    
    func showController(vc: UIViewController) {
        navigationController.show(vc, sender: nil)
    }
}
