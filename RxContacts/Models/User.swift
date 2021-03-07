//
//  User.swift
//  RxContacts
//
//  Created by user177273 on 3/6/21.
//

import Foundation

typealias Users = [User]

// MARK: - User
struct User: Codable {
    let id: Int
    let name, lastName, email: String
    let phoneNumber: Int
    let userImage: String
    let contactsInfo: [ContactsInfo]
    let apiToken, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case userImage = "user_image"
        case contactsInfo = "contacts_info"
        case apiToken = "api_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias Contacts = [ContactsInfo]

// MARK: - ContactsInfo
struct ContactsInfo: Codable {
    let name, lastName, email: String
    let phoneNumber: Int

    enum CodingKeys: String, CodingKey {
        case name
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
    }
}
