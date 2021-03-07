//
//  LoginResponse.swift
//  RxContacts
//
//  Created by user177273 on 3/6/21.
//

import Foundation

typealias LogRegUpResponse = [LogRegUpResponseElement]

// MARK: - LogRegUpResponseElement
struct LogRegUpResponseElement: Codable {
    let user: User
    let status: String
}


