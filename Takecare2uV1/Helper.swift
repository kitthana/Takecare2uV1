//
//  Helper.swift
//  Takecare2uV1
//
//  Created by Sherlock Ohm on 24/10/2562 BE.
//  Copyright © 2562 Sherlock Ohm. All rights reserved.
//

import Foundation

struct Helper
{
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
