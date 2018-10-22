//
//  FoursquareViewController.swift
//  UnittestExample
//
//  Created by MBA0237P on 10/19/18.
//  Copyright © 2018 IOS Testing. All rights reserved.
//

import UIKit
import WebKit

final class FoursquareViewController: UIViewController {

    private lazy var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configWebView()
        loadWebView()
    }

    private func configWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date.distantPast
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: date) { }
        view.addSubview(webView)
    }

    private func loadWebView() {
        guard var url = URL(string: Api.WebView.Google.authenticate) else { return }
        var parameter: [String: String] = [:]
        parameter["client_id"] = App.Foursquare.clienID
        parameter["response_type"] = "code"
        parameter["redirect_uri"] = App.Foursquare.redirectURI
        url.appendQueryParameters(parameter)
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension FoursquareViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
