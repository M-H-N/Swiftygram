//
//  ViewController.swift
//  Swiftygram
//
//  Created by M-H-N on 07/09/2023.
//  Copyright (c) 2023 M-H-N. All rights reserved.
//

import UIKit
import Swiftygram

class ViewController: UIViewController {
    
    // MARK: Properties
    private let endpoint: IEndpoint = Endpoint()

    
    // MARK: IBOutlets
    @IBOutlet weak var lblTest: UILabel!
    
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.test()
    }


    private func test() {
        let url = URL(string: "https://www.instagram.com/reel/CufGrJzJiDk/?igshid=Y2IzZGU1MTFhOQ==")!
        
        let (shortCode, type) = ShareLinkUtility.shortCode(forUrl: url)!
        
        
        Task {
            do {
                switch type {
                case .user:
                    let user = try await self.endpoint.getUser(withUsername: shortCode)
                    DispatchQueue.main.async { [weak self] in
                        self?.lblTest.text = user?.name
                    }
                case .post: fallthrough
                case .reel:
                    let media = try await self.endpoint.getPost(withShortCode: shortCode)
                    DispatchQueue.main.async { [weak self] in
                        self?.lblTest.text = media?.caption?.text
                        self?.lblTest.text?.append("\(media?.content?.images?.count)")
                    }
                }
                
            } catch {
                print(error.localizedDescription)
                print(String(describing: error))
            }
            
        }
    }
}

