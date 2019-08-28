//
//  Extensions.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/22/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation

extension Array {
    
    func subListWithRandomElements(maxLimit: Int) -> Array {
        var tempList = self
        while tempList.count > maxLimit { 
            let randomIndex = Int(arc4random_uniform(UInt32(tempList.count)))
            tempList.remove(at: randomIndex)
        }
        return tempList.shuffled()
    }
    
}
