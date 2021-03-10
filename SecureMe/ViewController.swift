//
//  ViewController.swift
//  SecureMe
//
//  Created by Elkana Orbach on 03/01/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var webView: WKWebView!
	
	var url: URL!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if url != nil {
			webView.load(url.absoluteString) //"https://dev.10tix.me/CUu99zG6zne14FodO0Ut")
		}
	}
	
	func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
		webView.reload()
	}
}

extension WKWebView {
	func load(_ urlString: String) {
		if let url = URL(string: urlString) {
			let request = URLRequest(url: url)
			load(request)
		}
	}
}
