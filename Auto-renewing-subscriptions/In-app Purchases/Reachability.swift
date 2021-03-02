//
//  Reachability.swift
//  Lucidchart
//
//  Created by Parker Wightman on 1/5/15.
//  Copyright (c) 2015 Lucid Software. All rights reserved.
//

import UIKit

class Reachability {
	var reachable: Bool {
		return reach.reachable
	}

	var wifiReachable: Bool {
		return reach.reachable && !reach.wwanOnly
	}

	private let reach = KSReachability.toInternet()!
	private var changeBlocks = [ReachabilityBlock]()
	private var inititializedBlocks = [ReachabilityBlock]()
	private var view: UIView?

	typealias ReachabilityBlock = (_ reachable: Bool) -> Void

	init() {
		reach.onReachabilityChanged = { reach in
			for block in self.changeBlocks {
				block((reach?.reachable)!)
			}
		}

		reach.onInitializationComplete = { reach in
			for block in self.inititializedBlocks {
				block((reach?.reachable)!)
			}
		}
	}

	static let sharedInstance = Reachability()

	func onChange(_ block: @escaping ReachabilityBlock) {
		changeBlocks.append(block)
	}

	func onInitialize(_ block: @escaping ReachabilityBlock) {
		inititializedBlocks.append(block)
	}
}
