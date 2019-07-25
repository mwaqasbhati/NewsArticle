//
//  Logger.swift
//
//  Created by Muhammad Waqas
//  Copyright © 2019 Emaar . All rights reserved.
//

import Foundation

class Logger {
    class func log(message: String,
                   functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        
        #if DEBUG
            let output = "\(NSDate()): \(message) [\(functionName), line \(lineNumber)]"
            print(output)
        #endif
    }
}
