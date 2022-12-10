//
//  HomeModel.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import Foundation

// MARK: - HomeModel -

struct HomeModel: Codable {
    var invites: Invites?
    var likes: Likes?
}

// MARK: - Invites -

struct Invites: Codable {
    var profiles: [InvitesProfile]?

    enum CodingKeys: String, CodingKey {
        case profiles
    }
}

// MARK: - InvitesProfile
struct InvitesProfile: Codable {
    var generalInformation: GeneralInformation?
    var photos: [Photo]?

    enum CodingKeys: String, CodingKey {
        case generalInformation = "general_information"
        case photos
    }
}

// MARK: - GeneralInformation -

struct GeneralInformation: Codable {
    var firstName: String?
    var age: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case age
    }
}

// MARK: - Photo -

struct Photo: Codable {
    var photo: String?
    var photoID: Int?
    var selected: Bool?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case photo
        case photoID = "photo_id"
        case selected, status
    }
}

// MARK: - Likes -

struct Likes: Codable {
    var profiles: [LikesProfile]?
    var canSeeProfile: Bool?
    var likesReceivedCount: Int?

    enum CodingKeys: String, CodingKey {
        case profiles
        case canSeeProfile = "can_see_profile"
        case likesReceivedCount = "likes_received_count"
    }
}

// MARK: - LikesProfile -

struct LikesProfile: Codable {
    var firstName: String?
    var avatar: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case avatar
    }
}
