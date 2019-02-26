//
//  FileLoader.swift
//  WeatheredTests
//
//  Created by Mark Struzinski on 2/23/19.
//  Copyright © 2019 BobStruzSoftware. All rights reserved.
//

import XCTest

class FileLoader {
    func loadFile(named fileName: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: fileName,
                             withExtension: "json")
        guard let fileURL = url,
            let data = try? Data(contentsOf: fileURL) else {
                fatalError("Unable to find file: \(fileName)")
        }
        
        return data
    }
}
