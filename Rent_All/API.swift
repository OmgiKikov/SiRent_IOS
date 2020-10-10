//  This file was automatically generated and should not be edited.

import Apollo

public final class EmailVerificationMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation EmailVerification($token: String!, $email: String!) {\n  EmailVerification(token: $token, email: $email) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var token: String
  public var email: String

  public init(token: String, email: String) {
    self.token = token
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["token": token, "email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("EmailVerification", arguments: ["token": GraphQLVariable("token"), "email": GraphQLVariable("email")], type: .object(EmailVerification.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(emailVerification: EmailVerification? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "EmailVerification": emailVerification.flatMap { (value: EmailVerification) -> ResultMap in value.resultMap }])
    }

    public var emailVerification: EmailVerification? {
      get {
        return (resultMap["EmailVerification"] as? ResultMap).flatMap { EmailVerification(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "EmailVerification")
      }
    }

    public struct EmailVerification: GraphQLSelectionSet {
      public static let possibleTypes = ["AllEmailToken"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllEmailToken", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class CheckEmailExistsQuery: GraphQLQuery {
  public let operationDefinition =
    "query CheckEmailExists($email: String!) {\n  validateEmailExist(email: $email) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var email: String

  public init(email: String) {
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("validateEmailExist", arguments: ["email": GraphQLVariable("email")], type: .object(ValidateEmailExist.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(validateEmailExist: ValidateEmailExist? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "validateEmailExist": validateEmailExist.flatMap { (value: ValidateEmailExist) -> ResultMap in value.resultMap }])
    }

    public var validateEmailExist: ValidateEmailExist? {
      get {
        return (resultMap["validateEmailExist"] as? ResultMap).flatMap { ValidateEmailExist(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "validateEmailExist")
      }
    }

    public struct ValidateEmailExist: GraphQLSelectionSet {
      public static let possibleTypes = ["CommonType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "CommonType", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class ForgotPasswordMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation ForgotPassword($email: String!) {\n  userForgotPassword(email: $email) {\n    __typename\n    status\n    forgotLink\n    errorMessage\n  }\n}"

  public var email: String

  public init(email: String) {
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userForgotPassword", arguments: ["email": GraphQLVariable("email")], type: .object(UserForgotPassword.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userForgotPassword: UserForgotPassword? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userForgotPassword": userForgotPassword.flatMap { (value: UserForgotPassword) -> ResultMap in value.resultMap }])
    }

    public var userForgotPassword: UserForgotPassword? {
      get {
        return (resultMap["userForgotPassword"] as? ResultMap).flatMap { UserForgotPassword(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userForgotPassword")
      }
    }

    public struct UserForgotPassword: GraphQLSelectionSet {
      public static let possibleTypes = ["UserType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("forgotLink", type: .scalar(String.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, forgotLink: String? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "status": status, "forgotLink": forgotLink, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var forgotLink: String? {
        get {
          return resultMap["forgotLink"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "forgotLink")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class UpdateListingStep3Mutation: GraphQLMutation {
  public let operationDefinition =
    "mutation UpdateListingStep3($id: Int, $houseRules: [Int], $bookingNoticeTime: String, $checkInStart: String, $checkInEnd: String, $maxDaysNotice: String, $minNight: Int, $maxNight: Int, $basePrice: Float, $cleaningPrice: Float, $currency: String, $weeklyDiscount: Int, $monthlyDiscount: Int, $blockedDates: [String], $bookingType: String!, $cancellationPolicy: Int) {\n  updateListingStep3(id: $id, houseRules: $houseRules, bookingNoticeTime: $bookingNoticeTime, checkInStart: $checkInStart, checkInEnd: $checkInEnd, maxDaysNotice: $maxDaysNotice, minNight: $minNight, maxNight: $maxNight, basePrice: $basePrice, cleaningPrice: $cleaningPrice, currency: $currency, weeklyDiscount: $weeklyDiscount, monthlyDiscount: $monthlyDiscount, blockedDates: $blockedDates, bookingType: $bookingType, cancellationPolicy: $cancellationPolicy) {\n    __typename\n    results {\n      __typename\n      id\n      houseRules\n      bookingNoticeTime\n      checkInStart\n      checkInEnd\n      maxDaysNotice\n      minNight\n      maxNight\n      basePrice\n      cleaningPrice\n      currency\n      weeklyDiscount\n      monthlyDiscount\n      blockedDates\n    }\n    status\n    errorMessage\n    actionType\n  }\n}"

  public var id: Int?
  public var houseRules: [Int?]?
  public var bookingNoticeTime: String?
  public var checkInStart: String?
  public var checkInEnd: String?
  public var maxDaysNotice: String?
  public var minNight: Int?
  public var maxNight: Int?
  public var basePrice: Double?
  public var cleaningPrice: Double?
  public var currency: String?
  public var weeklyDiscount: Int?
  public var monthlyDiscount: Int?
  public var blockedDates: [String?]?
  public var bookingType: String
  public var cancellationPolicy: Int?

  public init(id: Int? = nil, houseRules: [Int?]? = nil, bookingNoticeTime: String? = nil, checkInStart: String? = nil, checkInEnd: String? = nil, maxDaysNotice: String? = nil, minNight: Int? = nil, maxNight: Int? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, weeklyDiscount: Int? = nil, monthlyDiscount: Int? = nil, blockedDates: [String?]? = nil, bookingType: String, cancellationPolicy: Int? = nil) {
    self.id = id
    self.houseRules = houseRules
    self.bookingNoticeTime = bookingNoticeTime
    self.checkInStart = checkInStart
    self.checkInEnd = checkInEnd
    self.maxDaysNotice = maxDaysNotice
    self.minNight = minNight
    self.maxNight = maxNight
    self.basePrice = basePrice
    self.cleaningPrice = cleaningPrice
    self.currency = currency
    self.weeklyDiscount = weeklyDiscount
    self.monthlyDiscount = monthlyDiscount
    self.blockedDates = blockedDates
    self.bookingType = bookingType
    self.cancellationPolicy = cancellationPolicy
  }

  public var variables: GraphQLMap? {
    return ["id": id, "houseRules": houseRules, "bookingNoticeTime": bookingNoticeTime, "checkInStart": checkInStart, "checkInEnd": checkInEnd, "maxDaysNotice": maxDaysNotice, "minNight": minNight, "maxNight": maxNight, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "weeklyDiscount": weeklyDiscount, "monthlyDiscount": monthlyDiscount, "blockedDates": blockedDates, "bookingType": bookingType, "cancellationPolicy": cancellationPolicy]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateListingStep3", arguments: ["id": GraphQLVariable("id"), "houseRules": GraphQLVariable("houseRules"), "bookingNoticeTime": GraphQLVariable("bookingNoticeTime"), "checkInStart": GraphQLVariable("checkInStart"), "checkInEnd": GraphQLVariable("checkInEnd"), "maxDaysNotice": GraphQLVariable("maxDaysNotice"), "minNight": GraphQLVariable("minNight"), "maxNight": GraphQLVariable("maxNight"), "basePrice": GraphQLVariable("basePrice"), "cleaningPrice": GraphQLVariable("cleaningPrice"), "currency": GraphQLVariable("currency"), "weeklyDiscount": GraphQLVariable("weeklyDiscount"), "monthlyDiscount": GraphQLVariable("monthlyDiscount"), "blockedDates": GraphQLVariable("blockedDates"), "bookingType": GraphQLVariable("bookingType"), "cancellationPolicy": GraphQLVariable("cancellationPolicy")], type: .object(UpdateListingStep3.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateListingStep3: UpdateListingStep3? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateListingStep3": updateListingStep3.flatMap { (value: UpdateListingStep3) -> ResultMap in value.resultMap }])
    }

    public var updateListingStep3: UpdateListingStep3? {
      get {
        return (resultMap["updateListingStep3"] as? ResultMap).flatMap { UpdateListingStep3(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateListingStep3")
      }
    }

    public struct UpdateListingStep3: GraphQLSelectionSet {
      public static let possibleTypes = ["EditListingResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("actionType", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil, actionType: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "EditListingResponse", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage, "actionType": actionType])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var actionType: String? {
        get {
          return resultMap["actionType"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "actionType")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["EditListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("houseRules", type: .list(.scalar(Int.self))),
          GraphQLField("bookingNoticeTime", type: .scalar(String.self)),
          GraphQLField("checkInStart", type: .scalar(String.self)),
          GraphQLField("checkInEnd", type: .scalar(String.self)),
          GraphQLField("maxDaysNotice", type: .scalar(String.self)),
          GraphQLField("minNight", type: .scalar(Int.self)),
          GraphQLField("maxNight", type: .scalar(Int.self)),
          GraphQLField("basePrice", type: .scalar(Double.self)),
          GraphQLField("cleaningPrice", type: .scalar(Double.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("weeklyDiscount", type: .scalar(Int.self)),
          GraphQLField("monthlyDiscount", type: .scalar(Int.self)),
          GraphQLField("blockedDates", type: .list(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, houseRules: [Int?]? = nil, bookingNoticeTime: String? = nil, checkInStart: String? = nil, checkInEnd: String? = nil, maxDaysNotice: String? = nil, minNight: Int? = nil, maxNight: Int? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, weeklyDiscount: Int? = nil, monthlyDiscount: Int? = nil, blockedDates: [String?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "EditListing", "id": id, "houseRules": houseRules, "bookingNoticeTime": bookingNoticeTime, "checkInStart": checkInStart, "checkInEnd": checkInEnd, "maxDaysNotice": maxDaysNotice, "minNight": minNight, "maxNight": maxNight, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "weeklyDiscount": weeklyDiscount, "monthlyDiscount": monthlyDiscount, "blockedDates": blockedDates])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var houseRules: [Int?]? {
          get {
            return resultMap["houseRules"] as? [Int?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "houseRules")
          }
        }

        public var bookingNoticeTime: String? {
          get {
            return resultMap["bookingNoticeTime"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingNoticeTime")
          }
        }

        public var checkInStart: String? {
          get {
            return resultMap["checkInStart"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkInStart")
          }
        }

        public var checkInEnd: String? {
          get {
            return resultMap["checkInEnd"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkInEnd")
          }
        }

        public var maxDaysNotice: String? {
          get {
            return resultMap["maxDaysNotice"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "maxDaysNotice")
          }
        }

        public var minNight: Int? {
          get {
            return resultMap["minNight"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "minNight")
          }
        }

        public var maxNight: Int? {
          get {
            return resultMap["maxNight"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "maxNight")
          }
        }

        public var basePrice: Double? {
          get {
            return resultMap["basePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "basePrice")
          }
        }

        public var cleaningPrice: Double? {
          get {
            return resultMap["cleaningPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "cleaningPrice")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var weeklyDiscount: Int? {
          get {
            return resultMap["weeklyDiscount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "weeklyDiscount")
          }
        }

        public var monthlyDiscount: Int? {
          get {
            return resultMap["monthlyDiscount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "monthlyDiscount")
          }
        }

        public var blockedDates: [String?]? {
          get {
            return resultMap["blockedDates"] as? [String?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "blockedDates")
          }
        }
      }
    }
  }
}

public final class GetAllWishListGroupQuery: GraphQLQuery {
  public let operationDefinition =
    "query getAllWishListGroup($currentPage: Int) {\n  getAllWishListGroup(currentPage: $currentPage) {\n    __typename\n    status\n    count\n    errorMessage\n    results {\n      __typename\n      id\n      name\n      userId\n      isPublic\n      updatedAt\n      wishListIds\n      wishListCount\n      wishListCover {\n        __typename\n        id\n        listId\n        listData {\n          __typename\n          id\n          title\n          personCapacity\n          beds\n          bookingType\n          coverPhoto\n          reviewsCount\n          reviewsStarRating\n          wishListStatus\n          listPhotoName\n          listPhotos {\n            __typename\n            id\n            name\n            type\n            status\n          }\n          listingData {\n            __typename\n            basePrice\n            currency\n          }\n          settingsData {\n            __typename\n            listsettings {\n              __typename\n              id\n              itemName\n            }\n          }\n        }\n      }\n    }\n  }\n}"

  public var currentPage: Int?

  public init(currentPage: Int? = nil) {
    self.currentPage = currentPage
  }

  public var variables: GraphQLMap? {
    return ["currentPage": currentPage]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getAllWishListGroup", arguments: ["currentPage": GraphQLVariable("currentPage")], type: .object(GetAllWishListGroup.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAllWishListGroup: GetAllWishListGroup? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAllWishListGroup": getAllWishListGroup.flatMap { (value: GetAllWishListGroup) -> ResultMap in value.resultMap }])
    }

    public var getAllWishListGroup: GetAllWishListGroup? {
      get {
        return (resultMap["getAllWishListGroup"] as? ResultMap).flatMap { GetAllWishListGroup(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getAllWishListGroup")
      }
    }

    public struct GetAllWishListGroup: GraphQLSelectionSet {
      public static let possibleTypes = ["AllWishListGroup"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("count", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, count: Int? = nil, errorMessage: String? = nil, results: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllWishListGroup", "status": status, "count": count, "errorMessage": errorMessage, "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["WishListGroup"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("isPublic", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(String.self)),
          GraphQLField("wishListIds", type: .list(.scalar(Int.self))),
          GraphQLField("wishListCount", type: .scalar(Int.self)),
          GraphQLField("wishListCover", type: .object(WishListCover.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, name: String? = nil, userId: GraphQLID, isPublic: String? = nil, updatedAt: String? = nil, wishListIds: [Int?]? = nil, wishListCount: Int? = nil, wishListCover: WishListCover? = nil) {
          self.init(unsafeResultMap: ["__typename": "WishListGroup", "id": id, "name": name, "userId": userId, "isPublic": isPublic, "updatedAt": updatedAt, "wishListIds": wishListIds, "wishListCount": wishListCount, "wishListCover": wishListCover.flatMap { (value: WishListCover) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var userId: GraphQLID {
          get {
            return resultMap["userId"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var isPublic: String? {
          get {
            return resultMap["isPublic"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPublic")
          }
        }

        public var updatedAt: String? {
          get {
            return resultMap["updatedAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var wishListIds: [Int?]? {
          get {
            return resultMap["wishListIds"] as? [Int?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListIds")
          }
        }

        public var wishListCount: Int? {
          get {
            return resultMap["wishListCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListCount")
          }
        }

        public var wishListCover: WishListCover? {
          get {
            return (resultMap["wishListCover"] as? ResultMap).flatMap { WishListCover(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "wishListCover")
          }
        }

        public struct WishListCover: GraphQLSelectionSet {
          public static let possibleTypes = ["WishList"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("listId", type: .scalar(Int.self)),
            GraphQLField("listData", type: .object(ListDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, listId: Int? = nil, listData: ListDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "WishList", "id": id, "listId": listId, "listData": listData.flatMap { (value: ListDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var listId: Int? {
            get {
              return resultMap["listId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "listId")
            }
          }

          public var listData: ListDatum? {
            get {
              return (resultMap["listData"] as? ResultMap).flatMap { ListDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listData")
            }
          }

          public struct ListDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["ShowListing"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("personCapacity", type: .scalar(Int.self)),
              GraphQLField("beds", type: .scalar(Int.self)),
              GraphQLField("bookingType", type: .scalar(String.self)),
              GraphQLField("coverPhoto", type: .scalar(Int.self)),
              GraphQLField("reviewsCount", type: .scalar(Int.self)),
              GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
              GraphQLField("wishListStatus", type: .scalar(Bool.self)),
              GraphQLField("listPhotoName", type: .scalar(String.self)),
              GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
              GraphQLField("listingData", type: .object(ListingDatum.selections)),
              GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, title: String? = nil, personCapacity: Int? = nil, beds: Int? = nil, bookingType: String? = nil, coverPhoto: Int? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, wishListStatus: Bool? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "personCapacity": personCapacity, "beds": beds, "bookingType": bookingType, "coverPhoto": coverPhoto, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "wishListStatus": wishListStatus, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var title: String? {
              get {
                return resultMap["title"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var personCapacity: Int? {
              get {
                return resultMap["personCapacity"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "personCapacity")
              }
            }

            public var beds: Int? {
              get {
                return resultMap["beds"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "beds")
              }
            }

            public var bookingType: String? {
              get {
                return resultMap["bookingType"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "bookingType")
              }
            }

            public var coverPhoto: Int? {
              get {
                return resultMap["coverPhoto"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "coverPhoto")
              }
            }

            public var reviewsCount: Int? {
              get {
                return resultMap["reviewsCount"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "reviewsCount")
              }
            }

            public var reviewsStarRating: Int? {
              get {
                return resultMap["reviewsStarRating"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "reviewsStarRating")
              }
            }

            public var wishListStatus: Bool? {
              get {
                return resultMap["wishListStatus"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "wishListStatus")
              }
            }

            public var listPhotoName: String? {
              get {
                return resultMap["listPhotoName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "listPhotoName")
              }
            }

            public var listPhotos: [ListPhoto?]? {
              get {
                return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
              }
            }

            public var listingData: ListingDatum? {
              get {
                return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
              }
            }

            public var settingsData: [SettingsDatum?]? {
              get {
                return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
              }
            }

            public struct ListPhoto: GraphQLSelectionSet {
              public static let possibleTypes = ["listPhotosData"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .scalar(Int.self)),
                GraphQLField("name", type: .scalar(String.self)),
                GraphQLField("type", type: .scalar(String.self)),
                GraphQLField("status", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: Int? = nil, name: String? = nil, type: String? = nil, status: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name, "type": type, "status": status])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: Int? {
                get {
                  return resultMap["id"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var name: String? {
                get {
                  return resultMap["name"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              public var type: String? {
                get {
                  return resultMap["type"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "type")
                }
              }

              public var status: String? {
                get {
                  return resultMap["status"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "status")
                }
              }
            }

            public struct ListingDatum: GraphQLSelectionSet {
              public static let possibleTypes = ["listingData"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("basePrice", type: .scalar(Double.self)),
                GraphQLField("currency", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(basePrice: Double? = nil, currency: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var basePrice: Double? {
                get {
                  return resultMap["basePrice"] as? Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "basePrice")
                }
              }

              public var currency: String? {
                get {
                  return resultMap["currency"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "currency")
                }
              }
            }

            public struct SettingsDatum: GraphQLSelectionSet {
              public static let possibleTypes = ["userListingData"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("listsettings", type: .object(Listsetting.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(listsettings: Listsetting? = nil) {
                self.init(unsafeResultMap: ["__typename": "userListingData", "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var listsettings: Listsetting? {
                get {
                  return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
                }
              }

              public struct Listsetting: GraphQLSelectionSet {
                public static let possibleTypes = ["singleListSettings"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .scalar(Int.self)),
                  GraphQLField("itemName", type: .scalar(String.self)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: Int? = nil, itemName: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: Int? {
                  get {
                    return resultMap["id"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var itemName: String? {
                  get {
                    return resultMap["itemName"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "itemName")
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class CreateWishListMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CreateWishList($listId: Int!, $wishListGroupId: Int, $eventKey: Boolean) {\n  CreateWishList(listId: $listId, wishListGroupId: $wishListGroupId, eventKey: $eventKey) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var listId: Int
  public var wishListGroupId: Int?
  public var eventKey: Bool?

  public init(listId: Int, wishListGroupId: Int? = nil, eventKey: Bool? = nil) {
    self.listId = listId
    self.wishListGroupId = wishListGroupId
    self.eventKey = eventKey
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "wishListGroupId": wishListGroupId, "eventKey": eventKey]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("CreateWishList", arguments: ["listId": GraphQLVariable("listId"), "wishListGroupId": GraphQLVariable("wishListGroupId"), "eventKey": GraphQLVariable("eventKey")], type: .object(CreateWishList.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createWishList: CreateWishList? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "CreateWishList": createWishList.flatMap { (value: CreateWishList) -> ResultMap in value.resultMap }])
    }

    public var createWishList: CreateWishList? {
      get {
        return (resultMap["CreateWishList"] as? ResultMap).flatMap { CreateWishList(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "CreateWishList")
      }
    }

    public struct CreateWishList: GraphQLSelectionSet {
      public static let possibleTypes = ["WishList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "WishList", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class CreateWishListGroupMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CreateWishListGroup($name: String!, $isPublic: String) {\n  CreateWishListGroup(name: $name, isPublic: $isPublic) {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      name\n      isPublic\n      id\n    }\n  }\n}"

  public var name: String
  public var isPublic: String?

  public init(name: String, isPublic: String? = nil) {
    self.name = name
    self.isPublic = isPublic
  }

  public var variables: GraphQLMap? {
    return ["name": name, "isPublic": isPublic]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("CreateWishListGroup", arguments: ["name": GraphQLVariable("name"), "isPublic": GraphQLVariable("isPublic")], type: .object(CreateWishListGroup.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createWishListGroup: CreateWishListGroup? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "CreateWishListGroup": createWishListGroup.flatMap { (value: CreateWishListGroup) -> ResultMap in value.resultMap }])
    }

    public var createWishListGroup: CreateWishListGroup? {
      get {
        return (resultMap["CreateWishListGroup"] as? ResultMap).flatMap { CreateWishListGroup(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "CreateWishListGroup")
      }
    }

    public struct CreateWishListGroup: GraphQLSelectionSet {
      public static let possibleTypes = ["GetWishListType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .object(Result.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: Result? = nil) {
        self.init(unsafeResultMap: ["__typename": "GetWishListType", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["WishListGroup"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("isPublic", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, isPublic: String? = nil, id: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "WishListGroup", "name": name, "isPublic": isPublic, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var isPublic: String? {
          get {
            return resultMap["isPublic"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPublic")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class GetWishListGroupQuery: GraphQLQuery {
  public let operationDefinition =
    "query getWishListGroup($id: Int!, $currentPage: Int) {\n  getWishListGroup(id: $id, currentPage: $currentPage) {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      id\n      name\n      userId\n      isPublic\n      updatedAt\n      wishListIds\n      wishListCount\n      wishLists {\n        __typename\n        id\n        listId\n        listData {\n          __typename\n          id\n          title\n          personCapacity\n          roomType\n          beds\n          bookingType\n          coverPhoto\n          reviewsCount\n          reviewsStarRating\n          wishListStatus\n          listPhotoName\n          listPhotos {\n            __typename\n            id\n            name\n            type\n            status\n          }\n          listingData {\n            __typename\n            basePrice\n            currency\n          }\n          settingsData {\n            __typename\n            listsettings {\n              __typename\n              id\n              itemName\n            }\n          }\n        }\n      }\n    }\n  }\n}"

  public var id: Int
  public var currentPage: Int?

  public init(id: Int, currentPage: Int? = nil) {
    self.id = id
    self.currentPage = currentPage
  }

  public var variables: GraphQLMap? {
    return ["id": id, "currentPage": currentPage]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getWishListGroup", arguments: ["id": GraphQLVariable("id"), "currentPage": GraphQLVariable("currentPage")], type: .object(GetWishListGroup.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getWishListGroup: GetWishListGroup? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getWishListGroup": getWishListGroup.flatMap { (value: GetWishListGroup) -> ResultMap in value.resultMap }])
    }

    public var getWishListGroup: GetWishListGroup? {
      get {
        return (resultMap["getWishListGroup"] as? ResultMap).flatMap { GetWishListGroup(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getWishListGroup")
      }
    }

    public struct GetWishListGroup: GraphQLSelectionSet {
      public static let possibleTypes = ["GetWishListType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .object(Result.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: Result? = nil) {
        self.init(unsafeResultMap: ["__typename": "GetWishListType", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["WishListGroup"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("isPublic", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(String.self)),
          GraphQLField("wishListIds", type: .list(.scalar(Int.self))),
          GraphQLField("wishListCount", type: .scalar(Int.self)),
          GraphQLField("wishLists", type: .list(.object(WishList.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, name: String? = nil, userId: GraphQLID, isPublic: String? = nil, updatedAt: String? = nil, wishListIds: [Int?]? = nil, wishListCount: Int? = nil, wishLists: [WishList?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "WishListGroup", "id": id, "name": name, "userId": userId, "isPublic": isPublic, "updatedAt": updatedAt, "wishListIds": wishListIds, "wishListCount": wishListCount, "wishLists": wishLists.flatMap { (value: [WishList?]) -> [ResultMap?] in value.map { (value: WishList?) -> ResultMap? in value.flatMap { (value: WishList) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var userId: GraphQLID {
          get {
            return resultMap["userId"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var isPublic: String? {
          get {
            return resultMap["isPublic"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPublic")
          }
        }

        public var updatedAt: String? {
          get {
            return resultMap["updatedAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var wishListIds: [Int?]? {
          get {
            return resultMap["wishListIds"] as? [Int?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListIds")
          }
        }

        public var wishListCount: Int? {
          get {
            return resultMap["wishListCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListCount")
          }
        }

        public var wishLists: [WishList?]? {
          get {
            return (resultMap["wishLists"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [WishList?] in value.map { (value: ResultMap?) -> WishList? in value.flatMap { (value: ResultMap) -> WishList in WishList(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [WishList?]) -> [ResultMap?] in value.map { (value: WishList?) -> ResultMap? in value.flatMap { (value: WishList) -> ResultMap in value.resultMap } } }, forKey: "wishLists")
          }
        }

        public struct WishList: GraphQLSelectionSet {
          public static let possibleTypes = ["WishList"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("listId", type: .scalar(Int.self)),
            GraphQLField("listData", type: .object(ListDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, listId: Int? = nil, listData: ListDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "WishList", "id": id, "listId": listId, "listData": listData.flatMap { (value: ListDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var listId: Int? {
            get {
              return resultMap["listId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "listId")
            }
          }

          public var listData: ListDatum? {
            get {
              return (resultMap["listData"] as? ResultMap).flatMap { ListDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listData")
            }
          }

          public struct ListDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["ShowListing"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("title", type: .scalar(String.self)),
              GraphQLField("personCapacity", type: .scalar(Int.self)),
              GraphQLField("roomType", type: .scalar(String.self)),
              GraphQLField("beds", type: .scalar(Int.self)),
              GraphQLField("bookingType", type: .scalar(String.self)),
              GraphQLField("coverPhoto", type: .scalar(Int.self)),
              GraphQLField("reviewsCount", type: .scalar(Int.self)),
              GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
              GraphQLField("wishListStatus", type: .scalar(Bool.self)),
              GraphQLField("listPhotoName", type: .scalar(String.self)),
              GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
              GraphQLField("listingData", type: .object(ListingDatum.selections)),
              GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, title: String? = nil, personCapacity: Int? = nil, roomType: String? = nil, beds: Int? = nil, bookingType: String? = nil, coverPhoto: Int? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, wishListStatus: Bool? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil) {
              self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "personCapacity": personCapacity, "roomType": roomType, "beds": beds, "bookingType": bookingType, "coverPhoto": coverPhoto, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "wishListStatus": wishListStatus, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var title: String? {
              get {
                return resultMap["title"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var personCapacity: Int? {
              get {
                return resultMap["personCapacity"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "personCapacity")
              }
            }

            public var roomType: String? {
              get {
                return resultMap["roomType"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "roomType")
              }
            }

            public var beds: Int? {
              get {
                return resultMap["beds"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "beds")
              }
            }

            public var bookingType: String? {
              get {
                return resultMap["bookingType"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "bookingType")
              }
            }

            public var coverPhoto: Int? {
              get {
                return resultMap["coverPhoto"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "coverPhoto")
              }
            }

            public var reviewsCount: Int? {
              get {
                return resultMap["reviewsCount"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "reviewsCount")
              }
            }

            public var reviewsStarRating: Int? {
              get {
                return resultMap["reviewsStarRating"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "reviewsStarRating")
              }
            }

            public var wishListStatus: Bool? {
              get {
                return resultMap["wishListStatus"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "wishListStatus")
              }
            }

            public var listPhotoName: String? {
              get {
                return resultMap["listPhotoName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "listPhotoName")
              }
            }

            public var listPhotos: [ListPhoto?]? {
              get {
                return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
              }
            }

            public var listingData: ListingDatum? {
              get {
                return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
              }
            }

            public var settingsData: [SettingsDatum?]? {
              get {
                return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
              }
            }

            public struct ListPhoto: GraphQLSelectionSet {
              public static let possibleTypes = ["listPhotosData"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .scalar(Int.self)),
                GraphQLField("name", type: .scalar(String.self)),
                GraphQLField("type", type: .scalar(String.self)),
                GraphQLField("status", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: Int? = nil, name: String? = nil, type: String? = nil, status: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name, "type": type, "status": status])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: Int? {
                get {
                  return resultMap["id"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var name: String? {
                get {
                  return resultMap["name"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }

              public var type: String? {
                get {
                  return resultMap["type"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "type")
                }
              }

              public var status: String? {
                get {
                  return resultMap["status"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "status")
                }
              }
            }

            public struct ListingDatum: GraphQLSelectionSet {
              public static let possibleTypes = ["listingData"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("basePrice", type: .scalar(Double.self)),
                GraphQLField("currency", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(basePrice: Double? = nil, currency: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var basePrice: Double? {
                get {
                  return resultMap["basePrice"] as? Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "basePrice")
                }
              }

              public var currency: String? {
                get {
                  return resultMap["currency"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "currency")
                }
              }
            }

            public struct SettingsDatum: GraphQLSelectionSet {
              public static let possibleTypes = ["userListingData"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("listsettings", type: .object(Listsetting.selections)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(listsettings: Listsetting? = nil) {
                self.init(unsafeResultMap: ["__typename": "userListingData", "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var listsettings: Listsetting? {
                get {
                  return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
                }
              }

              public struct Listsetting: GraphQLSelectionSet {
                public static let possibleTypes = ["singleListSettings"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .scalar(Int.self)),
                  GraphQLField("itemName", type: .scalar(String.self)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: Int? = nil, itemName: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var id: Int? {
                  get {
                    return resultMap["id"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "id")
                  }
                }

                public var itemName: String? {
                  get {
                    return resultMap["itemName"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "itemName")
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class DeleteWishListGroupMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation DeleteWishListGroup($id: Int!) {\n  DeleteWishListGroup(id: $id) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("DeleteWishListGroup", arguments: ["id": GraphQLVariable("id")], type: .object(DeleteWishListGroup.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteWishListGroup: DeleteWishListGroup? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "DeleteWishListGroup": deleteWishListGroup.flatMap { (value: DeleteWishListGroup) -> ResultMap in value.resultMap }])
    }

    public var deleteWishListGroup: DeleteWishListGroup? {
      get {
        return (resultMap["DeleteWishListGroup"] as? ResultMap).flatMap { DeleteWishListGroup(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "DeleteWishListGroup")
      }
    }

    public struct DeleteWishListGroup: GraphQLSelectionSet {
      public static let possibleTypes = ["WishListGroup"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "WishListGroup", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class UpdateWishListGroupMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation UpdateWishListGroup($isPublic: Int, $id: Int!) {\n  UpdateWishListGroup(isPublic: $isPublic, id: $id) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var isPublic: Int?
  public var id: Int

  public init(isPublic: Int? = nil, id: Int) {
    self.isPublic = isPublic
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["isPublic": isPublic, "id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("UpdateWishListGroup", arguments: ["isPublic": GraphQLVariable("isPublic"), "id": GraphQLVariable("id")], type: .object(UpdateWishListGroup.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateWishListGroup: UpdateWishListGroup? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "UpdateWishListGroup": updateWishListGroup.flatMap { (value: UpdateWishListGroup) -> ResultMap in value.resultMap }])
    }

    public var updateWishListGroup: UpdateWishListGroup? {
      get {
        return (resultMap["UpdateWishListGroup"] as? ResultMap).flatMap { UpdateWishListGroup(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "UpdateWishListGroup")
      }
    }

    public struct UpdateWishListGroup: GraphQLSelectionSet {
      public static let possibleTypes = ["WishListGroup"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "WishListGroup", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class GetProfileQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetProfile {\n  userAccount {\n    __typename\n    result {\n      __typename\n      userId\n      profileId\n      firstName\n      lastName\n      displayName\n      gender\n      dateOfBirth\n      iosDOB\n      email\n      userBanStatus\n      phoneNumber\n      preferredLanguage\n      preferredLanguageName\n      preferredCurrency\n      location\n      info\n      createdAt\n      picture\n      country\n      loginUserType\n      isAddedList\n      verification {\n        __typename\n        id\n        isEmailConfirmed\n        isFacebookConnected\n        isGoogleConnected\n        isIdVerification\n        isPhoneVerified\n      }\n      userData {\n        __typename\n        type\n      }\n      verificationCode\n      countryCode\n      loginUserType\n      isAddedList\n    }\n    status\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userAccount", type: .object(UserAccount.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userAccount: UserAccount? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "userAccount": userAccount.flatMap { (value: UserAccount) -> ResultMap in value.resultMap }])
    }

    public var userAccount: UserAccount? {
      get {
        return (resultMap["userAccount"] as? ResultMap).flatMap { UserAccount(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userAccount")
      }
    }

    public struct UserAccount: GraphQLSelectionSet {
      public static let possibleTypes = ["WholeAccount"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "WholeAccount", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["UserAccount"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(GraphQLID.self)),
          GraphQLField("profileId", type: .scalar(Int.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("displayName", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
          GraphQLField("dateOfBirth", type: .scalar(String.self)),
          GraphQLField("iosDOB", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("userBanStatus", type: .scalar(Int.self)),
          GraphQLField("phoneNumber", type: .scalar(String.self)),
          GraphQLField("preferredLanguage", type: .scalar(String.self)),
          GraphQLField("preferredLanguageName", type: .scalar(String.self)),
          GraphQLField("preferredCurrency", type: .scalar(String.self)),
          GraphQLField("location", type: .scalar(String.self)),
          GraphQLField("info", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("picture", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(Int.self)),
          GraphQLField("loginUserType", type: .scalar(String.self)),
          GraphQLField("isAddedList", type: .scalar(Bool.self)),
          GraphQLField("verification", type: .object(Verification.selections)),
          GraphQLField("userData", type: .object(UserDatum.selections)),
          GraphQLField("verificationCode", type: .scalar(Int.self)),
          GraphQLField("countryCode", type: .scalar(String.self)),
          GraphQLField("loginUserType", type: .scalar(String.self)),
          GraphQLField("isAddedList", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: GraphQLID? = nil, profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, displayName: String? = nil, gender: String? = nil, dateOfBirth: String? = nil, iosDob: String? = nil, email: String? = nil, userBanStatus: Int? = nil, phoneNumber: String? = nil, preferredLanguage: String? = nil, preferredLanguageName: String? = nil, preferredCurrency: String? = nil, location: String? = nil, info: String? = nil, createdAt: String? = nil, picture: String? = nil, country: Int? = nil, loginUserType: String? = nil, isAddedList: Bool? = nil, verification: Verification? = nil, userData: UserDatum? = nil, verificationCode: Int? = nil, countryCode: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserAccount", "userId": userId, "profileId": profileId, "firstName": firstName, "lastName": lastName, "displayName": displayName, "gender": gender, "dateOfBirth": dateOfBirth, "iosDOB": iosDob, "email": email, "userBanStatus": userBanStatus, "phoneNumber": phoneNumber, "preferredLanguage": preferredLanguage, "preferredLanguageName": preferredLanguageName, "preferredCurrency": preferredCurrency, "location": location, "info": info, "createdAt": createdAt, "picture": picture, "country": country, "loginUserType": loginUserType, "isAddedList": isAddedList, "verification": verification.flatMap { (value: Verification) -> ResultMap in value.resultMap }, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }, "verificationCode": verificationCode, "countryCode": countryCode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: GraphQLID? {
          get {
            return resultMap["userId"] as? GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var profileId: Int? {
          get {
            return resultMap["profileId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileId")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var displayName: String? {
          get {
            return resultMap["displayName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "displayName")
          }
        }

        public var gender: String? {
          get {
            return resultMap["gender"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "gender")
          }
        }

        public var dateOfBirth: String? {
          get {
            return resultMap["dateOfBirth"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dateOfBirth")
          }
        }

        public var iosDob: String? {
          get {
            return resultMap["iosDOB"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "iosDOB")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var userBanStatus: Int? {
          get {
            return resultMap["userBanStatus"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "userBanStatus")
          }
        }

        public var phoneNumber: String? {
          get {
            return resultMap["phoneNumber"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phoneNumber")
          }
        }

        public var preferredLanguage: String? {
          get {
            return resultMap["preferredLanguage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "preferredLanguage")
          }
        }

        public var preferredLanguageName: String? {
          get {
            return resultMap["preferredLanguageName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "preferredLanguageName")
          }
        }

        public var preferredCurrency: String? {
          get {
            return resultMap["preferredCurrency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "preferredCurrency")
          }
        }

        public var location: String? {
          get {
            return resultMap["location"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "location")
          }
        }

        public var info: String? {
          get {
            return resultMap["info"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "info")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var picture: String? {
          get {
            return resultMap["picture"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "picture")
          }
        }

        public var country: Int? {
          get {
            return resultMap["country"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "country")
          }
        }

        public var loginUserType: String? {
          get {
            return resultMap["loginUserType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "loginUserType")
          }
        }

        public var isAddedList: Bool? {
          get {
            return resultMap["isAddedList"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isAddedList")
          }
        }

        public var verification: Verification? {
          get {
            return (resultMap["verification"] as? ResultMap).flatMap { Verification(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "verification")
          }
        }

        public var userData: UserDatum? {
          get {
            return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "userData")
          }
        }

        public var verificationCode: Int? {
          get {
            return resultMap["verificationCode"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "verificationCode")
          }
        }

        public var countryCode: String? {
          get {
            return resultMap["countryCode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "countryCode")
          }
        }

        public struct Verification: GraphQLSelectionSet {
          public static let possibleTypes = ["UserVerifiedInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("isEmailConfirmed", type: .scalar(Bool.self)),
            GraphQLField("isFacebookConnected", type: .scalar(Bool.self)),
            GraphQLField("isGoogleConnected", type: .scalar(Bool.self)),
            GraphQLField("isIdVerification", type: .scalar(Bool.self)),
            GraphQLField("isPhoneVerified", type: .scalar(Bool.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, isEmailConfirmed: Bool? = nil, isFacebookConnected: Bool? = nil, isGoogleConnected: Bool? = nil, isIdVerification: Bool? = nil, isPhoneVerified: Bool? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserVerifiedInfo", "id": id, "isEmailConfirmed": isEmailConfirmed, "isFacebookConnected": isFacebookConnected, "isGoogleConnected": isGoogleConnected, "isIdVerification": isIdVerification, "isPhoneVerified": isPhoneVerified])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var isEmailConfirmed: Bool? {
            get {
              return resultMap["isEmailConfirmed"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEmailConfirmed")
            }
          }

          public var isFacebookConnected: Bool? {
            get {
              return resultMap["isFacebookConnected"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isFacebookConnected")
            }
          }

          public var isGoogleConnected: Bool? {
            get {
              return resultMap["isGoogleConnected"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isGoogleConnected")
            }
          }

          public var isIdVerification: Bool? {
            get {
              return resultMap["isIdVerification"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isIdVerification")
            }
          }

          public var isPhoneVerified: Bool? {
            get {
              return resultMap["isPhoneVerified"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isPhoneVerified")
            }
          }
        }

        public struct UserDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["UserType"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("type", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(type: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserType", "type": type])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }
        }
      }
    }
  }
}

public final class GetPayoutsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getPayouts {\n  getPayouts {\n    __typename\n    results {\n      __typename\n      id\n      methodId\n      paymentMethod {\n        __typename\n        id\n        name\n      }\n      userId\n      payEmail\n      address1\n      address2\n      city\n      default\n      state\n      country\n      zipcode\n      currency\n      default\n      createdAt\n      last4Digits\n      isVerified\n      status\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getPayouts", type: .object(GetPayout.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPayouts: GetPayout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getPayouts": getPayouts.flatMap { (value: GetPayout) -> ResultMap in value.resultMap }])
    }

    public var getPayouts: GetPayout? {
      get {
        return (resultMap["getPayouts"] as? ResultMap).flatMap { GetPayout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getPayouts")
      }
    }

    public struct GetPayout: GraphQLSelectionSet {
      public static let possibleTypes = ["PayoutWholeType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "PayoutWholeType", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Payout"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("methodId", type: .scalar(Int.self)),
          GraphQLField("paymentMethod", type: .object(PaymentMethod.selections)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("payEmail", type: .scalar(String.self)),
          GraphQLField("address1", type: .scalar(String.self)),
          GraphQLField("address2", type: .scalar(String.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("default", type: .scalar(Bool.self)),
          GraphQLField("state", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
          GraphQLField("zipcode", type: .scalar(String.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("default", type: .scalar(Bool.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("last4Digits", type: .scalar(Int.self)),
          GraphQLField("isVerified", type: .scalar(Bool.self)),
          GraphQLField("status", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, methodId: Int? = nil, paymentMethod: PaymentMethod? = nil, userId: String? = nil, payEmail: String? = nil, address1: String? = nil, address2: String? = nil, city: String? = nil, `default`: Bool? = nil, state: String? = nil, country: String? = nil, zipcode: String? = nil, currency: String? = nil, createdAt: String? = nil, last4Digits: Int? = nil, isVerified: Bool? = nil, status: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "Payout", "id": id, "methodId": methodId, "paymentMethod": paymentMethod.flatMap { (value: PaymentMethod) -> ResultMap in value.resultMap }, "userId": userId, "payEmail": payEmail, "address1": address1, "address2": address2, "city": city, "default": `default`, "state": state, "country": country, "zipcode": zipcode, "currency": currency, "createdAt": createdAt, "last4Digits": last4Digits, "isVerified": isVerified, "status": status])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var methodId: Int? {
          get {
            return resultMap["methodId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "methodId")
          }
        }

        public var paymentMethod: PaymentMethod? {
          get {
            return (resultMap["paymentMethod"] as? ResultMap).flatMap { PaymentMethod(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "paymentMethod")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var payEmail: String? {
          get {
            return resultMap["payEmail"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "payEmail")
          }
        }

        public var address1: String? {
          get {
            return resultMap["address1"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "address1")
          }
        }

        public var address2: String? {
          get {
            return resultMap["address2"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "address2")
          }
        }

        public var city: String? {
          get {
            return resultMap["city"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var `default`: Bool? {
          get {
            return resultMap["default"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "default")
          }
        }

        public var state: String? {
          get {
            return resultMap["state"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var country: String? {
          get {
            return resultMap["country"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "country")
          }
        }

        public var zipcode: String? {
          get {
            return resultMap["zipcode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var last4Digits: Int? {
          get {
            return resultMap["last4Digits"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "last4Digits")
          }
        }

        public var isVerified: Bool? {
          get {
            return resultMap["isVerified"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isVerified")
          }
        }

        public var status: Int? {
          get {
            return resultMap["status"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public struct PaymentMethod: GraphQLSelectionSet {
          public static let possibleTypes = ["PaymentMethods"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PaymentMethods", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}

public final class SetDefaultPayoutMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation setDefaultPayout($id: Int!, $type: String!) {\n  setDefaultPayout(id: $id, type: $type) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var id: Int
  public var type: String

  public init(id: Int, type: String) {
    self.id = id
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["id": id, "type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("setDefaultPayout", arguments: ["id": GraphQLVariable("id"), "type": GraphQLVariable("type")], type: .object(SetDefaultPayout.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(setDefaultPayout: SetDefaultPayout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "setDefaultPayout": setDefaultPayout.flatMap { (value: SetDefaultPayout) -> ResultMap in value.resultMap }])
    }

    public var setDefaultPayout: SetDefaultPayout? {
      get {
        return (resultMap["setDefaultPayout"] as? ResultMap).flatMap { SetDefaultPayout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "setDefaultPayout")
      }
    }

    public struct SetDefaultPayout: GraphQLSelectionSet {
      public static let possibleTypes = ["Payout"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Payout", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class GetPaymentMethodsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getPaymentMethods {\n  getPaymentMethods {\n    __typename\n    results {\n      __typename\n      id\n      name\n      processedIn\n      fees\n      currency\n      details\n      isEnable\n      paymentType\n    }\n    status\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getPaymentMethods", type: .object(GetPaymentMethod.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPaymentMethods: GetPaymentMethod? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getPaymentMethods": getPaymentMethods.flatMap { (value: GetPaymentMethod) -> ResultMap in value.resultMap }])
    }

    public var getPaymentMethods: GetPaymentMethod? {
      get {
        return (resultMap["getPaymentMethods"] as? ResultMap).flatMap { GetPaymentMethod(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getPaymentMethods")
      }
    }

    public struct GetPaymentMethod: GraphQLSelectionSet {
      public static let possibleTypes = ["GetPaymentType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "GetPaymentType", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["PaymentMethods"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("processedIn", type: .scalar(String.self)),
          GraphQLField("fees", type: .scalar(String.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("details", type: .scalar(String.self)),
          GraphQLField("isEnable", type: .scalar(Bool.self)),
          GraphQLField("paymentType", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, name: String? = nil, processedIn: String? = nil, fees: String? = nil, currency: String? = nil, details: String? = nil, isEnable: Bool? = nil, paymentType: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "PaymentMethods", "id": id, "name": name, "processedIn": processedIn, "fees": fees, "currency": currency, "details": details, "isEnable": isEnable, "paymentType": paymentType])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var processedIn: String? {
          get {
            return resultMap["processedIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "processedIn")
          }
        }

        public var fees: String? {
          get {
            return resultMap["fees"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fees")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var details: String? {
          get {
            return resultMap["details"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "details")
          }
        }

        public var isEnable: Bool? {
          get {
            return resultMap["isEnable"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isEnable")
          }
        }

        public var paymentType: Int? {
          get {
            return resultMap["paymentType"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "paymentType")
          }
        }
      }
    }
  }
}

public final class AddPayoutMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation addPayout($methodId: Int!, $payEmail: String!, $address1: String!, $address2: String!, $city: String!, $state: String!, $country: String!, $zipcode: String!, $currency: String!, $firstname: String, $lastname: String, $accountNumber: String, $routingNumber: String, $businessType: String) {\n  addPayout(methodId: $methodId, payEmail: $payEmail, address1: $address1, address2: $address2, city: $city, state: $state, country: $country, zipcode: $zipcode, currency: $currency, firstname: $firstname, lastname: $lastname, accountNumber: $accountNumber, routingNumber: $routingNumber, businessType: $businessType) {\n    __typename\n    status\n    errorMessage\n    connectUrl\n    successUrl\n    failureUrl\n    stripeAccountId\n  }\n}"

  public var methodId: Int
  public var payEmail: String
  public var address1: String
  public var address2: String
  public var city: String
  public var state: String
  public var country: String
  public var zipcode: String
  public var currency: String
  public var firstname: String?
  public var lastname: String?
  public var accountNumber: String?
  public var routingNumber: String?
  public var businessType: String?

  public init(methodId: Int, payEmail: String, address1: String, address2: String, city: String, state: String, country: String, zipcode: String, currency: String, firstname: String? = nil, lastname: String? = nil, accountNumber: String? = nil, routingNumber: String? = nil, businessType: String? = nil) {
    self.methodId = methodId
    self.payEmail = payEmail
    self.address1 = address1
    self.address2 = address2
    self.city = city
    self.state = state
    self.country = country
    self.zipcode = zipcode
    self.currency = currency
    self.firstname = firstname
    self.lastname = lastname
    self.accountNumber = accountNumber
    self.routingNumber = routingNumber
    self.businessType = businessType
  }

  public var variables: GraphQLMap? {
    return ["methodId": methodId, "payEmail": payEmail, "address1": address1, "address2": address2, "city": city, "state": state, "country": country, "zipcode": zipcode, "currency": currency, "firstname": firstname, "lastname": lastname, "accountNumber": accountNumber, "routingNumber": routingNumber, "businessType": businessType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addPayout", arguments: ["methodId": GraphQLVariable("methodId"), "payEmail": GraphQLVariable("payEmail"), "address1": GraphQLVariable("address1"), "address2": GraphQLVariable("address2"), "city": GraphQLVariable("city"), "state": GraphQLVariable("state"), "country": GraphQLVariable("country"), "zipcode": GraphQLVariable("zipcode"), "currency": GraphQLVariable("currency"), "firstname": GraphQLVariable("firstname"), "lastname": GraphQLVariable("lastname"), "accountNumber": GraphQLVariable("accountNumber"), "routingNumber": GraphQLVariable("routingNumber"), "businessType": GraphQLVariable("businessType")], type: .object(AddPayout.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addPayout: AddPayout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addPayout": addPayout.flatMap { (value: AddPayout) -> ResultMap in value.resultMap }])
    }

    public var addPayout: AddPayout? {
      get {
        return (resultMap["addPayout"] as? ResultMap).flatMap { AddPayout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addPayout")
      }
    }

    public struct AddPayout: GraphQLSelectionSet {
      public static let possibleTypes = ["GetPayoutType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("connectUrl", type: .scalar(String.self)),
        GraphQLField("successUrl", type: .scalar(String.self)),
        GraphQLField("failureUrl", type: .scalar(String.self)),
        GraphQLField("stripeAccountId", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, connectUrl: String? = nil, successUrl: String? = nil, failureUrl: String? = nil, stripeAccountId: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "GetPayoutType", "status": status, "errorMessage": errorMessage, "connectUrl": connectUrl, "successUrl": successUrl, "failureUrl": failureUrl, "stripeAccountId": stripeAccountId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var connectUrl: String? {
        get {
          return resultMap["connectUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "connectUrl")
        }
      }

      public var successUrl: String? {
        get {
          return resultMap["successUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "successUrl")
        }
      }

      public var failureUrl: String? {
        get {
          return resultMap["failureUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "failureUrl")
        }
      }

      public var stripeAccountId: String? {
        get {
          return resultMap["stripeAccountId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "stripeAccountId")
        }
      }
    }
  }
}

public final class VerifyPayoutMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation verifyPayout($stripeAccount: String) {\n  verifyPayout(stripeAccount: $stripeAccount) {\n    __typename\n    status\n    connectUrl\n    successUrl\n    failureUrl\n    stripeAccountId\n  }\n}"

  public var stripeAccount: String?

  public init(stripeAccount: String? = nil) {
    self.stripeAccount = stripeAccount
  }

  public var variables: GraphQLMap? {
    return ["stripeAccount": stripeAccount]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("verifyPayout", arguments: ["stripeAccount": GraphQLVariable("stripeAccount")], type: .object(VerifyPayout.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(verifyPayout: VerifyPayout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "verifyPayout": verifyPayout.flatMap { (value: VerifyPayout) -> ResultMap in value.resultMap }])
    }

    public var verifyPayout: VerifyPayout? {
      get {
        return (resultMap["verifyPayout"] as? ResultMap).flatMap { VerifyPayout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "verifyPayout")
      }
    }

    public struct VerifyPayout: GraphQLSelectionSet {
      public static let possibleTypes = ["GetPayoutType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("connectUrl", type: .scalar(String.self)),
        GraphQLField("successUrl", type: .scalar(String.self)),
        GraphQLField("failureUrl", type: .scalar(String.self)),
        GraphQLField("stripeAccountId", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, connectUrl: String? = nil, successUrl: String? = nil, failureUrl: String? = nil, stripeAccountId: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "GetPayoutType", "status": status, "connectUrl": connectUrl, "successUrl": successUrl, "failureUrl": failureUrl, "stripeAccountId": stripeAccountId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var connectUrl: String? {
        get {
          return resultMap["connectUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "connectUrl")
        }
      }

      public var successUrl: String? {
        get {
          return resultMap["successUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "successUrl")
        }
      }

      public var failureUrl: String? {
        get {
          return resultMap["failureUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "failureUrl")
        }
      }

      public var stripeAccountId: String? {
        get {
          return resultMap["stripeAccountId"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "stripeAccountId")
        }
      }
    }
  }
}

public final class ConfirmPayoutMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation confirmPayout($currentAccountId: String) {\n  confirmPayout(currentAccountId: $currentAccountId) {\n    __typename\n    status\n  }\n}"

  public var currentAccountId: String?

  public init(currentAccountId: String? = nil) {
    self.currentAccountId = currentAccountId
  }

  public var variables: GraphQLMap? {
    return ["currentAccountId": currentAccountId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("confirmPayout", arguments: ["currentAccountId": GraphQLVariable("currentAccountId")], type: .object(ConfirmPayout.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(confirmPayout: ConfirmPayout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "confirmPayout": confirmPayout.flatMap { (value: ConfirmPayout) -> ResultMap in value.resultMap }])
    }

    public var confirmPayout: ConfirmPayout? {
      get {
        return (resultMap["confirmPayout"] as? ResultMap).flatMap { ConfirmPayout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "confirmPayout")
      }
    }

    public struct ConfirmPayout: GraphQLSelectionSet {
      public static let possibleTypes = ["PayoutWholeType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "PayoutWholeType", "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}

public final class GetReservationQuery: GraphQLQuery {
  public let operationDefinition =
    "query getReservation($reservationId: Int!, $convertCurrency: String) {\n  getReservation(reservationId: $reservationId, convertCurrency: $convertCurrency) {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      id\n      nights\n      listId\n      hostId\n      guestId\n      checkIn\n      checkOut\n      guests\n      message\n      basePrice\n      cleaningPrice\n      currency\n      discount\n      checkInStart\n      checkInEnd\n      discountType\n      isSpecialPriceAverage\n      guestServiceFee\n      hostServiceFee\n      total\n      totalWithGuestServiceFee\n      confirmationCode\n      paymentState\n      payoutId\n      paymentMethodId\n      reservationState\n      createdAt\n      updatedAt\n      listData {\n        __typename\n        id\n        title\n        street\n        city\n        state\n        country\n        zipcode\n        reviewsCount\n        reviewsStarRating\n        roomType\n        bookingType\n        wishListStatus\n        listPhotoName\n        listPhotos {\n          __typename\n          id\n          name\n        }\n        listingData {\n          __typename\n          checkInStart\n          checkInEnd\n        }\n        settingsData {\n          __typename\n          id\n          listsettings {\n            __typename\n            id\n            itemName\n          }\n        }\n      }\n      messageData {\n        __typename\n        id\n      }\n      hostData {\n        __typename\n        userId\n        profileId\n        displayName\n        picture\n      }\n      guestData {\n        __typename\n        userId\n        profileId\n        displayName\n        picture\n      }\n    }\n    convertedBasePrice\n    convertedHostServiceFee\n    convertedGuestServicefee\n    convertedIsSpecialAverage\n    convertedTotalNightsAmount\n    convertTotalWithGuestServiceFee\n    convertedTotalWithHostServiceFee\n    convertedCleaningPrice\n    convertedDiscount\n  }\n}"

  public var reservationId: Int
  public var convertCurrency: String?

  public init(reservationId: Int, convertCurrency: String? = nil) {
    self.reservationId = reservationId
    self.convertCurrency = convertCurrency
  }

  public var variables: GraphQLMap? {
    return ["reservationId": reservationId, "convertCurrency": convertCurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getReservation", arguments: ["reservationId": GraphQLVariable("reservationId"), "convertCurrency": GraphQLVariable("convertCurrency")], type: .object(GetReservation.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getReservation: GetReservation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getReservation": getReservation.flatMap { (value: GetReservation) -> ResultMap in value.resultMap }])
    }

    public var getReservation: GetReservation? {
      get {
        return (resultMap["getReservation"] as? ResultMap).flatMap { GetReservation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getReservation")
      }
    }

    public struct GetReservation: GraphQLSelectionSet {
      public static let possibleTypes = ["Reservationlist"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("convertedBasePrice", type: .scalar(Double.self)),
        GraphQLField("convertedHostServiceFee", type: .scalar(Double.self)),
        GraphQLField("convertedGuestServicefee", type: .scalar(Double.self)),
        GraphQLField("convertedIsSpecialAverage", type: .scalar(Double.self)),
        GraphQLField("convertedTotalNightsAmount", type: .scalar(Double.self)),
        GraphQLField("convertTotalWithGuestServiceFee", type: .scalar(Double.self)),
        GraphQLField("convertedTotalWithHostServiceFee", type: .scalar(Double.self)),
        GraphQLField("convertedCleaningPrice", type: .scalar(Double.self)),
        GraphQLField("convertedDiscount", type: .scalar(Double.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: Result? = nil, convertedBasePrice: Double? = nil, convertedHostServiceFee: Double? = nil, convertedGuestServicefee: Double? = nil, convertedIsSpecialAverage: Double? = nil, convertedTotalNightsAmount: Double? = nil, convertTotalWithGuestServiceFee: Double? = nil, convertedTotalWithHostServiceFee: Double? = nil, convertedCleaningPrice: Double? = nil, convertedDiscount: Double? = nil) {
        self.init(unsafeResultMap: ["__typename": "Reservationlist", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "convertedBasePrice": convertedBasePrice, "convertedHostServiceFee": convertedHostServiceFee, "convertedGuestServicefee": convertedGuestServicefee, "convertedIsSpecialAverage": convertedIsSpecialAverage, "convertedTotalNightsAmount": convertedTotalNightsAmount, "convertTotalWithGuestServiceFee": convertTotalWithGuestServiceFee, "convertedTotalWithHostServiceFee": convertedTotalWithHostServiceFee, "convertedCleaningPrice": convertedCleaningPrice, "convertedDiscount": convertedDiscount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var convertedBasePrice: Double? {
        get {
          return resultMap["convertedBasePrice"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedBasePrice")
        }
      }

      public var convertedHostServiceFee: Double? {
        get {
          return resultMap["convertedHostServiceFee"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedHostServiceFee")
        }
      }

      public var convertedGuestServicefee: Double? {
        get {
          return resultMap["convertedGuestServicefee"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedGuestServicefee")
        }
      }

      public var convertedIsSpecialAverage: Double? {
        get {
          return resultMap["convertedIsSpecialAverage"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedIsSpecialAverage")
        }
      }

      public var convertedTotalNightsAmount: Double? {
        get {
          return resultMap["convertedTotalNightsAmount"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedTotalNightsAmount")
        }
      }

      public var convertTotalWithGuestServiceFee: Double? {
        get {
          return resultMap["convertTotalWithGuestServiceFee"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertTotalWithGuestServiceFee")
        }
      }

      public var convertedTotalWithHostServiceFee: Double? {
        get {
          return resultMap["convertedTotalWithHostServiceFee"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedTotalWithHostServiceFee")
        }
      }

      public var convertedCleaningPrice: Double? {
        get {
          return resultMap["convertedCleaningPrice"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedCleaningPrice")
        }
      }

      public var convertedDiscount: Double? {
        get {
          return resultMap["convertedDiscount"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "convertedDiscount")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Reservation"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("nights", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("hostId", type: .scalar(String.self)),
          GraphQLField("guestId", type: .scalar(String.self)),
          GraphQLField("checkIn", type: .scalar(String.self)),
          GraphQLField("checkOut", type: .scalar(String.self)),
          GraphQLField("guests", type: .scalar(Int.self)),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("basePrice", type: .scalar(Double.self)),
          GraphQLField("cleaningPrice", type: .scalar(Double.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("discount", type: .scalar(Double.self)),
          GraphQLField("checkInStart", type: .scalar(String.self)),
          GraphQLField("checkInEnd", type: .scalar(String.self)),
          GraphQLField("discountType", type: .scalar(String.self)),
          GraphQLField("isSpecialPriceAverage", type: .scalar(Double.self)),
          GraphQLField("guestServiceFee", type: .scalar(Double.self)),
          GraphQLField("hostServiceFee", type: .scalar(Double.self)),
          GraphQLField("total", type: .scalar(Double.self)),
          GraphQLField("totalWithGuestServiceFee", type: .scalar(Double.self)),
          GraphQLField("confirmationCode", type: .scalar(Int.self)),
          GraphQLField("paymentState", type: .scalar(String.self)),
          GraphQLField("payoutId", type: .scalar(Int.self)),
          GraphQLField("paymentMethodId", type: .scalar(Int.self)),
          GraphQLField("reservationState", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(String.self)),
          GraphQLField("listData", type: .object(ListDatum.selections)),
          GraphQLField("messageData", type: .object(MessageDatum.selections)),
          GraphQLField("hostData", type: .object(HostDatum.selections)),
          GraphQLField("guestData", type: .object(GuestDatum.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, nights: Int? = nil, listId: Int? = nil, hostId: String? = nil, guestId: String? = nil, checkIn: String? = nil, checkOut: String? = nil, guests: Int? = nil, message: String? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, discount: Double? = nil, checkInStart: String? = nil, checkInEnd: String? = nil, discountType: String? = nil, isSpecialPriceAverage: Double? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, total: Double? = nil, totalWithGuestServiceFee: Double? = nil, confirmationCode: Int? = nil, paymentState: String? = nil, payoutId: Int? = nil, paymentMethodId: Int? = nil, reservationState: String? = nil, createdAt: String? = nil, updatedAt: String? = nil, listData: ListDatum? = nil, messageData: MessageDatum? = nil, hostData: HostDatum? = nil, guestData: GuestDatum? = nil) {
          self.init(unsafeResultMap: ["__typename": "Reservation", "id": id, "nights": nights, "listId": listId, "hostId": hostId, "guestId": guestId, "checkIn": checkIn, "checkOut": checkOut, "guests": guests, "message": message, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "discount": discount, "checkInStart": checkInStart, "checkInEnd": checkInEnd, "discountType": discountType, "isSpecialPriceAverage": isSpecialPriceAverage, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "total": total, "totalWithGuestServiceFee": totalWithGuestServiceFee, "confirmationCode": confirmationCode, "paymentState": paymentState, "payoutId": payoutId, "paymentMethodId": paymentMethodId, "reservationState": reservationState, "createdAt": createdAt, "updatedAt": updatedAt, "listData": listData.flatMap { (value: ListDatum) -> ResultMap in value.resultMap }, "messageData": messageData.flatMap { (value: MessageDatum) -> ResultMap in value.resultMap }, "hostData": hostData.flatMap { (value: HostDatum) -> ResultMap in value.resultMap }, "guestData": guestData.flatMap { (value: GuestDatum) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var nights: Int? {
          get {
            return resultMap["nights"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "nights")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var hostId: String? {
          get {
            return resultMap["hostId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostId")
          }
        }

        public var guestId: String? {
          get {
            return resultMap["guestId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestId")
          }
        }

        public var checkIn: String? {
          get {
            return resultMap["checkIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkIn")
          }
        }

        public var checkOut: String? {
          get {
            return resultMap["checkOut"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkOut")
          }
        }

        public var guests: Int? {
          get {
            return resultMap["guests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "guests")
          }
        }

        public var message: String? {
          get {
            return resultMap["message"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var basePrice: Double? {
          get {
            return resultMap["basePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "basePrice")
          }
        }

        public var cleaningPrice: Double? {
          get {
            return resultMap["cleaningPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "cleaningPrice")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var discount: Double? {
          get {
            return resultMap["discount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "discount")
          }
        }

        public var checkInStart: String? {
          get {
            return resultMap["checkInStart"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkInStart")
          }
        }

        public var checkInEnd: String? {
          get {
            return resultMap["checkInEnd"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkInEnd")
          }
        }

        public var discountType: String? {
          get {
            return resultMap["discountType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "discountType")
          }
        }

        public var isSpecialPriceAverage: Double? {
          get {
            return resultMap["isSpecialPriceAverage"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "isSpecialPriceAverage")
          }
        }

        public var guestServiceFee: Double? {
          get {
            return resultMap["guestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFee")
          }
        }

        public var hostServiceFee: Double? {
          get {
            return resultMap["hostServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFee")
          }
        }

        public var total: Double? {
          get {
            return resultMap["total"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "total")
          }
        }

        public var totalWithGuestServiceFee: Double? {
          get {
            return resultMap["totalWithGuestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalWithGuestServiceFee")
          }
        }

        public var confirmationCode: Int? {
          get {
            return resultMap["confirmationCode"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "confirmationCode")
          }
        }

        public var paymentState: String? {
          get {
            return resultMap["paymentState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "paymentState")
          }
        }

        public var payoutId: Int? {
          get {
            return resultMap["payoutId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "payoutId")
          }
        }

        public var paymentMethodId: Int? {
          get {
            return resultMap["paymentMethodId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "paymentMethodId")
          }
        }

        public var reservationState: String? {
          get {
            return resultMap["reservationState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationState")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String? {
          get {
            return resultMap["updatedAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var listData: ListDatum? {
          get {
            return (resultMap["listData"] as? ResultMap).flatMap { ListDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listData")
          }
        }

        public var messageData: MessageDatum? {
          get {
            return (resultMap["messageData"] as? ResultMap).flatMap { MessageDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "messageData")
          }
        }

        public var hostData: HostDatum? {
          get {
            return (resultMap["hostData"] as? ResultMap).flatMap { HostDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "hostData")
          }
        }

        public var guestData: GuestDatum? {
          get {
            return (resultMap["guestData"] as? ResultMap).flatMap { GuestDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "guestData")
          }
        }

        public struct ListDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["ShowListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("street", type: .scalar(String.self)),
            GraphQLField("city", type: .scalar(String.self)),
            GraphQLField("state", type: .scalar(String.self)),
            GraphQLField("country", type: .scalar(String.self)),
            GraphQLField("zipcode", type: .scalar(String.self)),
            GraphQLField("reviewsCount", type: .scalar(Int.self)),
            GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
            GraphQLField("roomType", type: .scalar(String.self)),
            GraphQLField("bookingType", type: .scalar(String.self)),
            GraphQLField("wishListStatus", type: .scalar(Bool.self)),
            GraphQLField("listPhotoName", type: .scalar(String.self)),
            GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
            GraphQLField("listingData", type: .object(ListingDatum.selections)),
            GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, title: String? = nil, street: String? = nil, city: String? = nil, state: String? = nil, country: String? = nil, zipcode: String? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, roomType: String? = nil, bookingType: String? = nil, wishListStatus: Bool? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "street": street, "city": city, "state": state, "country": country, "zipcode": zipcode, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "roomType": roomType, "bookingType": bookingType, "wishListStatus": wishListStatus, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var street: String? {
            get {
              return resultMap["street"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "street")
            }
          }

          public var city: String? {
            get {
              return resultMap["city"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var state: String? {
            get {
              return resultMap["state"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var country: String? {
            get {
              return resultMap["country"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "country")
            }
          }

          public var zipcode: String? {
            get {
              return resultMap["zipcode"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var reviewsCount: Int? {
            get {
              return resultMap["reviewsCount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsCount")
            }
          }

          public var reviewsStarRating: Int? {
            get {
              return resultMap["reviewsStarRating"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsStarRating")
            }
          }

          public var roomType: String? {
            get {
              return resultMap["roomType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "roomType")
            }
          }

          public var bookingType: String? {
            get {
              return resultMap["bookingType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "bookingType")
            }
          }

          public var wishListStatus: Bool? {
            get {
              return resultMap["wishListStatus"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "wishListStatus")
            }
          }

          public var listPhotoName: String? {
            get {
              return resultMap["listPhotoName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "listPhotoName")
            }
          }

          public var listPhotos: [ListPhoto?]? {
            get {
              return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
            }
          }

          public var listingData: ListingDatum? {
            get {
              return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
            }
          }

          public var settingsData: [SettingsDatum?]? {
            get {
              return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
            }
          }

          public struct ListPhoto: GraphQLSelectionSet {
            public static let possibleTypes = ["listPhotosData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct ListingDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["listingData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("checkInStart", type: .scalar(String.self)),
              GraphQLField("checkInEnd", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(checkInStart: String? = nil, checkInEnd: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingData", "checkInStart": checkInStart, "checkInEnd": checkInEnd])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var checkInStart: String? {
              get {
                return resultMap["checkInStart"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "checkInStart")
              }
            }

            public var checkInEnd: String? {
              get {
                return resultMap["checkInEnd"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "checkInEnd")
              }
            }
          }

          public struct SettingsDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["userListingData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("listsettings", type: .object(Listsetting.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, listsettings: Listsetting? = nil) {
              self.init(unsafeResultMap: ["__typename": "userListingData", "id": id, "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var listsettings: Listsetting? {
              get {
                return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
              }
            }

            public struct Listsetting: GraphQLSelectionSet {
              public static let possibleTypes = ["singleListSettings"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .scalar(Int.self)),
                GraphQLField("itemName", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: Int? = nil, itemName: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: Int? {
                get {
                  return resultMap["id"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var itemName: String? {
                get {
                  return resultMap["itemName"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "itemName")
                }
              }
            }
          }
        }

        public struct MessageDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["Threads"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Threads", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }

        public struct HostDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userId: String? = nil, profileId: Int? = nil, displayName: String? = nil, picture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "userId": userId, "profileId": profileId, "displayName": displayName, "picture": picture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }
        }

        public struct GuestDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userId: String? = nil, profileId: Int? = nil, displayName: String? = nil, picture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "userId": userId, "profileId": profileId, "displayName": displayName, "picture": picture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }
        }
      }
    }
  }
}

public final class GetAllThreadsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getAllThreads($threadType: String, $threadId: Int, $currentPage: Int) {\n  getAllThreads(threadType: $threadType, threadId: $threadId, currentPage: $currentPage) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      guest\n      host\n      listData {\n        __typename\n        city\n        state\n        country\n      }\n      threadItem {\n        __typename\n        id\n        threadId\n        content\n        sentBy\n        isRead\n        type\n        startDate\n        endDate\n        createdAt\n      }\n      guestProfile {\n        __typename\n        profileId\n        displayName\n        picture\n      }\n      hostProfile {\n        __typename\n        profileId\n        displayName\n        picture\n      }\n    }\n    count\n    status\n  }\n}"

  public var threadType: String?
  public var threadId: Int?
  public var currentPage: Int?

  public init(threadType: String? = nil, threadId: Int? = nil, currentPage: Int? = nil) {
    self.threadType = threadType
    self.threadId = threadId
    self.currentPage = currentPage
  }

  public var variables: GraphQLMap? {
    return ["threadType": threadType, "threadId": threadId, "currentPage": currentPage]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getAllThreads", arguments: ["threadType": GraphQLVariable("threadType"), "threadId": GraphQLVariable("threadId"), "currentPage": GraphQLVariable("currentPage")], type: .object(GetAllThread.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAllThreads: GetAllThread? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAllThreads": getAllThreads.flatMap { (value: GetAllThread) -> ResultMap in value.resultMap }])
    }

    public var getAllThreads: GetAllThread? {
      get {
        return (resultMap["getAllThreads"] as? ResultMap).flatMap { GetAllThread(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getAllThreads")
      }
    }

    public struct GetAllThread: GraphQLSelectionSet {
      public static let possibleTypes = ["AllThreads"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("count", type: .scalar(Int.self)),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, count: Int? = nil, status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllThreads", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "count": count, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Threads"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("guest", type: .scalar(String.self)),
          GraphQLField("host", type: .scalar(String.self)),
          GraphQLField("listData", type: .object(ListDatum.selections)),
          GraphQLField("threadItem", type: .object(ThreadItem.selections)),
          GraphQLField("guestProfile", type: .object(GuestProfile.selections)),
          GraphQLField("hostProfile", type: .object(HostProfile.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, guest: String? = nil, host: String? = nil, listData: ListDatum? = nil, threadItem: ThreadItem? = nil, guestProfile: GuestProfile? = nil, hostProfile: HostProfile? = nil) {
          self.init(unsafeResultMap: ["__typename": "Threads", "id": id, "listId": listId, "guest": guest, "host": host, "listData": listData.flatMap { (value: ListDatum) -> ResultMap in value.resultMap }, "threadItem": threadItem.flatMap { (value: ThreadItem) -> ResultMap in value.resultMap }, "guestProfile": guestProfile.flatMap { (value: GuestProfile) -> ResultMap in value.resultMap }, "hostProfile": hostProfile.flatMap { (value: HostProfile) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var guest: String? {
          get {
            return resultMap["guest"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guest")
          }
        }

        public var host: String? {
          get {
            return resultMap["host"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "host")
          }
        }

        public var listData: ListDatum? {
          get {
            return (resultMap["listData"] as? ResultMap).flatMap { ListDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listData")
          }
        }

        public var threadItem: ThreadItem? {
          get {
            return (resultMap["threadItem"] as? ResultMap).flatMap { ThreadItem(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "threadItem")
          }
        }

        public var guestProfile: GuestProfile? {
          get {
            return (resultMap["guestProfile"] as? ResultMap).flatMap { GuestProfile(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "guestProfile")
          }
        }

        public var hostProfile: HostProfile? {
          get {
            return (resultMap["hostProfile"] as? ResultMap).flatMap { HostProfile(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "hostProfile")
          }
        }

        public struct ListDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["ShowListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("city", type: .scalar(String.self)),
            GraphQLField("state", type: .scalar(String.self)),
            GraphQLField("country", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(city: String? = nil, state: String? = nil, country: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "ShowListing", "city": city, "state": state, "country": country])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var city: String? {
            get {
              return resultMap["city"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var state: String? {
            get {
              return resultMap["state"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var country: String? {
            get {
              return resultMap["country"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "country")
            }
          }
        }

        public struct ThreadItem: GraphQLSelectionSet {
          public static let possibleTypes = ["ThreadItems"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("threadId", type: .scalar(Int.self)),
            GraphQLField("content", type: .scalar(String.self)),
            GraphQLField("sentBy", type: .scalar(String.self)),
            GraphQLField("isRead", type: .scalar(Bool.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("startDate", type: .scalar(String.self)),
            GraphQLField("endDate", type: .scalar(String.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, threadId: Int? = nil, content: String? = nil, sentBy: String? = nil, isRead: Bool? = nil, type: String? = nil, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "ThreadItems", "id": id, "threadId": threadId, "content": content, "sentBy": sentBy, "isRead": isRead, "type": type, "startDate": startDate, "endDate": endDate, "createdAt": createdAt])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var threadId: Int? {
            get {
              return resultMap["threadId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "threadId")
            }
          }

          public var content: String? {
            get {
              return resultMap["content"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "content")
            }
          }

          public var sentBy: String? {
            get {
              return resultMap["sentBy"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "sentBy")
            }
          }

          public var isRead: Bool? {
            get {
              return resultMap["isRead"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isRead")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var startDate: String? {
            get {
              return resultMap["startDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "startDate")
            }
          }

          public var endDate: String? {
            get {
              return resultMap["endDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endDate")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }
        }

        public struct GuestProfile: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(profileId: Int? = nil, displayName: String? = nil, picture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "displayName": displayName, "picture": picture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }
        }

        public struct HostProfile: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(profileId: Int? = nil, displayName: String? = nil, picture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "displayName": displayName, "picture": picture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }
        }
      }
    }
  }
}

public final class GetThreadsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getThreads($threadType: String, $threadId: Int, $currentPage: Int, $sortOrder: Boolean) {\n  getThreads(threadType: $threadType, threadId: $threadId, currentPage: $currentPage, sortOrder: $sortOrder) {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      getThreadCount\n      threadItems {\n        __typename\n        id\n        threadId\n        reservationId\n        content\n        sentBy\n        type\n        startDate\n        endDate\n        createdAt\n        personCapacity\n      }\n      guestProfile {\n        __typename\n        userId\n        profileId\n        displayName\n        firstName\n        picture\n        location\n      }\n      hostProfile {\n        __typename\n        userId\n        profileId\n        displayName\n        firstName\n        picture\n        location\n      }\n    }\n  }\n}"

  public var threadType: String?
  public var threadId: Int?
  public var currentPage: Int?
  public var sortOrder: Bool?

  public init(threadType: String? = nil, threadId: Int? = nil, currentPage: Int? = nil, sortOrder: Bool? = nil) {
    self.threadType = threadType
    self.threadId = threadId
    self.currentPage = currentPage
    self.sortOrder = sortOrder
  }

  public var variables: GraphQLMap? {
    return ["threadType": threadType, "threadId": threadId, "currentPage": currentPage, "sortOrder": sortOrder]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getThreads", arguments: ["threadType": GraphQLVariable("threadType"), "threadId": GraphQLVariable("threadId"), "currentPage": GraphQLVariable("currentPage"), "sortOrder": GraphQLVariable("sortOrder")], type: .object(GetThread.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getThreads: GetThread? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getThreads": getThreads.flatMap { (value: GetThread) -> ResultMap in value.resultMap }])
    }

    public var getThreads: GetThread? {
      get {
        return (resultMap["getThreads"] as? ResultMap).flatMap { GetThread(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getThreads")
      }
    }

    public struct GetThread: GraphQLSelectionSet {
      public static let possibleTypes = ["NewThreadsCommonType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .object(Result.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: Result? = nil) {
        self.init(unsafeResultMap: ["__typename": "NewThreadsCommonType", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["NewThreadsType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("getThreadCount", type: .scalar(Int.self)),
          GraphQLField("threadItems", type: .list(.object(ThreadItem.selections))),
          GraphQLField("guestProfile", type: .object(GuestProfile.selections)),
          GraphQLField("hostProfile", type: .object(HostProfile.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(getThreadCount: Int? = nil, threadItems: [ThreadItem?]? = nil, guestProfile: GuestProfile? = nil, hostProfile: HostProfile? = nil) {
          self.init(unsafeResultMap: ["__typename": "NewThreadsType", "getThreadCount": getThreadCount, "threadItems": threadItems.flatMap { (value: [ThreadItem?]) -> [ResultMap?] in value.map { (value: ThreadItem?) -> ResultMap? in value.flatMap { (value: ThreadItem) -> ResultMap in value.resultMap } } }, "guestProfile": guestProfile.flatMap { (value: GuestProfile) -> ResultMap in value.resultMap }, "hostProfile": hostProfile.flatMap { (value: HostProfile) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var getThreadCount: Int? {
          get {
            return resultMap["getThreadCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "getThreadCount")
          }
        }

        public var threadItems: [ThreadItem?]? {
          get {
            return (resultMap["threadItems"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ThreadItem?] in value.map { (value: ResultMap?) -> ThreadItem? in value.flatMap { (value: ResultMap) -> ThreadItem in ThreadItem(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ThreadItem?]) -> [ResultMap?] in value.map { (value: ThreadItem?) -> ResultMap? in value.flatMap { (value: ThreadItem) -> ResultMap in value.resultMap } } }, forKey: "threadItems")
          }
        }

        public var guestProfile: GuestProfile? {
          get {
            return (resultMap["guestProfile"] as? ResultMap).flatMap { GuestProfile(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "guestProfile")
          }
        }

        public var hostProfile: HostProfile? {
          get {
            return (resultMap["hostProfile"] as? ResultMap).flatMap { HostProfile(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "hostProfile")
          }
        }

        public struct ThreadItem: GraphQLSelectionSet {
          public static let possibleTypes = ["ThreadItems"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("threadId", type: .scalar(Int.self)),
            GraphQLField("reservationId", type: .scalar(Int.self)),
            GraphQLField("content", type: .scalar(String.self)),
            GraphQLField("sentBy", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("startDate", type: .scalar(String.self)),
            GraphQLField("endDate", type: .scalar(String.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
            GraphQLField("personCapacity", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, threadId: Int? = nil, reservationId: Int? = nil, content: String? = nil, sentBy: String? = nil, type: String? = nil, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil, personCapacity: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "ThreadItems", "id": id, "threadId": threadId, "reservationId": reservationId, "content": content, "sentBy": sentBy, "type": type, "startDate": startDate, "endDate": endDate, "createdAt": createdAt, "personCapacity": personCapacity])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var threadId: Int? {
            get {
              return resultMap["threadId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "threadId")
            }
          }

          public var reservationId: Int? {
            get {
              return resultMap["reservationId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reservationId")
            }
          }

          public var content: String? {
            get {
              return resultMap["content"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "content")
            }
          }

          public var sentBy: String? {
            get {
              return resultMap["sentBy"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "sentBy")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var startDate: String? {
            get {
              return resultMap["startDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "startDate")
            }
          }

          public var endDate: String? {
            get {
              return resultMap["endDate"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endDate")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          public var personCapacity: Int? {
            get {
              return resultMap["personCapacity"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "personCapacity")
            }
          }
        }

        public struct GuestProfile: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("location", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userId: String? = nil, profileId: Int? = nil, displayName: String? = nil, firstName: String? = nil, picture: String? = nil, location: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "userId": userId, "profileId": profileId, "displayName": displayName, "firstName": firstName, "picture": picture, "location": location])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var location: String? {
            get {
              return resultMap["location"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "location")
            }
          }
        }

        public struct HostProfile: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("location", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userId: String? = nil, profileId: Int? = nil, displayName: String? = nil, firstName: String? = nil, picture: String? = nil, location: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "userId": userId, "profileId": profileId, "displayName": displayName, "firstName": firstName, "picture": picture, "location": location])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var location: String? {
            get {
              return resultMap["location"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "location")
            }
          }
        }
      }
    }
  }
}

public final class SendMessageMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation sendMessage($threadId: Int!, $content: String, $type: String) {\n  sendMessage(threadId: $threadId, content: $content, type: $type) {\n    __typename\n    results {\n      __typename\n      id\n      sentBy\n      content\n      type\n      reservationId\n      startDate\n      endDate\n      createdAt\n    }\n    status\n    errorMessage\n  }\n}"

  public var threadId: Int
  public var content: String?
  public var type: String?

  public init(threadId: Int, content: String? = nil, type: String? = nil) {
    self.threadId = threadId
    self.content = content
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["threadId": threadId, "content": content, "type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("sendMessage", arguments: ["threadId": GraphQLVariable("threadId"), "content": GraphQLVariable("content"), "type": GraphQLVariable("type")], type: .object(SendMessage.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(sendMessage: SendMessage? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "sendMessage": sendMessage.flatMap { (value: SendMessage) -> ResultMap in value.resultMap }])
    }

    public var sendMessage: SendMessage? {
      get {
        return (resultMap["sendMessage"] as? ResultMap).flatMap { SendMessage(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "sendMessage")
      }
    }

    public struct SendMessage: GraphQLSelectionSet {
      public static let possibleTypes = ["SendMessage"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SendMessage", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ThreadItems"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("sentBy", type: .scalar(String.self)),
          GraphQLField("content", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(String.self)),
          GraphQLField("reservationId", type: .scalar(Int.self)),
          GraphQLField("startDate", type: .scalar(String.self)),
          GraphQLField("endDate", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, sentBy: String? = nil, content: String? = nil, type: String? = nil, reservationId: Int? = nil, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ThreadItems", "id": id, "sentBy": sentBy, "content": content, "type": type, "reservationId": reservationId, "startDate": startDate, "endDate": endDate, "createdAt": createdAt])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var sentBy: String? {
          get {
            return resultMap["sentBy"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "sentBy")
          }
        }

        public var content: String? {
          get {
            return resultMap["content"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "content")
          }
        }

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var reservationId: Int? {
          get {
            return resultMap["reservationId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationId")
          }
        }

        public var startDate: String? {
          get {
            return resultMap["startDate"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "startDate")
          }
        }

        public var endDate: String? {
          get {
            return resultMap["endDate"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endDate")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }
      }
    }
  }
}

public final class ReadMessageMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation readMessage($threadId: Int!) {\n  readMessage(threadId: $threadId) {\n    __typename\n    status\n    message\n    errorMessage\n  }\n}"

  public var threadId: Int

  public init(threadId: Int) {
    self.threadId = threadId
  }

  public var variables: GraphQLMap? {
    return ["threadId": threadId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("readMessage", arguments: ["threadId": GraphQLVariable("threadId")], type: .object(ReadMessage.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(readMessage: ReadMessage? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "readMessage": readMessage.flatMap { (value: ReadMessage) -> ResultMap in value.resultMap }])
    }

    public var readMessage: ReadMessage? {
      get {
        return (resultMap["readMessage"] as? ResultMap).flatMap { ReadMessage(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "readMessage")
      }
    }

    public struct ReadMessage: GraphQLSelectionSet {
      public static let possibleTypes = ["SendMessage"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("message", type: .scalar(String.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, message: String? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SendMessage", "status": status, "message": message, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class GetUnReadThreadCountQuery: GraphQLQuery {
  public let operationDefinition =
    "query getUnReadThreadCount($threadId: Int) {\n  getUnReadThreadCount(threadId: $threadId) {\n    __typename\n    results {\n      __typename\n      isUnReadMessage\n      messageCount\n    }\n    status\n    errorMessage\n  }\n}"

  public var threadId: Int?

  public init(threadId: Int? = nil) {
    self.threadId = threadId
  }

  public var variables: GraphQLMap? {
    return ["threadId": threadId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getUnReadThreadCount", arguments: ["threadId": GraphQLVariable("threadId")], type: .object(GetUnReadThreadCount.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getUnReadThreadCount: GetUnReadThreadCount? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getUnReadThreadCount": getUnReadThreadCount.flatMap { (value: GetUnReadThreadCount) -> ResultMap in value.resultMap }])
    }

    public var getUnReadThreadCount: GetUnReadThreadCount? {
      get {
        return (resultMap["getUnReadThreadCount"] as? ResultMap).flatMap { GetUnReadThreadCount(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getUnReadThreadCount")
      }
    }

    public struct GetUnReadThreadCount: GraphQLSelectionSet {
      public static let possibleTypes = ["UnreadThreadsCount"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UnreadThreadsCount", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["UnReadCount"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("isUnReadMessage", type: .scalar(Bool.self)),
          GraphQLField("messageCount", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isUnReadMessage: Bool? = nil, messageCount: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "UnReadCount", "isUnReadMessage": isUnReadMessage, "messageCount": messageCount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isUnReadMessage: Bool? {
          get {
            return resultMap["isUnReadMessage"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isUnReadMessage")
          }
        }

        public var messageCount: Int? {
          get {
            return resultMap["messageCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "messageCount")
          }
        }
      }
    }
  }
}

public final class ResetPasswordMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation resetPassword($email: String!, $password: String!, $token: String!) {\n  updateForgotPassword(email: $email, password: $password, token: $token) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var email: String
  public var password: String
  public var token: String

  public init(email: String, password: String, token: String) {
    self.email = email
    self.password = password
    self.token = token
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password, "token": token]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateForgotPassword", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "token": GraphQLVariable("token")], type: .object(UpdateForgotPassword.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateForgotPassword: UpdateForgotPassword? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateForgotPassword": updateForgotPassword.flatMap { (value: UpdateForgotPassword) -> ResultMap in value.resultMap }])
    }

    public var updateForgotPassword: UpdateForgotPassword? {
      get {
        return (resultMap["updateForgotPassword"] as? ResultMap).flatMap { UpdateForgotPassword(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateForgotPassword")
      }
    }

    public struct UpdateForgotPassword: GraphQLSelectionSet {
      public static let possibleTypes = ["UserType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class LoginQuery: GraphQLQuery {
  public let operationDefinition =
    "query Login($email: String!, $password: String!, $deviceType: String!, $deviceDetail: String, $deviceId: String!) {\n  userLogin(email: $email, password: $password, deviceType: $deviceType, deviceDetail: $deviceDetail, deviceId: $deviceId) {\n    __typename\n    result {\n      __typename\n      userId\n      userToken\n      user {\n        __typename\n        firstName\n        lastName\n        gender\n        dateOfBirth\n        phoneNumber\n        preferredLanguage\n        preferredCurrency\n        createdAt\n        picture\n        verification {\n          __typename\n          id\n          isPhoneVerified\n          isEmailConfirmed\n          isIdVerification\n          isGoogleConnected\n          isFacebookConnected\n        }\n        userData {\n          __typename\n          type\n        }\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var email: String
  public var password: String
  public var deviceType: String
  public var deviceDetail: String?
  public var deviceId: String

  public init(email: String, password: String, deviceType: String, deviceDetail: String? = nil, deviceId: String) {
    self.email = email
    self.password = password
    self.deviceType = deviceType
    self.deviceDetail = deviceDetail
    self.deviceId = deviceId
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password, "deviceType": deviceType, "deviceDetail": deviceDetail, "deviceId": deviceId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userLogin", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "deviceType": GraphQLVariable("deviceType"), "deviceDetail": GraphQLVariable("deviceDetail"), "deviceId": GraphQLVariable("deviceId")], type: .object(UserLogin.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userLogin: UserLogin? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "userLogin": userLogin.flatMap { (value: UserLogin) -> ResultMap in value.resultMap }])
    }

    public var userLogin: UserLogin? {
      get {
        return (resultMap["userLogin"] as? ResultMap).flatMap { UserLogin(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userLogin")
      }
    }

    public struct UserLogin: GraphQLSelectionSet {
      public static let possibleTypes = ["UserCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserCommon", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["UserType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("userToken", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: String? = nil, userToken: String? = nil, user: User? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserType", "userId": userId, "userToken": userToken, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var userToken: String? {
          get {
            return resultMap["userToken"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userToken")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["userEditProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("gender", type: .scalar(String.self)),
            GraphQLField("dateOfBirth", type: .scalar(String.self)),
            GraphQLField("phoneNumber", type: .scalar(String.self)),
            GraphQLField("preferredLanguage", type: .scalar(String.self)),
            GraphQLField("preferredCurrency", type: .scalar(String.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("verification", type: .object(Verification.selections)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(firstName: String? = nil, lastName: String? = nil, gender: String? = nil, dateOfBirth: String? = nil, phoneNumber: String? = nil, preferredLanguage: String? = nil, preferredCurrency: String? = nil, createdAt: String? = nil, picture: String? = nil, verification: Verification? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "userEditProfile", "firstName": firstName, "lastName": lastName, "gender": gender, "dateOfBirth": dateOfBirth, "phoneNumber": phoneNumber, "preferredLanguage": preferredLanguage, "preferredCurrency": preferredCurrency, "createdAt": createdAt, "picture": picture, "verification": verification.flatMap { (value: Verification) -> ResultMap in value.resultMap }, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var gender: String? {
            get {
              return resultMap["gender"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "gender")
            }
          }

          public var dateOfBirth: String? {
            get {
              return resultMap["dateOfBirth"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "dateOfBirth")
            }
          }

          public var phoneNumber: String? {
            get {
              return resultMap["phoneNumber"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "phoneNumber")
            }
          }

          public var preferredLanguage: String? {
            get {
              return resultMap["preferredLanguage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "preferredLanguage")
            }
          }

          public var preferredCurrency: String? {
            get {
              return resultMap["preferredCurrency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "preferredCurrency")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var verification: Verification? {
            get {
              return (resultMap["verification"] as? ResultMap).flatMap { Verification(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "verification")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct Verification: GraphQLSelectionSet {
            public static let possibleTypes = ["UserVerifiedInfo"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("isPhoneVerified", type: .scalar(Bool.self)),
              GraphQLField("isEmailConfirmed", type: .scalar(Bool.self)),
              GraphQLField("isIdVerification", type: .scalar(Bool.self)),
              GraphQLField("isGoogleConnected", type: .scalar(Bool.self)),
              GraphQLField("isFacebookConnected", type: .scalar(Bool.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, isPhoneVerified: Bool? = nil, isEmailConfirmed: Bool? = nil, isIdVerification: Bool? = nil, isGoogleConnected: Bool? = nil, isFacebookConnected: Bool? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserVerifiedInfo", "id": id, "isPhoneVerified": isPhoneVerified, "isEmailConfirmed": isEmailConfirmed, "isIdVerification": isIdVerification, "isGoogleConnected": isGoogleConnected, "isFacebookConnected": isFacebookConnected])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var isPhoneVerified: Bool? {
              get {
                return resultMap["isPhoneVerified"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isPhoneVerified")
              }
            }

            public var isEmailConfirmed: Bool? {
              get {
                return resultMap["isEmailConfirmed"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEmailConfirmed")
              }
            }

            public var isIdVerification: Bool? {
              get {
                return resultMap["isIdVerification"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isIdVerification")
              }
            }

            public var isGoogleConnected: Bool? {
              get {
                return resultMap["isGoogleConnected"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isGoogleConnected")
              }
            }

            public var isFacebookConnected: Bool? {
              get {
                return resultMap["isFacebookConnected"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isFacebookConnected")
              }
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["UserProfile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(type: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserProfile", "type": type])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var type: String? {
              get {
                return resultMap["type"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "type")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetDefaultSettingQuery: GraphQLQuery {
  public let operationDefinition =
    "query getDefaultSetting {\n  getMostViewedListing {\n    __typename\n    results {\n      __typename\n      id\n      title\n      personCapacity\n      beds\n      bookingType\n      coverPhoto\n      reviewsCount\n      reviewsStarRating\n      listPhotos {\n        __typename\n        id\n        name\n        type\n        status\n      }\n      listingData {\n        __typename\n        basePrice\n        currency\n      }\n      settingsData {\n        __typename\n        listsettings {\n          __typename\n          id\n          itemName\n        }\n      }\n      wishListStatus\n      isListOwner\n      listPhotoName\n      roomType\n      popularLocationListing {\n        __typename\n        id\n        location\n        locationAddress\n        image\n        isEnable\n        createdAt\n        updatedAt\n      }\n    }\n    status\n  }\n  getRecommend {\n    __typename\n    results {\n      __typename\n      id\n      title\n      personCapacity\n      beds\n      bookingType\n      coverPhoto\n      reviewsCount\n      reviewsStarRating\n      listPhotos {\n        __typename\n        id\n        name\n        type\n        status\n      }\n      listingData {\n        __typename\n        basePrice\n        currency\n      }\n      settingsData {\n        __typename\n        listsettings {\n          __typename\n          id\n          itemName\n        }\n      }\n      wishListStatus\n      isListOwner\n      listPhotoName\n      roomType\n    }\n    status\n  }\n  Currency {\n    __typename\n    result {\n      __typename\n      base\n      rates\n    }\n    status\n    errorMessage\n  }\n  getSearchSettings {\n    __typename\n    results {\n      __typename\n      id\n      minPrice\n      maxPrice\n      priceRangeCurrency\n    }\n    status\n    errorMessage\n  }\n  getListingSettingsCommon {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      id\n      typeName\n      fieldType\n      typeLabel\n      step\n      isEnable\n      listSettings {\n        __typename\n        id\n        typeId\n        itemName\n        otherItemName\n        maximum\n        minimum\n        startValue\n        endValue\n        isEnable\n      }\n    }\n  }\n  siteSettings {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      id\n      title\n      name\n      value\n      type\n      status\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getMostViewedListing", type: .object(GetMostViewedListing.selections)),
      GraphQLField("getRecommend", type: .object(GetRecommend.selections)),
      GraphQLField("Currency", type: .object(Currency.selections)),
      GraphQLField("getSearchSettings", type: .object(GetSearchSetting.selections)),
      GraphQLField("getListingSettingsCommon", type: .object(GetListingSettingsCommon.selections)),
      GraphQLField("siteSettings", type: .object(SiteSetting.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMostViewedListing: GetMostViewedListing? = nil, getRecommend: GetRecommend? = nil, currency: Currency? = nil, getSearchSettings: GetSearchSetting? = nil, getListingSettingsCommon: GetListingSettingsCommon? = nil, siteSettings: SiteSetting? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getMostViewedListing": getMostViewedListing.flatMap { (value: GetMostViewedListing) -> ResultMap in value.resultMap }, "getRecommend": getRecommend.flatMap { (value: GetRecommend) -> ResultMap in value.resultMap }, "Currency": currency.flatMap { (value: Currency) -> ResultMap in value.resultMap }, "getSearchSettings": getSearchSettings.flatMap { (value: GetSearchSetting) -> ResultMap in value.resultMap }, "getListingSettingsCommon": getListingSettingsCommon.flatMap { (value: GetListingSettingsCommon) -> ResultMap in value.resultMap }, "siteSettings": siteSettings.flatMap { (value: SiteSetting) -> ResultMap in value.resultMap }])
    }

    public var getMostViewedListing: GetMostViewedListing? {
      get {
        return (resultMap["getMostViewedListing"] as? ResultMap).flatMap { GetMostViewedListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getMostViewedListing")
      }
    }

    public var getRecommend: GetRecommend? {
      get {
        return (resultMap["getRecommend"] as? ResultMap).flatMap { GetRecommend(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getRecommend")
      }
    }

    public var currency: Currency? {
      get {
        return (resultMap["Currency"] as? ResultMap).flatMap { Currency(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Currency")
      }
    }

    public var getSearchSettings: GetSearchSetting? {
      get {
        return (resultMap["getSearchSettings"] as? ResultMap).flatMap { GetSearchSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getSearchSettings")
      }
    }

    public var getListingSettingsCommon: GetListingSettingsCommon? {
      get {
        return (resultMap["getListingSettingsCommon"] as? ResultMap).flatMap { GetListingSettingsCommon(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getListingSettingsCommon")
      }
    }

    public var siteSettings: SiteSetting? {
      get {
        return (resultMap["siteSettings"] as? ResultMap).flatMap { SiteSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "siteSettings")
      }
    }

    public struct GetMostViewedListing: GraphQLSelectionSet {
      public static let possibleTypes = ["AllList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllList", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("bookingType", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
          GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
          GraphQLField("listingData", type: .object(ListingDatum.selections)),
          GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          GraphQLField("wishListStatus", type: .scalar(Bool.self)),
          GraphQLField("isListOwner", type: .scalar(Bool.self)),
          GraphQLField("listPhotoName", type: .scalar(String.self)),
          GraphQLField("roomType", type: .scalar(String.self)),
          GraphQLField("popularLocationListing", type: .list(.object(PopularLocationListing.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, personCapacity: Int? = nil, beds: Int? = nil, bookingType: String? = nil, coverPhoto: Int? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil, wishListStatus: Bool? = nil, isListOwner: Bool? = nil, listPhotoName: String? = nil, roomType: String? = nil, popularLocationListing: [PopularLocationListing?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "personCapacity": personCapacity, "beds": beds, "bookingType": bookingType, "coverPhoto": coverPhoto, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, "wishListStatus": wishListStatus, "isListOwner": isListOwner, "listPhotoName": listPhotoName, "roomType": roomType, "popularLocationListing": popularLocationListing.flatMap { (value: [PopularLocationListing?]) -> [ResultMap?] in value.map { (value: PopularLocationListing?) -> ResultMap? in value.flatMap { (value: PopularLocationListing) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var bookingType: String? {
          get {
            return resultMap["bookingType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingType")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var reviewsStarRating: Int? {
          get {
            return resultMap["reviewsStarRating"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsStarRating")
          }
        }

        public var listPhotos: [ListPhoto?]? {
          get {
            return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
          }
        }

        public var listingData: ListingDatum? {
          get {
            return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
          }
        }

        public var settingsData: [SettingsDatum?]? {
          get {
            return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
          }
        }

        public var wishListStatus: Bool? {
          get {
            return resultMap["wishListStatus"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListStatus")
          }
        }

        public var isListOwner: Bool? {
          get {
            return resultMap["isListOwner"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isListOwner")
          }
        }

        public var listPhotoName: String? {
          get {
            return resultMap["listPhotoName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listPhotoName")
          }
        }

        public var roomType: String? {
          get {
            return resultMap["roomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "roomType")
          }
        }

        public var popularLocationListing: [PopularLocationListing?]? {
          get {
            return (resultMap["popularLocationListing"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [PopularLocationListing?] in value.map { (value: ResultMap?) -> PopularLocationListing? in value.flatMap { (value: ResultMap) -> PopularLocationListing in PopularLocationListing(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [PopularLocationListing?]) -> [ResultMap?] in value.map { (value: PopularLocationListing?) -> ResultMap? in value.flatMap { (value: PopularLocationListing) -> ResultMap in value.resultMap } } }, forKey: "popularLocationListing")
          }
        }

        public struct ListPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("status", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil, type: String? = nil, status: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name, "type": type, "status": status])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }
        }

        public struct ListingDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["listingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("basePrice", type: .scalar(Double.self)),
            GraphQLField("currency", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(basePrice: Double? = nil, currency: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var basePrice: Double? {
            get {
              return resultMap["basePrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "basePrice")
            }
          }

          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }
        }

        public struct SettingsDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userListingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("listsettings", type: .object(Listsetting.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(listsettings: Listsetting? = nil) {
            self.init(unsafeResultMap: ["__typename": "userListingData", "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var listsettings: Listsetting? {
            get {
              return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
            }
          }

          public struct Listsetting: GraphQLSelectionSet {
            public static let possibleTypes = ["singleListSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, itemName: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }
          }
        }

        public struct PopularLocationListing: GraphQLSelectionSet {
          public static let possibleTypes = ["PopularLocationListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("location", type: .scalar(String.self)),
            GraphQLField("locationAddress", type: .scalar(String.self)),
            GraphQLField("image", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
            GraphQLField("updatedAt", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, location: String? = nil, locationAddress: String? = nil, image: String? = nil, isEnable: String? = nil, createdAt: String? = nil, updatedAt: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PopularLocationListing", "id": id, "location": location, "locationAddress": locationAddress, "image": image, "isEnable": isEnable, "createdAt": createdAt, "updatedAt": updatedAt])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var location: String? {
            get {
              return resultMap["location"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "location")
            }
          }

          public var locationAddress: String? {
            get {
              return resultMap["locationAddress"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "locationAddress")
            }
          }

          public var image: String? {
            get {
              return resultMap["image"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "image")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          public var updatedAt: String? {
            get {
              return resultMap["updatedAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "updatedAt")
            }
          }
        }
      }
    }

    public struct GetRecommend: GraphQLSelectionSet {
      public static let possibleTypes = ["AllList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllList", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("bookingType", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
          GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
          GraphQLField("listingData", type: .object(ListingDatum.selections)),
          GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          GraphQLField("wishListStatus", type: .scalar(Bool.self)),
          GraphQLField("isListOwner", type: .scalar(Bool.self)),
          GraphQLField("listPhotoName", type: .scalar(String.self)),
          GraphQLField("roomType", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, personCapacity: Int? = nil, beds: Int? = nil, bookingType: String? = nil, coverPhoto: Int? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil, wishListStatus: Bool? = nil, isListOwner: Bool? = nil, listPhotoName: String? = nil, roomType: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "personCapacity": personCapacity, "beds": beds, "bookingType": bookingType, "coverPhoto": coverPhoto, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, "wishListStatus": wishListStatus, "isListOwner": isListOwner, "listPhotoName": listPhotoName, "roomType": roomType])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var bookingType: String? {
          get {
            return resultMap["bookingType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingType")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var reviewsStarRating: Int? {
          get {
            return resultMap["reviewsStarRating"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsStarRating")
          }
        }

        public var listPhotos: [ListPhoto?]? {
          get {
            return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
          }
        }

        public var listingData: ListingDatum? {
          get {
            return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
          }
        }

        public var settingsData: [SettingsDatum?]? {
          get {
            return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
          }
        }

        public var wishListStatus: Bool? {
          get {
            return resultMap["wishListStatus"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListStatus")
          }
        }

        public var isListOwner: Bool? {
          get {
            return resultMap["isListOwner"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isListOwner")
          }
        }

        public var listPhotoName: String? {
          get {
            return resultMap["listPhotoName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listPhotoName")
          }
        }

        public var roomType: String? {
          get {
            return resultMap["roomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "roomType")
          }
        }

        public struct ListPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("status", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil, type: String? = nil, status: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name, "type": type, "status": status])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }
        }

        public struct ListingDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["listingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("basePrice", type: .scalar(Double.self)),
            GraphQLField("currency", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(basePrice: Double? = nil, currency: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var basePrice: Double? {
            get {
              return resultMap["basePrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "basePrice")
            }
          }

          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }
        }

        public struct SettingsDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userListingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("listsettings", type: .object(Listsetting.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(listsettings: Listsetting? = nil) {
            self.init(unsafeResultMap: ["__typename": "userListingData", "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var listsettings: Listsetting? {
            get {
              return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
            }
          }

          public struct Listsetting: GraphQLSelectionSet {
            public static let possibleTypes = ["singleListSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, itemName: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }
          }
        }
      }
    }

    public struct Currency: GraphQLSelectionSet {
      public static let possibleTypes = ["Currency"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Currency", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["AllRatesType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("base", type: .scalar(String.self)),
          GraphQLField("rates", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(base: String? = nil, rates: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "AllRatesType", "base": base, "rates": rates])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var base: String? {
          get {
            return resultMap["base"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "base")
          }
        }

        public var rates: String? {
          get {
            return resultMap["rates"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "rates")
          }
        }
      }
    }

    public struct GetSearchSetting: GraphQLSelectionSet {
      public static let possibleTypes = ["AllSearchSettingsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllSearchSettingsType", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["SearchSettingsType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("minPrice", type: .scalar(Double.self)),
          GraphQLField("maxPrice", type: .scalar(Double.self)),
          GraphQLField("priceRangeCurrency", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, minPrice: Double? = nil, maxPrice: Double? = nil, priceRangeCurrency: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "SearchSettingsType", "id": id, "minPrice": minPrice, "maxPrice": maxPrice, "priceRangeCurrency": priceRangeCurrency])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var minPrice: Double? {
          get {
            return resultMap["minPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "minPrice")
          }
        }

        public var maxPrice: Double? {
          get {
            return resultMap["maxPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "maxPrice")
          }
        }

        public var priceRangeCurrency: String? {
          get {
            return resultMap["priceRangeCurrency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "priceRangeCurrency")
          }
        }
      }
    }

    public struct GetListingSettingsCommon: GraphQLSelectionSet {
      public static let possibleTypes = ["listingSettingCommonTypes"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "listingSettingCommonTypes", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["listingSettingsTypesCommon"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("typeName", type: .scalar(String.self)),
          GraphQLField("fieldType", type: .scalar(String.self)),
          GraphQLField("typeLabel", type: .scalar(String.self)),
          GraphQLField("step", type: .scalar(String.self)),
          GraphQLField("isEnable", type: .scalar(String.self)),
          GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "listingSettingsTypesCommon", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var typeName: String? {
          get {
            return resultMap["typeName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "typeName")
          }
        }

        public var fieldType: String? {
          get {
            return resultMap["fieldType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fieldType")
          }
        }

        public var typeLabel: String? {
          get {
            return resultMap["typeLabel"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "typeLabel")
          }
        }

        public var step: String? {
          get {
            return resultMap["step"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step")
          }
        }

        public var isEnable: String? {
          get {
            return resultMap["isEnable"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "isEnable")
          }
        }

        public var listSettings: [ListSetting?]? {
          get {
            return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
          }
        }

        public struct ListSetting: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsCommon"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeId", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
            GraphQLField("otherItemName", type: .scalar(String.self)),
            GraphQLField("maximum", type: .scalar(Int.self)),
            GraphQLField("minimum", type: .scalar(Int.self)),
            GraphQLField("startValue", type: .scalar(Int.self)),
            GraphQLField("endValue", type: .scalar(Int.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsCommon", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeId: Int? {
            get {
              return resultMap["typeId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeId")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }

          public var otherItemName: String? {
            get {
              return resultMap["otherItemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "otherItemName")
            }
          }

          public var maximum: Int? {
            get {
              return resultMap["maximum"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "maximum")
            }
          }

          public var minimum: Int? {
            get {
              return resultMap["minimum"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "minimum")
            }
          }

          public var startValue: Int? {
            get {
              return resultMap["startValue"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "startValue")
            }
          }

          public var endValue: Int? {
            get {
              return resultMap["endValue"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "endValue")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }
        }
      }
    }

    public struct SiteSetting: GraphQLSelectionSet {
      public static let possibleTypes = ["SiteSettingsCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SiteSettingsCommon", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["SiteSettings"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("value", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, name: String? = nil, value: String? = nil, type: String? = nil, status: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "SiteSettings", "id": id, "title": title, "name": name, "value": value, "type": type, "status": status])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var value: String? {
          get {
            return resultMap["value"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "value")
          }
        }

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var status: String? {
          get {
            return resultMap["status"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }
      }
    }
  }
}

public final class UserBanStatusQuery: GraphQLQuery {
  public let operationDefinition =
    "query UserBanStatus {\n  getUserBanStatus {\n    __typename\n    status\n    userBanStatus\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getUserBanStatus", type: .object(GetUserBanStatus.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getUserBanStatus: GetUserBanStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getUserBanStatus": getUserBanStatus.flatMap { (value: GetUserBanStatus) -> ResultMap in value.resultMap }])
    }

    public var getUserBanStatus: GetUserBanStatus? {
      get {
        return (resultMap["getUserBanStatus"] as? ResultMap).flatMap { GetUserBanStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getUserBanStatus")
      }
    }

    public struct GetUserBanStatus: GraphQLSelectionSet {
      public static let possibleTypes = ["UserType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("userBanStatus", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, userBanStatus: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "status": status, "userBanStatus": userBanStatus, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var userBanStatus: Int? {
        get {
          return resultMap["userBanStatus"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "userBanStatus")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class GetActiveSocialLoginsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getActiveSocialLogins {\n  getActiveSocialLogins {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      facebook\n      google\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getActiveSocialLogins", type: .object(GetActiveSocialLogin.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getActiveSocialLogins: GetActiveSocialLogin? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getActiveSocialLogins": getActiveSocialLogins.flatMap { (value: GetActiveSocialLogin) -> ResultMap in value.resultMap }])
    }

    public var getActiveSocialLogins: GetActiveSocialLogin? {
      get {
        return (resultMap["getActiveSocialLogins"] as? ResultMap).flatMap { GetActiveSocialLogin(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getActiveSocialLogins")
      }
    }

    public struct GetActiveSocialLogin: GraphQLSelectionSet {
      public static let possibleTypes = ["socialLoginsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .object(Result.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: Result? = nil) {
        self.init(unsafeResultMap: ["__typename": "socialLoginsType", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["resultType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("facebook", type: .scalar(Bool.self)),
          GraphQLField("google", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(facebook: Bool? = nil, google: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "resultType", "facebook": facebook, "google": google])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var facebook: Bool? {
          get {
            return resultMap["facebook"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "facebook")
          }
        }

        public var google: Bool? {
          get {
            return resultMap["google"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "google")
          }
        }
      }
    }
  }
}

public final class GetListingSettingQuery: GraphQLQuery {
  public let operationDefinition =
    "query getListingSetting {\n  getListingSettings {\n    __typename\n    status\n    results {\n      __typename\n      roomType {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      personCapacity {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      houseType {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      buildingSize {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      bedrooms {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      beds {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      bedType {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      bathrooms {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      bathroomType {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      amenities {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      safetyAmenities {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      spaces {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      guestRequirements {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      houseRules {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      reviewGuestBook {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      bookingNoticeTime {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      maxDaysNotice {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      minNight {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n      maxNight {\n        __typename\n        id\n        typeName\n        fieldType\n        typeLabel\n        step\n        isEnable\n        listSettings {\n          __typename\n          id\n          typeId\n          itemName\n          otherItemName\n          maximum\n          minimum\n          startValue\n          endValue\n          isEnable\n        }\n      }\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getListingSettings", type: .object(GetListingSetting.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getListingSettings: GetListingSetting? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getListingSettings": getListingSettings.flatMap { (value: GetListingSetting) -> ResultMap in value.resultMap }])
    }

    public var getListingSettings: GetListingSetting? {
      get {
        return (resultMap["getListingSettings"] as? ResultMap).flatMap { GetListingSetting(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getListingSettings")
      }
    }

    public struct GetListingSetting: GraphQLSelectionSet {
      public static let possibleTypes = ["listingSettingsCommonTypes"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("results", type: .object(Result.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, results: Result? = nil) {
        self.init(unsafeResultMap: ["__typename": "listingSettingsCommonTypes", "status": status, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["settingsType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("roomType", type: .object(RoomType.selections)),
          GraphQLField("personCapacity", type: .object(PersonCapacity.selections)),
          GraphQLField("houseType", type: .object(HouseType.selections)),
          GraphQLField("buildingSize", type: .object(BuildingSize.selections)),
          GraphQLField("bedrooms", type: .object(Bedroom.selections)),
          GraphQLField("beds", type: .object(Bed.selections)),
          GraphQLField("bedType", type: .object(BedType.selections)),
          GraphQLField("bathrooms", type: .object(Bathroom.selections)),
          GraphQLField("bathroomType", type: .object(BathroomType.selections)),
          GraphQLField("amenities", type: .object(Amenity.selections)),
          GraphQLField("safetyAmenities", type: .object(SafetyAmenity.selections)),
          GraphQLField("spaces", type: .object(Space.selections)),
          GraphQLField("guestRequirements", type: .object(GuestRequirement.selections)),
          GraphQLField("houseRules", type: .object(HouseRule.selections)),
          GraphQLField("reviewGuestBook", type: .object(ReviewGuestBook.selections)),
          GraphQLField("bookingNoticeTime", type: .object(BookingNoticeTime.selections)),
          GraphQLField("maxDaysNotice", type: .object(MaxDaysNotice.selections)),
          GraphQLField("minNight", type: .object(MinNight.selections)),
          GraphQLField("maxNight", type: .object(MaxNight.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(roomType: RoomType? = nil, personCapacity: PersonCapacity? = nil, houseType: HouseType? = nil, buildingSize: BuildingSize? = nil, bedrooms: Bedroom? = nil, beds: Bed? = nil, bedType: BedType? = nil, bathrooms: Bathroom? = nil, bathroomType: BathroomType? = nil, amenities: Amenity? = nil, safetyAmenities: SafetyAmenity? = nil, spaces: Space? = nil, guestRequirements: GuestRequirement? = nil, houseRules: HouseRule? = nil, reviewGuestBook: ReviewGuestBook? = nil, bookingNoticeTime: BookingNoticeTime? = nil, maxDaysNotice: MaxDaysNotice? = nil, minNight: MinNight? = nil, maxNight: MaxNight? = nil) {
          self.init(unsafeResultMap: ["__typename": "settingsType", "roomType": roomType.flatMap { (value: RoomType) -> ResultMap in value.resultMap }, "personCapacity": personCapacity.flatMap { (value: PersonCapacity) -> ResultMap in value.resultMap }, "houseType": houseType.flatMap { (value: HouseType) -> ResultMap in value.resultMap }, "buildingSize": buildingSize.flatMap { (value: BuildingSize) -> ResultMap in value.resultMap }, "bedrooms": bedrooms.flatMap { (value: Bedroom) -> ResultMap in value.resultMap }, "beds": beds.flatMap { (value: Bed) -> ResultMap in value.resultMap }, "bedType": bedType.flatMap { (value: BedType) -> ResultMap in value.resultMap }, "bathrooms": bathrooms.flatMap { (value: Bathroom) -> ResultMap in value.resultMap }, "bathroomType": bathroomType.flatMap { (value: BathroomType) -> ResultMap in value.resultMap }, "amenities": amenities.flatMap { (value: Amenity) -> ResultMap in value.resultMap }, "safetyAmenities": safetyAmenities.flatMap { (value: SafetyAmenity) -> ResultMap in value.resultMap }, "spaces": spaces.flatMap { (value: Space) -> ResultMap in value.resultMap }, "guestRequirements": guestRequirements.flatMap { (value: GuestRequirement) -> ResultMap in value.resultMap }, "houseRules": houseRules.flatMap { (value: HouseRule) -> ResultMap in value.resultMap }, "reviewGuestBook": reviewGuestBook.flatMap { (value: ReviewGuestBook) -> ResultMap in value.resultMap }, "bookingNoticeTime": bookingNoticeTime.flatMap { (value: BookingNoticeTime) -> ResultMap in value.resultMap }, "maxDaysNotice": maxDaysNotice.flatMap { (value: MaxDaysNotice) -> ResultMap in value.resultMap }, "minNight": minNight.flatMap { (value: MinNight) -> ResultMap in value.resultMap }, "maxNight": maxNight.flatMap { (value: MaxNight) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var roomType: RoomType? {
          get {
            return (resultMap["roomType"] as? ResultMap).flatMap { RoomType(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "roomType")
          }
        }

        public var personCapacity: PersonCapacity? {
          get {
            return (resultMap["personCapacity"] as? ResultMap).flatMap { PersonCapacity(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "personCapacity")
          }
        }

        public var houseType: HouseType? {
          get {
            return (resultMap["houseType"] as? ResultMap).flatMap { HouseType(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "houseType")
          }
        }

        public var buildingSize: BuildingSize? {
          get {
            return (resultMap["buildingSize"] as? ResultMap).flatMap { BuildingSize(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "buildingSize")
          }
        }

        public var bedrooms: Bedroom? {
          get {
            return (resultMap["bedrooms"] as? ResultMap).flatMap { Bedroom(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "bedrooms")
          }
        }

        public var beds: Bed? {
          get {
            return (resultMap["beds"] as? ResultMap).flatMap { Bed(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "beds")
          }
        }

        public var bedType: BedType? {
          get {
            return (resultMap["bedType"] as? ResultMap).flatMap { BedType(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "bedType")
          }
        }

        public var bathrooms: Bathroom? {
          get {
            return (resultMap["bathrooms"] as? ResultMap).flatMap { Bathroom(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "bathrooms")
          }
        }

        public var bathroomType: BathroomType? {
          get {
            return (resultMap["bathroomType"] as? ResultMap).flatMap { BathroomType(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "bathroomType")
          }
        }

        public var amenities: Amenity? {
          get {
            return (resultMap["amenities"] as? ResultMap).flatMap { Amenity(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "amenities")
          }
        }

        public var safetyAmenities: SafetyAmenity? {
          get {
            return (resultMap["safetyAmenities"] as? ResultMap).flatMap { SafetyAmenity(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "safetyAmenities")
          }
        }

        public var spaces: Space? {
          get {
            return (resultMap["spaces"] as? ResultMap).flatMap { Space(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "spaces")
          }
        }

        public var guestRequirements: GuestRequirement? {
          get {
            return (resultMap["guestRequirements"] as? ResultMap).flatMap { GuestRequirement(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "guestRequirements")
          }
        }

        public var houseRules: HouseRule? {
          get {
            return (resultMap["houseRules"] as? ResultMap).flatMap { HouseRule(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "houseRules")
          }
        }

        public var reviewGuestBook: ReviewGuestBook? {
          get {
            return (resultMap["reviewGuestBook"] as? ResultMap).flatMap { ReviewGuestBook(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "reviewGuestBook")
          }
        }

        public var bookingNoticeTime: BookingNoticeTime? {
          get {
            return (resultMap["bookingNoticeTime"] as? ResultMap).flatMap { BookingNoticeTime(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "bookingNoticeTime")
          }
        }

        public var maxDaysNotice: MaxDaysNotice? {
          get {
            return (resultMap["maxDaysNotice"] as? ResultMap).flatMap { MaxDaysNotice(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "maxDaysNotice")
          }
        }

        public var minNight: MinNight? {
          get {
            return (resultMap["minNight"] as? ResultMap).flatMap { MinNight(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "minNight")
          }
        }

        public var maxNight: MaxNight? {
          get {
            return (resultMap["maxNight"] as? ResultMap).flatMap { MaxNight(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "maxNight")
          }
        }

        public struct RoomType: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct PersonCapacity: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct HouseType: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct BuildingSize: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct Bedroom: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct Bed: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct BedType: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct Bathroom: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct BathroomType: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct Amenity: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct SafetyAmenity: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct Space: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct GuestRequirement: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct HouseRule: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct ReviewGuestBook: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct BookingNoticeTime: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct MaxDaysNotice: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct MinNight: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }

        public struct MaxNight: GraphQLSelectionSet {
          public static let possibleTypes = ["listingSettingsTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("typeName", type: .scalar(String.self)),
            GraphQLField("fieldType", type: .scalar(String.self)),
            GraphQLField("typeLabel", type: .scalar(String.self)),
            GraphQLField("step", type: .scalar(String.self)),
            GraphQLField("isEnable", type: .scalar(String.self)),
            GraphQLField("listSettings", type: .list(.object(ListSetting.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, typeName: String? = nil, fieldType: String? = nil, typeLabel: String? = nil, step: String? = nil, isEnable: String? = nil, listSettings: [ListSetting?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingSettingsTypes", "id": id, "typeName": typeName, "fieldType": fieldType, "typeLabel": typeLabel, "step": step, "isEnable": isEnable, "listSettings": listSettings.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var typeName: String? {
            get {
              return resultMap["typeName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeName")
            }
          }

          public var fieldType: String? {
            get {
              return resultMap["fieldType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "fieldType")
            }
          }

          public var typeLabel: String? {
            get {
              return resultMap["typeLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "typeLabel")
            }
          }

          public var step: String? {
            get {
              return resultMap["step"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step")
            }
          }

          public var isEnable: String? {
            get {
              return resultMap["isEnable"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEnable")
            }
          }

          public var listSettings: [ListSetting?]? {
            get {
              return (resultMap["listSettings"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListSetting?] in value.map { (value: ResultMap?) -> ListSetting? in value.flatMap { (value: ResultMap) -> ListSetting in ListSetting(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListSetting?]) -> [ResultMap?] in value.map { (value: ListSetting?) -> ResultMap? in value.flatMap { (value: ListSetting) -> ResultMap in value.resultMap } } }, forKey: "listSettings")
            }
          }

          public struct ListSetting: GraphQLSelectionSet {
            public static let possibleTypes = ["listingSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("typeId", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("otherItemName", type: .scalar(String.self)),
              GraphQLField("maximum", type: .scalar(Int.self)),
              GraphQLField("minimum", type: .scalar(Int.self)),
              GraphQLField("startValue", type: .scalar(Int.self)),
              GraphQLField("endValue", type: .scalar(Int.self)),
              GraphQLField("isEnable", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, typeId: Int? = nil, itemName: String? = nil, otherItemName: String? = nil, maximum: Int? = nil, minimum: Int? = nil, startValue: Int? = nil, endValue: Int? = nil, isEnable: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingSettings", "id": id, "typeId": typeId, "itemName": itemName, "otherItemName": otherItemName, "maximum": maximum, "minimum": minimum, "startValue": startValue, "endValue": endValue, "isEnable": isEnable])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var typeId: Int? {
              get {
                return resultMap["typeId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "typeId")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var otherItemName: String? {
              get {
                return resultMap["otherItemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "otherItemName")
              }
            }

            public var maximum: Int? {
              get {
                return resultMap["maximum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "maximum")
              }
            }

            public var minimum: Int? {
              get {
                return resultMap["minimum"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "minimum")
              }
            }

            public var startValue: Int? {
              get {
                return resultMap["startValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "startValue")
              }
            }

            public var endValue: Int? {
              get {
                return resultMap["endValue"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "endValue")
              }
            }

            public var isEnable: String? {
              get {
                return resultMap["isEnable"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEnable")
              }
            }
          }
        }
      }
    }
  }
}

public final class ReservationStatusMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation ReservationStatus($threadId: Int!, $content: String, $type: String, $startDate: String, $endDate: String, $personCapacity: Int, $reservationId: Int, $actionType: String) {\n  ReservationStatus(threadId: $threadId, content: $content, type: $type, startDate: $startDate, endDate: $endDate, personCapacity: $personCapacity, reservationId: $reservationId, actionType: $actionType) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var threadId: Int
  public var content: String?
  public var type: String?
  public var startDate: String?
  public var endDate: String?
  public var personCapacity: Int?
  public var reservationId: Int?
  public var actionType: String?

  public init(threadId: Int, content: String? = nil, type: String? = nil, startDate: String? = nil, endDate: String? = nil, personCapacity: Int? = nil, reservationId: Int? = nil, actionType: String? = nil) {
    self.threadId = threadId
    self.content = content
    self.type = type
    self.startDate = startDate
    self.endDate = endDate
    self.personCapacity = personCapacity
    self.reservationId = reservationId
    self.actionType = actionType
  }

  public var variables: GraphQLMap? {
    return ["threadId": threadId, "content": content, "type": type, "startDate": startDate, "endDate": endDate, "personCapacity": personCapacity, "reservationId": reservationId, "actionType": actionType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("ReservationStatus", arguments: ["threadId": GraphQLVariable("threadId"), "content": GraphQLVariable("content"), "type": GraphQLVariable("type"), "startDate": GraphQLVariable("startDate"), "endDate": GraphQLVariable("endDate"), "personCapacity": GraphQLVariable("personCapacity"), "reservationId": GraphQLVariable("reservationId"), "actionType": GraphQLVariable("actionType")], type: .object(ReservationStatus.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(reservationStatus: ReservationStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "ReservationStatus": reservationStatus.flatMap { (value: ReservationStatus) -> ResultMap in value.resultMap }])
    }

    public var reservationStatus: ReservationStatus? {
      get {
        return (resultMap["ReservationStatus"] as? ResultMap).flatMap { ReservationStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "ReservationStatus")
      }
    }

    public struct ReservationStatus: GraphQLSelectionSet {
      public static let possibleTypes = ["SendMessage"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SendMessage", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class GetListingSpecialPriceQuery: GraphQLQuery {
  public let operationDefinition =
    "query getListingSpecialPrice($listId: Int!) {\n  getListingSpecialPrice(listId: $listId) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      reservationId\n      blockedDates\n      calendarStatus\n      isSpecialPrice\n      listCurrency\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: Int

  public init(listId: Int) {
    self.listId = listId
  }

  public var variables: GraphQLMap? {
    return ["listId": listId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getListingSpecialPrice", arguments: ["listId": GraphQLVariable("listId")], type: .object(GetListingSpecialPrice.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getListingSpecialPrice: GetListingSpecialPrice? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getListingSpecialPrice": getListingSpecialPrice.flatMap { (value: GetListingSpecialPrice) -> ResultMap in value.resultMap }])
    }

    public var getListingSpecialPrice: GetListingSpecialPrice? {
      get {
        return (resultMap["getListingSpecialPrice"] as? ResultMap).flatMap { GetListingSpecialPrice(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getListingSpecialPrice")
      }
    }

    public struct GetListingSpecialPrice: GraphQLSelectionSet {
      public static let possibleTypes = ["ListBlockedDatesResponseType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ListBlockedDatesResponseType", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ListBlockedDates"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("reservationId", type: .scalar(Int.self)),
          GraphQLField("blockedDates", type: .scalar(String.self)),
          GraphQLField("calendarStatus", type: .scalar(String.self)),
          GraphQLField("isSpecialPrice", type: .scalar(Double.self)),
          GraphQLField("listCurrency", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, reservationId: Int? = nil, blockedDates: String? = nil, calendarStatus: String? = nil, isSpecialPrice: Double? = nil, listCurrency: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ListBlockedDates", "id": id, "listId": listId, "reservationId": reservationId, "blockedDates": blockedDates, "calendarStatus": calendarStatus, "isSpecialPrice": isSpecialPrice, "listCurrency": listCurrency])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var reservationId: Int? {
          get {
            return resultMap["reservationId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationId")
          }
        }

        public var blockedDates: String? {
          get {
            return resultMap["blockedDates"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "blockedDates")
          }
        }

        public var calendarStatus: String? {
          get {
            return resultMap["calendarStatus"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "calendarStatus")
          }
        }

        public var isSpecialPrice: Double? {
          get {
            return resultMap["isSpecialPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "isSpecialPrice")
          }
        }

        public var listCurrency: String? {
          get {
            return resultMap["listCurrency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listCurrency")
          }
        }
      }
    }
  }
}

public final class UpdateSpecialPriceMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation UpdateSpecialPrice($listId: Int!, $blockedDates: [String], $calendarStatus: String, $isSpecialPrice: Float) {\n  UpdateSpecialPrice(listId: $listId, blockedDates: $blockedDates, calendarStatus: $calendarStatus, isSpecialPrice: $isSpecialPrice) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var listId: Int
  public var blockedDates: [String?]?
  public var calendarStatus: String?
  public var isSpecialPrice: Double?

  public init(listId: Int, blockedDates: [String?]? = nil, calendarStatus: String? = nil, isSpecialPrice: Double? = nil) {
    self.listId = listId
    self.blockedDates = blockedDates
    self.calendarStatus = calendarStatus
    self.isSpecialPrice = isSpecialPrice
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "blockedDates": blockedDates, "calendarStatus": calendarStatus, "isSpecialPrice": isSpecialPrice]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("UpdateSpecialPrice", arguments: ["listId": GraphQLVariable("listId"), "blockedDates": GraphQLVariable("blockedDates"), "calendarStatus": GraphQLVariable("calendarStatus"), "isSpecialPrice": GraphQLVariable("isSpecialPrice")], type: .object(UpdateSpecialPrice.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateSpecialPrice: UpdateSpecialPrice? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "UpdateSpecialPrice": updateSpecialPrice.flatMap { (value: UpdateSpecialPrice) -> ResultMap in value.resultMap }])
    }

    public var updateSpecialPrice: UpdateSpecialPrice? {
      get {
        return (resultMap["UpdateSpecialPrice"] as? ResultMap).flatMap { UpdateSpecialPrice(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "UpdateSpecialPrice")
      }
    }

    public struct UpdateSpecialPrice: GraphQLSelectionSet {
      public static let possibleTypes = ["ListBlockedDatesResponseType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ListBlockedDatesResponseType", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class CreateReservationMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation createReservation($listId: Int!, $checkIn: String!, $checkOut: String!, $guests: Int!, $message: String!, $basePrice: Float!, $cleaningPrice: Float!, $currency: String!, $discount: Float, $discountType: String, $guestServiceFee: Float, $hostServiceFee: Float, $total: Float!, $bookingType: String, $cardToken: String!, $paymentType: Int, $convCurrency: String!, $averagePrice: Float, $nights: Int) {\n  createReservation(listId: $listId, checkIn: $checkIn, checkOut: $checkOut, guests: $guests, message: $message, basePrice: $basePrice, cleaningPrice: $cleaningPrice, currency: $currency, discount: $discount, discountType: $discountType, guestServiceFee: $guestServiceFee, hostServiceFee: $hostServiceFee, total: $total, bookingType: $bookingType, cardToken: $cardToken, paymentType: $paymentType, convCurrency: $convCurrency, averagePrice: $averagePrice, nights: $nights) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      hostId\n      guestId\n      checkIn\n      checkOut\n      guests\n      message\n      basePrice\n      cleaningPrice\n      currency\n      discount\n      discountType\n      guestServiceFee\n      hostServiceFee\n      total\n      confirmationCode\n      createdAt\n      reservationState\n      paymentState\n    }\n    status\n    errorMessage\n    requireAdditionalAction\n    paymentIntentSecret\n    reservationId\n  }\n}"

  public var listId: Int
  public var checkIn: String
  public var checkOut: String
  public var guests: Int
  public var message: String
  public var basePrice: Double
  public var cleaningPrice: Double
  public var currency: String
  public var discount: Double?
  public var discountType: String?
  public var guestServiceFee: Double?
  public var hostServiceFee: Double?
  public var total: Double
  public var bookingType: String?
  public var cardToken: String
  public var paymentType: Int?
  public var convCurrency: String
  public var averagePrice: Double?
  public var nights: Int?

  public init(listId: Int, checkIn: String, checkOut: String, guests: Int, message: String, basePrice: Double, cleaningPrice: Double, currency: String, discount: Double? = nil, discountType: String? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, total: Double, bookingType: String? = nil, cardToken: String, paymentType: Int? = nil, convCurrency: String, averagePrice: Double? = nil, nights: Int? = nil) {
    self.listId = listId
    self.checkIn = checkIn
    self.checkOut = checkOut
    self.guests = guests
    self.message = message
    self.basePrice = basePrice
    self.cleaningPrice = cleaningPrice
    self.currency = currency
    self.discount = discount
    self.discountType = discountType
    self.guestServiceFee = guestServiceFee
    self.hostServiceFee = hostServiceFee
    self.total = total
    self.bookingType = bookingType
    self.cardToken = cardToken
    self.paymentType = paymentType
    self.convCurrency = convCurrency
    self.averagePrice = averagePrice
    self.nights = nights
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "checkIn": checkIn, "checkOut": checkOut, "guests": guests, "message": message, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "discount": discount, "discountType": discountType, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "total": total, "bookingType": bookingType, "cardToken": cardToken, "paymentType": paymentType, "convCurrency": convCurrency, "averagePrice": averagePrice, "nights": nights]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createReservation", arguments: ["listId": GraphQLVariable("listId"), "checkIn": GraphQLVariable("checkIn"), "checkOut": GraphQLVariable("checkOut"), "guests": GraphQLVariable("guests"), "message": GraphQLVariable("message"), "basePrice": GraphQLVariable("basePrice"), "cleaningPrice": GraphQLVariable("cleaningPrice"), "currency": GraphQLVariable("currency"), "discount": GraphQLVariable("discount"), "discountType": GraphQLVariable("discountType"), "guestServiceFee": GraphQLVariable("guestServiceFee"), "hostServiceFee": GraphQLVariable("hostServiceFee"), "total": GraphQLVariable("total"), "bookingType": GraphQLVariable("bookingType"), "cardToken": GraphQLVariable("cardToken"), "paymentType": GraphQLVariable("paymentType"), "convCurrency": GraphQLVariable("convCurrency"), "averagePrice": GraphQLVariable("averagePrice"), "nights": GraphQLVariable("nights")], type: .object(CreateReservation.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createReservation: CreateReservation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createReservation": createReservation.flatMap { (value: CreateReservation) -> ResultMap in value.resultMap }])
    }

    public var createReservation: CreateReservation? {
      get {
        return (resultMap["createReservation"] as? ResultMap).flatMap { CreateReservation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createReservation")
      }
    }

    public struct CreateReservation: GraphQLSelectionSet {
      public static let possibleTypes = ["ReservationPayment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("requireAdditionalAction", type: .scalar(Bool.self)),
        GraphQLField("paymentIntentSecret", type: .scalar(String.self)),
        GraphQLField("reservationId", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil, requireAdditionalAction: Bool? = nil, paymentIntentSecret: String? = nil, reservationId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "ReservationPayment", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage, "requireAdditionalAction": requireAdditionalAction, "paymentIntentSecret": paymentIntentSecret, "reservationId": reservationId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var requireAdditionalAction: Bool? {
        get {
          return resultMap["requireAdditionalAction"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "requireAdditionalAction")
        }
      }

      public var paymentIntentSecret: String? {
        get {
          return resultMap["paymentIntentSecret"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "paymentIntentSecret")
        }
      }

      public var reservationId: Int? {
        get {
          return resultMap["reservationId"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "reservationId")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Reservation"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("hostId", type: .scalar(String.self)),
          GraphQLField("guestId", type: .scalar(String.self)),
          GraphQLField("checkIn", type: .scalar(String.self)),
          GraphQLField("checkOut", type: .scalar(String.self)),
          GraphQLField("guests", type: .scalar(Int.self)),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("basePrice", type: .scalar(Double.self)),
          GraphQLField("cleaningPrice", type: .scalar(Double.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("discount", type: .scalar(Double.self)),
          GraphQLField("discountType", type: .scalar(String.self)),
          GraphQLField("guestServiceFee", type: .scalar(Double.self)),
          GraphQLField("hostServiceFee", type: .scalar(Double.self)),
          GraphQLField("total", type: .scalar(Double.self)),
          GraphQLField("confirmationCode", type: .scalar(Int.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("reservationState", type: .scalar(String.self)),
          GraphQLField("paymentState", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, hostId: String? = nil, guestId: String? = nil, checkIn: String? = nil, checkOut: String? = nil, guests: Int? = nil, message: String? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, discount: Double? = nil, discountType: String? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, total: Double? = nil, confirmationCode: Int? = nil, createdAt: String? = nil, reservationState: String? = nil, paymentState: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Reservation", "id": id, "listId": listId, "hostId": hostId, "guestId": guestId, "checkIn": checkIn, "checkOut": checkOut, "guests": guests, "message": message, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "discount": discount, "discountType": discountType, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "total": total, "confirmationCode": confirmationCode, "createdAt": createdAt, "reservationState": reservationState, "paymentState": paymentState])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var hostId: String? {
          get {
            return resultMap["hostId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostId")
          }
        }

        public var guestId: String? {
          get {
            return resultMap["guestId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestId")
          }
        }

        public var checkIn: String? {
          get {
            return resultMap["checkIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkIn")
          }
        }

        public var checkOut: String? {
          get {
            return resultMap["checkOut"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkOut")
          }
        }

        public var guests: Int? {
          get {
            return resultMap["guests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "guests")
          }
        }

        public var message: String? {
          get {
            return resultMap["message"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var basePrice: Double? {
          get {
            return resultMap["basePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "basePrice")
          }
        }

        public var cleaningPrice: Double? {
          get {
            return resultMap["cleaningPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "cleaningPrice")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var discount: Double? {
          get {
            return resultMap["discount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "discount")
          }
        }

        public var discountType: String? {
          get {
            return resultMap["discountType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "discountType")
          }
        }

        public var guestServiceFee: Double? {
          get {
            return resultMap["guestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFee")
          }
        }

        public var hostServiceFee: Double? {
          get {
            return resultMap["hostServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFee")
          }
        }

        public var total: Double? {
          get {
            return resultMap["total"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "total")
          }
        }

        public var confirmationCode: Int? {
          get {
            return resultMap["confirmationCode"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "confirmationCode")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var reservationState: String? {
          get {
            return resultMap["reservationState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationState")
          }
        }

        public var paymentState: String? {
          get {
            return resultMap["paymentState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "paymentState")
          }
        }
      }
    }
  }
}

public final class ConfirmReservationMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation confirmReservation($reservationId: Int!, $paymentIntentId: String!) {\n  confirmReservation(reservationId: $reservationId, paymentIntentId: $paymentIntentId) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      hostId\n      guestId\n      checkIn\n      checkOut\n      guests\n      message\n      basePrice\n      cleaningPrice\n      currency\n      discount\n      discountType\n      guestServiceFee\n      hostServiceFee\n      total\n      confirmationCode\n      createdAt\n      reservationState\n      paymentState\n    }\n    status\n    errorMessage\n    requireAdditionalAction\n    paymentIntentSecret\n    reservationId\n  }\n}"

  public var reservationId: Int
  public var paymentIntentId: String

  public init(reservationId: Int, paymentIntentId: String) {
    self.reservationId = reservationId
    self.paymentIntentId = paymentIntentId
  }

  public var variables: GraphQLMap? {
    return ["reservationId": reservationId, "paymentIntentId": paymentIntentId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("confirmReservation", arguments: ["reservationId": GraphQLVariable("reservationId"), "paymentIntentId": GraphQLVariable("paymentIntentId")], type: .object(ConfirmReservation.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(confirmReservation: ConfirmReservation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "confirmReservation": confirmReservation.flatMap { (value: ConfirmReservation) -> ResultMap in value.resultMap }])
    }

    public var confirmReservation: ConfirmReservation? {
      get {
        return (resultMap["confirmReservation"] as? ResultMap).flatMap { ConfirmReservation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "confirmReservation")
      }
    }

    public struct ConfirmReservation: GraphQLSelectionSet {
      public static let possibleTypes = ["ReservationPayment"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("requireAdditionalAction", type: .scalar(Bool.self)),
        GraphQLField("paymentIntentSecret", type: .scalar(String.self)),
        GraphQLField("reservationId", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil, requireAdditionalAction: Bool? = nil, paymentIntentSecret: String? = nil, reservationId: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "ReservationPayment", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage, "requireAdditionalAction": requireAdditionalAction, "paymentIntentSecret": paymentIntentSecret, "reservationId": reservationId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var requireAdditionalAction: Bool? {
        get {
          return resultMap["requireAdditionalAction"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "requireAdditionalAction")
        }
      }

      public var paymentIntentSecret: String? {
        get {
          return resultMap["paymentIntentSecret"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "paymentIntentSecret")
        }
      }

      public var reservationId: Int? {
        get {
          return resultMap["reservationId"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "reservationId")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Reservation"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("hostId", type: .scalar(String.self)),
          GraphQLField("guestId", type: .scalar(String.self)),
          GraphQLField("checkIn", type: .scalar(String.self)),
          GraphQLField("checkOut", type: .scalar(String.self)),
          GraphQLField("guests", type: .scalar(Int.self)),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("basePrice", type: .scalar(Double.self)),
          GraphQLField("cleaningPrice", type: .scalar(Double.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("discount", type: .scalar(Double.self)),
          GraphQLField("discountType", type: .scalar(String.self)),
          GraphQLField("guestServiceFee", type: .scalar(Double.self)),
          GraphQLField("hostServiceFee", type: .scalar(Double.self)),
          GraphQLField("total", type: .scalar(Double.self)),
          GraphQLField("confirmationCode", type: .scalar(Int.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("reservationState", type: .scalar(String.self)),
          GraphQLField("paymentState", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, hostId: String? = nil, guestId: String? = nil, checkIn: String? = nil, checkOut: String? = nil, guests: Int? = nil, message: String? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, discount: Double? = nil, discountType: String? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, total: Double? = nil, confirmationCode: Int? = nil, createdAt: String? = nil, reservationState: String? = nil, paymentState: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Reservation", "id": id, "listId": listId, "hostId": hostId, "guestId": guestId, "checkIn": checkIn, "checkOut": checkOut, "guests": guests, "message": message, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "discount": discount, "discountType": discountType, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "total": total, "confirmationCode": confirmationCode, "createdAt": createdAt, "reservationState": reservationState, "paymentState": paymentState])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var hostId: String? {
          get {
            return resultMap["hostId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostId")
          }
        }

        public var guestId: String? {
          get {
            return resultMap["guestId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestId")
          }
        }

        public var checkIn: String? {
          get {
            return resultMap["checkIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkIn")
          }
        }

        public var checkOut: String? {
          get {
            return resultMap["checkOut"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkOut")
          }
        }

        public var guests: Int? {
          get {
            return resultMap["guests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "guests")
          }
        }

        public var message: String? {
          get {
            return resultMap["message"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }

        public var basePrice: Double? {
          get {
            return resultMap["basePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "basePrice")
          }
        }

        public var cleaningPrice: Double? {
          get {
            return resultMap["cleaningPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "cleaningPrice")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var discount: Double? {
          get {
            return resultMap["discount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "discount")
          }
        }

        public var discountType: String? {
          get {
            return resultMap["discountType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "discountType")
          }
        }

        public var guestServiceFee: Double? {
          get {
            return resultMap["guestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFee")
          }
        }

        public var hostServiceFee: Double? {
          get {
            return resultMap["hostServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFee")
          }
        }

        public var total: Double? {
          get {
            return resultMap["total"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "total")
          }
        }

        public var confirmationCode: Int? {
          get {
            return resultMap["confirmationCode"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "confirmationCode")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var reservationState: String? {
          get {
            return resultMap["reservationState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationState")
          }
        }

        public var paymentState: String? {
          get {
            return resultMap["paymentState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "paymentState")
          }
        }
      }
    }
  }
}

public final class CreateReportUserMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation createReportUser($reporterId: String, $userId: String, $reportType: String, $profileId: Int) {\n  createReportUser(reporterId: $reporterId, userId: $userId, reportType: $reportType, profileId: $profileId) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var reporterId: String?
  public var userId: String?
  public var reportType: String?
  public var profileId: Int?

  public init(reporterId: String? = nil, userId: String? = nil, reportType: String? = nil, profileId: Int? = nil) {
    self.reporterId = reporterId
    self.userId = userId
    self.reportType = reportType
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["reporterId": reporterId, "userId": userId, "reportType": reportType, "profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createReportUser", arguments: ["reporterId": GraphQLVariable("reporterId"), "userId": GraphQLVariable("userId"), "reportType": GraphQLVariable("reportType"), "profileId": GraphQLVariable("profileId")], type: .object(CreateReportUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createReportUser: CreateReportUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createReportUser": createReportUser.flatMap { (value: CreateReportUser) -> ResultMap in value.resultMap }])
    }

    public var createReportUser: CreateReportUser? {
      get {
        return (resultMap["createReportUser"] as? ResultMap).flatMap { CreateReportUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createReportUser")
      }
    }

    public struct CreateReportUser: GraphQLSelectionSet {
      public static let possibleTypes = ["ReportUserResult"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ReportUserResult", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class GetBillingCalculationQuery: GraphQLQuery {
  public let operationDefinition =
    "query getBillingCalculation($listId: Int!, $startDate: String!, $endDate: String!, $guests: Int!, $convertCurrency: String!) {\n  getBillingCalculation(listId: $listId, startDate: $startDate, endDate: $endDate, guests: $guests, convertCurrency: $convertCurrency) {\n    __typename\n    result {\n      __typename\n      checkIn\n      checkOut\n      nights\n      basePrice\n      cleaningPrice\n      guests\n      currency\n      guestServiceFeePercentage\n      hostServiceFeePercentage\n      weeklyDiscountPercentage\n      monthlyDiscountPercentage\n      guestServiceFee\n      hostServiceFee\n      discountLabel\n      discount\n      subtotal\n      total\n      averagePrice\n      priceForDays\n      specialPricing {\n        __typename\n        blockedDates\n        isSpecialPrice\n      }\n      isSpecialPriceAssigned\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: Int
  public var startDate: String
  public var endDate: String
  public var guests: Int
  public var convertCurrency: String

  public init(listId: Int, startDate: String, endDate: String, guests: Int, convertCurrency: String) {
    self.listId = listId
    self.startDate = startDate
    self.endDate = endDate
    self.guests = guests
    self.convertCurrency = convertCurrency
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "startDate": startDate, "endDate": endDate, "guests": guests, "convertCurrency": convertCurrency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getBillingCalculation", arguments: ["listId": GraphQLVariable("listId"), "startDate": GraphQLVariable("startDate"), "endDate": GraphQLVariable("endDate"), "guests": GraphQLVariable("guests"), "convertCurrency": GraphQLVariable("convertCurrency")], type: .object(GetBillingCalculation.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getBillingCalculation: GetBillingCalculation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getBillingCalculation": getBillingCalculation.flatMap { (value: GetBillingCalculation) -> ResultMap in value.resultMap }])
    }

    public var getBillingCalculation: GetBillingCalculation? {
      get {
        return (resultMap["getBillingCalculation"] as? ResultMap).flatMap { GetBillingCalculation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getBillingCalculation")
      }
    }

    public struct GetBillingCalculation: GraphQLSelectionSet {
      public static let possibleTypes = ["AllBillingType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllBillingType", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["BillingType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("checkIn", type: .scalar(String.self)),
          GraphQLField("checkOut", type: .scalar(String.self)),
          GraphQLField("nights", type: .scalar(Int.self)),
          GraphQLField("basePrice", type: .scalar(Double.self)),
          GraphQLField("cleaningPrice", type: .scalar(Double.self)),
          GraphQLField("guests", type: .scalar(Int.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("guestServiceFeePercentage", type: .scalar(Double.self)),
          GraphQLField("hostServiceFeePercentage", type: .scalar(Double.self)),
          GraphQLField("weeklyDiscountPercentage", type: .scalar(Double.self)),
          GraphQLField("monthlyDiscountPercentage", type: .scalar(Double.self)),
          GraphQLField("guestServiceFee", type: .scalar(Double.self)),
          GraphQLField("hostServiceFee", type: .scalar(Double.self)),
          GraphQLField("discountLabel", type: .scalar(String.self)),
          GraphQLField("discount", type: .scalar(Double.self)),
          GraphQLField("subtotal", type: .scalar(Double.self)),
          GraphQLField("total", type: .scalar(Double.self)),
          GraphQLField("averagePrice", type: .scalar(Double.self)),
          GraphQLField("priceForDays", type: .scalar(Double.self)),
          GraphQLField("specialPricing", type: .list(.object(SpecialPricing.selections))),
          GraphQLField("isSpecialPriceAssigned", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(checkIn: String? = nil, checkOut: String? = nil, nights: Int? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, guests: Int? = nil, currency: String? = nil, guestServiceFeePercentage: Double? = nil, hostServiceFeePercentage: Double? = nil, weeklyDiscountPercentage: Double? = nil, monthlyDiscountPercentage: Double? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, discountLabel: String? = nil, discount: Double? = nil, subtotal: Double? = nil, total: Double? = nil, averagePrice: Double? = nil, priceForDays: Double? = nil, specialPricing: [SpecialPricing?]? = nil, isSpecialPriceAssigned: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "BillingType", "checkIn": checkIn, "checkOut": checkOut, "nights": nights, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "guests": guests, "currency": currency, "guestServiceFeePercentage": guestServiceFeePercentage, "hostServiceFeePercentage": hostServiceFeePercentage, "weeklyDiscountPercentage": weeklyDiscountPercentage, "monthlyDiscountPercentage": monthlyDiscountPercentage, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "discountLabel": discountLabel, "discount": discount, "subtotal": subtotal, "total": total, "averagePrice": averagePrice, "priceForDays": priceForDays, "specialPricing": specialPricing.flatMap { (value: [SpecialPricing?]) -> [ResultMap?] in value.map { (value: SpecialPricing?) -> ResultMap? in value.flatMap { (value: SpecialPricing) -> ResultMap in value.resultMap } } }, "isSpecialPriceAssigned": isSpecialPriceAssigned])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var checkIn: String? {
          get {
            return resultMap["checkIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkIn")
          }
        }

        public var checkOut: String? {
          get {
            return resultMap["checkOut"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkOut")
          }
        }

        public var nights: Int? {
          get {
            return resultMap["nights"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "nights")
          }
        }

        public var basePrice: Double? {
          get {
            return resultMap["basePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "basePrice")
          }
        }

        public var cleaningPrice: Double? {
          get {
            return resultMap["cleaningPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "cleaningPrice")
          }
        }

        public var guests: Int? {
          get {
            return resultMap["guests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "guests")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var guestServiceFeePercentage: Double? {
          get {
            return resultMap["guestServiceFeePercentage"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFeePercentage")
          }
        }

        public var hostServiceFeePercentage: Double? {
          get {
            return resultMap["hostServiceFeePercentage"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFeePercentage")
          }
        }

        public var weeklyDiscountPercentage: Double? {
          get {
            return resultMap["weeklyDiscountPercentage"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "weeklyDiscountPercentage")
          }
        }

        public var monthlyDiscountPercentage: Double? {
          get {
            return resultMap["monthlyDiscountPercentage"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "monthlyDiscountPercentage")
          }
        }

        public var guestServiceFee: Double? {
          get {
            return resultMap["guestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFee")
          }
        }

        public var hostServiceFee: Double? {
          get {
            return resultMap["hostServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFee")
          }
        }

        public var discountLabel: String? {
          get {
            return resultMap["discountLabel"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "discountLabel")
          }
        }

        public var discount: Double? {
          get {
            return resultMap["discount"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "discount")
          }
        }

        public var subtotal: Double? {
          get {
            return resultMap["subtotal"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "subtotal")
          }
        }

        public var total: Double? {
          get {
            return resultMap["total"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "total")
          }
        }

        public var averagePrice: Double? {
          get {
            return resultMap["averagePrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "averagePrice")
          }
        }

        public var priceForDays: Double? {
          get {
            return resultMap["priceForDays"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "priceForDays")
          }
        }

        public var specialPricing: [SpecialPricing?]? {
          get {
            return (resultMap["specialPricing"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SpecialPricing?] in value.map { (value: ResultMap?) -> SpecialPricing? in value.flatMap { (value: ResultMap) -> SpecialPricing in SpecialPricing(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [SpecialPricing?]) -> [ResultMap?] in value.map { (value: SpecialPricing?) -> ResultMap? in value.flatMap { (value: SpecialPricing) -> ResultMap in value.resultMap } } }, forKey: "specialPricing")
          }
        }

        public var isSpecialPriceAssigned: Bool? {
          get {
            return resultMap["isSpecialPriceAssigned"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isSpecialPriceAssigned")
          }
        }

        public struct SpecialPricing: GraphQLSelectionSet {
          public static let possibleTypes = ["SpecialPricingType"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("blockedDates", type: .scalar(String.self)),
            GraphQLField("isSpecialPrice", type: .scalar(Double.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(blockedDates: String? = nil, isSpecialPrice: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "SpecialPricingType", "blockedDates": blockedDates, "isSpecialPrice": isSpecialPrice])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var blockedDates: String? {
            get {
              return resultMap["blockedDates"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "blockedDates")
            }
          }

          public var isSpecialPrice: Double? {
            get {
              return resultMap["isSpecialPrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "isSpecialPrice")
            }
          }
        }
      }
    }
  }
}

public final class EditProfileMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation EditProfile($userId: String!, $fieldName: String!, $fieldValue: String, $deviceType: String!, $deviceId: String!) {\n  userUpdate(userId: $userId, fieldName: $fieldName, fieldValue: $fieldValue, deviceType: $deviceType, deviceId: $deviceId) {\n    __typename\n    status\n    errorMessage\n    userToken\n  }\n}"

  public var userId: String
  public var fieldName: String
  public var fieldValue: String?
  public var deviceType: String
  public var deviceId: String

  public init(userId: String, fieldName: String, fieldValue: String? = nil, deviceType: String, deviceId: String) {
    self.userId = userId
    self.fieldName = fieldName
    self.fieldValue = fieldValue
    self.deviceType = deviceType
    self.deviceId = deviceId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "fieldName": fieldName, "fieldValue": fieldValue, "deviceType": deviceType, "deviceId": deviceId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userUpdate", arguments: ["userId": GraphQLVariable("userId"), "fieldName": GraphQLVariable("fieldName"), "fieldValue": GraphQLVariable("fieldValue"), "deviceType": GraphQLVariable("deviceType"), "deviceId": GraphQLVariable("deviceId")], type: .object(UserUpdate.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userUpdate: UserUpdate? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userUpdate": userUpdate.flatMap { (value: UserUpdate) -> ResultMap in value.resultMap }])
    }

    public var userUpdate: UserUpdate? {
      get {
        return (resultMap["userUpdate"] as? ResultMap).flatMap { UserUpdate(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userUpdate")
      }
    }

    public struct UserUpdate: GraphQLSelectionSet {
      public static let possibleTypes = ["UserType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("userToken", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, userToken: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "status": status, "errorMessage": errorMessage, "userToken": userToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var userToken: String? {
        get {
          return resultMap["userToken"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userToken")
        }
      }
    }
  }
}

public final class SearchListingQuery: GraphQLQuery {
  public let operationDefinition =
    "query SearchListing($personCapacity: Int, $currentPage: Int, $dates: String, $lat: Float, $lng: Float, $amenities: [Int], $beds: Int, $bedrooms: Int, $bathrooms: Int, $roomType: [Int], $spaces: [Int], $houseRules: [Int], $priceRange: [Int], $geoType: String, $geography: String, $bookingType: String, $address: String, $currency: String) {\n  SearchListing(personCapacity: $personCapacity, currentPage: $currentPage, dates: $dates, lat: $lat, lng: $lng, amenities: $amenities, beds: $beds, bedrooms: $bedrooms, bathrooms: $bathrooms, roomType: $roomType, spaces: $spaces, houseRules: $houseRules, priceRange: $priceRange, geoType: $geoType, geography: $geography, bookingType: $bookingType, address: $address, currency: $currency) {\n    __typename\n    currentPage\n    count\n    results {\n      __typename\n      id\n      title\n      personCapacity\n      lat\n      lng\n      beds\n      bookingType\n      coverPhoto\n      roomType\n      reviewsCount\n      reviewsStarRating\n      listPhotoName\n      listPhotos {\n        __typename\n        id\n        name\n        type\n        status\n      }\n      listingPhotos {\n        __typename\n        id\n        name\n        type\n        status\n      }\n      listingData {\n        __typename\n        basePrice\n        currency\n      }\n      settingsData {\n        __typename\n        listsettings {\n          __typename\n          id\n          itemName\n        }\n      }\n      wishListStatus\n      isListOwner\n    }\n    status\n    errorMessage\n  }\n}"

  public var personCapacity: Int?
  public var currentPage: Int?
  public var dates: String?
  public var lat: Double?
  public var lng: Double?
  public var amenities: [Int?]?
  public var beds: Int?
  public var bedrooms: Int?
  public var bathrooms: Int?
  public var roomType: [Int?]?
  public var spaces: [Int?]?
  public var houseRules: [Int?]?
  public var priceRange: [Int?]?
  public var geoType: String?
  public var geography: String?
  public var bookingType: String?
  public var address: String?
  public var currency: String?

  public init(personCapacity: Int? = nil, currentPage: Int? = nil, dates: String? = nil, lat: Double? = nil, lng: Double? = nil, amenities: [Int?]? = nil, beds: Int? = nil, bedrooms: Int? = nil, bathrooms: Int? = nil, roomType: [Int?]? = nil, spaces: [Int?]? = nil, houseRules: [Int?]? = nil, priceRange: [Int?]? = nil, geoType: String? = nil, geography: String? = nil, bookingType: String? = nil, address: String? = nil, currency: String? = nil) {
    self.personCapacity = personCapacity
    self.currentPage = currentPage
    self.dates = dates
    self.lat = lat
    self.lng = lng
    self.amenities = amenities
    self.beds = beds
    self.bedrooms = bedrooms
    self.bathrooms = bathrooms
    self.roomType = roomType
    self.spaces = spaces
    self.houseRules = houseRules
    self.priceRange = priceRange
    self.geoType = geoType
    self.geography = geography
    self.bookingType = bookingType
    self.address = address
    self.currency = currency
  }

  public var variables: GraphQLMap? {
    return ["personCapacity": personCapacity, "currentPage": currentPage, "dates": dates, "lat": lat, "lng": lng, "amenities": amenities, "beds": beds, "bedrooms": bedrooms, "bathrooms": bathrooms, "roomType": roomType, "spaces": spaces, "houseRules": houseRules, "priceRange": priceRange, "geoType": geoType, "geography": geography, "bookingType": bookingType, "address": address, "currency": currency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("SearchListing", arguments: ["personCapacity": GraphQLVariable("personCapacity"), "currentPage": GraphQLVariable("currentPage"), "dates": GraphQLVariable("dates"), "lat": GraphQLVariable("lat"), "lng": GraphQLVariable("lng"), "amenities": GraphQLVariable("amenities"), "beds": GraphQLVariable("beds"), "bedrooms": GraphQLVariable("bedrooms"), "bathrooms": GraphQLVariable("bathrooms"), "roomType": GraphQLVariable("roomType"), "spaces": GraphQLVariable("spaces"), "houseRules": GraphQLVariable("houseRules"), "priceRange": GraphQLVariable("priceRange"), "geoType": GraphQLVariable("geoType"), "geography": GraphQLVariable("geography"), "bookingType": GraphQLVariable("bookingType"), "address": GraphQLVariable("address"), "currency": GraphQLVariable("currency")], type: .object(SearchListing.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchListing: SearchListing? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "SearchListing": searchListing.flatMap { (value: SearchListing) -> ResultMap in value.resultMap }])
    }

    public var searchListing: SearchListing? {
      get {
        return (resultMap["SearchListing"] as? ResultMap).flatMap { SearchListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "SearchListing")
      }
    }

    public struct SearchListing: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchListing"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("currentPage", type: .scalar(Int.self)),
        GraphQLField("count", type: .scalar(Int.self)),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(currentPage: Int? = nil, count: Int? = nil, results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchListing", "currentPage": currentPage, "count": count, "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var currentPage: Int? {
        get {
          return resultMap["currentPage"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "currentPage")
        }
      }

      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("lng", type: .scalar(Double.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("bookingType", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
          GraphQLField("roomType", type: .scalar(String.self)),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
          GraphQLField("listPhotoName", type: .scalar(String.self)),
          GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
          GraphQLField("listingPhotos", type: .list(.object(ListingPhoto.selections))),
          GraphQLField("listingData", type: .object(ListingDatum.selections)),
          GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          GraphQLField("wishListStatus", type: .scalar(Bool.self)),
          GraphQLField("isListOwner", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, personCapacity: Int? = nil, lat: Double? = nil, lng: Double? = nil, beds: Int? = nil, bookingType: String? = nil, coverPhoto: Int? = nil, roomType: String? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, listingPhotos: [ListingPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil, wishListStatus: Bool? = nil, isListOwner: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "personCapacity": personCapacity, "lat": lat, "lng": lng, "beds": beds, "bookingType": bookingType, "coverPhoto": coverPhoto, "roomType": roomType, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingPhotos": listingPhotos.flatMap { (value: [ListingPhoto?]) -> [ResultMap?] in value.map { (value: ListingPhoto?) -> ResultMap? in value.flatMap { (value: ListingPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, "wishListStatus": wishListStatus, "isListOwner": isListOwner])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var lat: Double? {
          get {
            return resultMap["lat"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var lng: Double? {
          get {
            return resultMap["lng"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lng")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var bookingType: String? {
          get {
            return resultMap["bookingType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingType")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }

        public var roomType: String? {
          get {
            return resultMap["roomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "roomType")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var reviewsStarRating: Int? {
          get {
            return resultMap["reviewsStarRating"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsStarRating")
          }
        }

        public var listPhotoName: String? {
          get {
            return resultMap["listPhotoName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listPhotoName")
          }
        }

        public var listPhotos: [ListPhoto?]? {
          get {
            return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
          }
        }

        public var listingPhotos: [ListingPhoto?]? {
          get {
            return (resultMap["listingPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListingPhoto?] in value.map { (value: ResultMap?) -> ListingPhoto? in value.flatMap { (value: ResultMap) -> ListingPhoto in ListingPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListingPhoto?]) -> [ResultMap?] in value.map { (value: ListingPhoto?) -> ResultMap? in value.flatMap { (value: ListingPhoto) -> ResultMap in value.resultMap } } }, forKey: "listingPhotos")
          }
        }

        public var listingData: ListingDatum? {
          get {
            return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
          }
        }

        public var settingsData: [SettingsDatum?]? {
          get {
            return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
          }
        }

        public var wishListStatus: Bool? {
          get {
            return resultMap["wishListStatus"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListStatus")
          }
        }

        public var isListOwner: Bool? {
          get {
            return resultMap["isListOwner"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isListOwner")
          }
        }

        public struct ListPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("status", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil, type: String? = nil, status: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name, "type": type, "status": status])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }
        }

        public struct ListingPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("status", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil, type: String? = nil, status: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name, "type": type, "status": status])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }
        }

        public struct ListingDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["listingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("basePrice", type: .scalar(Double.self)),
            GraphQLField("currency", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(basePrice: Double? = nil, currency: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var basePrice: Double? {
            get {
              return resultMap["basePrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "basePrice")
            }
          }

          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }
        }

        public struct SettingsDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userListingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("listsettings", type: .object(Listsetting.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(listsettings: Listsetting? = nil) {
            self.init(unsafeResultMap: ["__typename": "userListingData", "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var listsettings: Listsetting? {
            get {
              return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
            }
          }

          public struct Listsetting: GraphQLSelectionSet {
            public static let possibleTypes = ["singleListSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, itemName: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }
          }
        }
      }
    }
  }
}

public final class SignupMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation Signup($firstName: String, $lastName: String, $email: String!, $password: String!, $dateOfBirth: String, $deviceType: String!, $deviceDetail: String, $deviceId: String!, $registerType: String) {\n  createUser(firstName: $firstName, lastName: $lastName, email: $email, password: $password, dateOfBirth: $dateOfBirth, deviceType: $deviceType, deviceDetail: $deviceDetail, deviceId: $deviceId, registerType: $registerType) {\n    __typename\n    result {\n      __typename\n      userId\n      userToken\n      user {\n        __typename\n        firstName\n        lastName\n        gender\n        dateOfBirth\n        phoneNumber\n        preferredLanguage\n        preferredCurrency\n        createdAt\n        picture\n        verification {\n          __typename\n          id\n          isPhoneVerified\n          isEmailConfirmed\n          isIdVerification\n          isGoogleConnected\n          isFacebookConnected\n        }\n        userData {\n          __typename\n          type\n        }\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var firstName: String?
  public var lastName: String?
  public var email: String
  public var password: String
  public var dateOfBirth: String?
  public var deviceType: String
  public var deviceDetail: String?
  public var deviceId: String
  public var registerType: String?

  public init(firstName: String? = nil, lastName: String? = nil, email: String, password: String, dateOfBirth: String? = nil, deviceType: String, deviceDetail: String? = nil, deviceId: String, registerType: String? = nil) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
    self.dateOfBirth = dateOfBirth
    self.deviceType = deviceType
    self.deviceDetail = deviceDetail
    self.deviceId = deviceId
    self.registerType = registerType
  }

  public var variables: GraphQLMap? {
    return ["firstName": firstName, "lastName": lastName, "email": email, "password": password, "dateOfBirth": dateOfBirth, "deviceType": deviceType, "deviceDetail": deviceDetail, "deviceId": deviceId, "registerType": registerType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createUser", arguments: ["firstName": GraphQLVariable("firstName"), "lastName": GraphQLVariable("lastName"), "email": GraphQLVariable("email"), "password": GraphQLVariable("password"), "dateOfBirth": GraphQLVariable("dateOfBirth"), "deviceType": GraphQLVariable("deviceType"), "deviceDetail": GraphQLVariable("deviceDetail"), "deviceId": GraphQLVariable("deviceId"), "registerType": GraphQLVariable("registerType")], type: .object(CreateUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUser: CreateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: CreateUser) -> ResultMap in value.resultMap }])
    }

    public var createUser: CreateUser? {
      get {
        return (resultMap["createUser"] as? ResultMap).flatMap { CreateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
      public static let possibleTypes = ["UserCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserCommon", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["UserType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("userToken", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: String? = nil, userToken: String? = nil, user: User? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserType", "userId": userId, "userToken": userToken, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var userToken: String? {
          get {
            return resultMap["userToken"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userToken")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["userEditProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("gender", type: .scalar(String.self)),
            GraphQLField("dateOfBirth", type: .scalar(String.self)),
            GraphQLField("phoneNumber", type: .scalar(String.self)),
            GraphQLField("preferredLanguage", type: .scalar(String.self)),
            GraphQLField("preferredCurrency", type: .scalar(String.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("verification", type: .object(Verification.selections)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(firstName: String? = nil, lastName: String? = nil, gender: String? = nil, dateOfBirth: String? = nil, phoneNumber: String? = nil, preferredLanguage: String? = nil, preferredCurrency: String? = nil, createdAt: String? = nil, picture: String? = nil, verification: Verification? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "userEditProfile", "firstName": firstName, "lastName": lastName, "gender": gender, "dateOfBirth": dateOfBirth, "phoneNumber": phoneNumber, "preferredLanguage": preferredLanguage, "preferredCurrency": preferredCurrency, "createdAt": createdAt, "picture": picture, "verification": verification.flatMap { (value: Verification) -> ResultMap in value.resultMap }, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var gender: String? {
            get {
              return resultMap["gender"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "gender")
            }
          }

          public var dateOfBirth: String? {
            get {
              return resultMap["dateOfBirth"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "dateOfBirth")
            }
          }

          public var phoneNumber: String? {
            get {
              return resultMap["phoneNumber"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "phoneNumber")
            }
          }

          public var preferredLanguage: String? {
            get {
              return resultMap["preferredLanguage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "preferredLanguage")
            }
          }

          public var preferredCurrency: String? {
            get {
              return resultMap["preferredCurrency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "preferredCurrency")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var verification: Verification? {
            get {
              return (resultMap["verification"] as? ResultMap).flatMap { Verification(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "verification")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct Verification: GraphQLSelectionSet {
            public static let possibleTypes = ["UserVerifiedInfo"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("isPhoneVerified", type: .scalar(Bool.self)),
              GraphQLField("isEmailConfirmed", type: .scalar(Bool.self)),
              GraphQLField("isIdVerification", type: .scalar(Bool.self)),
              GraphQLField("isGoogleConnected", type: .scalar(Bool.self)),
              GraphQLField("isFacebookConnected", type: .scalar(Bool.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, isPhoneVerified: Bool? = nil, isEmailConfirmed: Bool? = nil, isIdVerification: Bool? = nil, isGoogleConnected: Bool? = nil, isFacebookConnected: Bool? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserVerifiedInfo", "id": id, "isPhoneVerified": isPhoneVerified, "isEmailConfirmed": isEmailConfirmed, "isIdVerification": isIdVerification, "isGoogleConnected": isGoogleConnected, "isFacebookConnected": isFacebookConnected])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var isPhoneVerified: Bool? {
              get {
                return resultMap["isPhoneVerified"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isPhoneVerified")
              }
            }

            public var isEmailConfirmed: Bool? {
              get {
                return resultMap["isEmailConfirmed"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEmailConfirmed")
              }
            }

            public var isIdVerification: Bool? {
              get {
                return resultMap["isIdVerification"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isIdVerification")
              }
            }

            public var isGoogleConnected: Bool? {
              get {
                return resultMap["isGoogleConnected"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isGoogleConnected")
              }
            }

            public var isFacebookConnected: Bool? {
              get {
                return resultMap["isFacebookConnected"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isFacebookConnected")
              }
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["UserProfile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(type: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserProfile", "type": type])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var type: String? {
              get {
                return resultMap["type"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "type")
              }
            }
          }
        }
      }
    }
  }
}

public final class LogoutMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation Logout($deviceType: String!, $deviceId: String!) {\n  userLogout(deviceType: $deviceType, deviceId: $deviceId) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var deviceType: String
  public var deviceId: String

  public init(deviceType: String, deviceId: String) {
    self.deviceType = deviceType
    self.deviceId = deviceId
  }

  public var variables: GraphQLMap? {
    return ["deviceType": deviceType, "deviceId": deviceId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userLogout", arguments: ["deviceType": GraphQLVariable("deviceType"), "deviceId": GraphQLVariable("deviceId")], type: .object(UserLogout.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userLogout: UserLogout? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "userLogout": userLogout.flatMap { (value: UserLogout) -> ResultMap in value.resultMap }])
    }

    public var userLogout: UserLogout? {
      get {
        return (resultMap["userLogout"] as? ResultMap).flatMap { UserLogout(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userLogout")
      }
    }

    public struct UserLogout: GraphQLSelectionSet {
      public static let possibleTypes = ["UserType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserType", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class SocialLoginVerifyMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation SocialLoginVerify($verificationType: String!, $actionType: String!) {\n  SocialVerification(verificationType: $verificationType, actionType: $actionType) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var verificationType: String
  public var actionType: String

  public init(verificationType: String, actionType: String) {
    self.verificationType = verificationType
    self.actionType = actionType
  }

  public var variables: GraphQLMap? {
    return ["verificationType": verificationType, "actionType": actionType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("SocialVerification", arguments: ["verificationType": GraphQLVariable("verificationType"), "actionType": GraphQLVariable("actionType")], type: .object(SocialVerification.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(socialVerification: SocialVerification? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "SocialVerification": socialVerification.flatMap { (value: SocialVerification) -> ResultMap in value.resultMap }])
    }

    public var socialVerification: SocialVerification? {
      get {
        return (resultMap["SocialVerification"] as? ResultMap).flatMap { SocialVerification(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "SocialVerification")
      }
    }

    public struct SocialVerification: GraphQLSelectionSet {
      public static let possibleTypes = ["SocialVerification"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SocialVerification", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class ResendConfirmEmailQuery: GraphQLQuery {
  public let operationDefinition =
    "query ResendConfirmEmail {\n  ResendConfirmEmail {\n    __typename\n    results {\n      __typename\n      id\n      userId\n      profile {\n        __typename\n        firstName\n        userData {\n          __typename\n          email\n        }\n      }\n      token\n      email\n      status\n    }\n    status\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("ResendConfirmEmail", type: .object(ResendConfirmEmail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(resendConfirmEmail: ResendConfirmEmail? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "ResendConfirmEmail": resendConfirmEmail.flatMap { (value: ResendConfirmEmail) -> ResultMap in value.resultMap }])
    }

    public var resendConfirmEmail: ResendConfirmEmail? {
      get {
        return (resultMap["ResendConfirmEmail"] as? ResultMap).flatMap { ResendConfirmEmail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "ResendConfirmEmail")
      }
    }

    public struct ResendConfirmEmail: GraphQLSelectionSet {
      public static let possibleTypes = ["AllEmailToken"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllEmailToken", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["emailToken"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(String.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("profile", type: .object(Profile.selections)),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String? = nil, userId: String? = nil, profile: Profile? = nil, token: String? = nil, email: String? = nil, status: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "emailToken", "id": id, "userId": userId, "profile": profile.flatMap { (value: Profile) -> ResultMap in value.resultMap }, "token": token, "email": email, "status": status])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String? {
          get {
            return resultMap["id"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var profile: Profile? {
          get {
            return (resultMap["profile"] as? ResultMap).flatMap { Profile(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "profile")
          }
        }

        public var token: String? {
          get {
            return resultMap["token"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "token")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var status: String? {
          get {
            return resultMap["status"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public struct Profile: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(firstName: String? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "firstName": firstName, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["UserType"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("email", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(email: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserType", "email": email])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var email: String? {
              get {
                return resultMap["email"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetCountrycodeQuery: GraphQLQuery {
  public let operationDefinition =
    "query getCountrycode {\n  getCountries {\n    __typename\n    errorMessage\n    status\n    results {\n      __typename\n      id\n      isEnable\n      countryCode\n      countryName\n      dialCode\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getCountries", type: .object(GetCountry.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getCountries: GetCountry? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getCountries": getCountries.flatMap { (value: GetCountry) -> ResultMap in value.resultMap }])
    }

    public var getCountries: GetCountry? {
      get {
        return (resultMap["getCountries"] as? ResultMap).flatMap { GetCountry(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getCountries")
      }
    }

    public struct GetCountry: GraphQLSelectionSet {
      public static let possibleTypes = ["AllCountry"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("results", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(errorMessage: String? = nil, status: Int? = nil, results: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllCountry", "errorMessage": errorMessage, "status": status, "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Country"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("isEnable", type: .scalar(Bool.self)),
          GraphQLField("countryCode", type: .scalar(String.self)),
          GraphQLField("countryName", type: .scalar(String.self)),
          GraphQLField("dialCode", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, isEnable: Bool? = nil, countryCode: String? = nil, countryName: String? = nil, dialCode: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Country", "id": id, "isEnable": isEnable, "countryCode": countryCode, "countryName": countryName, "dialCode": dialCode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var isEnable: Bool? {
          get {
            return resultMap["isEnable"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isEnable")
          }
        }

        public var countryCode: String? {
          get {
            return resultMap["countryCode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "countryCode")
          }
        }

        public var countryName: String? {
          get {
            return resultMap["countryName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "countryName")
          }
        }

        public var dialCode: String? {
          get {
            return resultMap["dialCode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dialCode")
          }
        }
      }
    }
  }
}

public final class GetEnteredPhoneNoQuery: GraphQLQuery {
  public let operationDefinition =
    "query getEnteredPhoneNo {\n  getPhoneData {\n    __typename\n    userId\n    profileId\n    phoneNumber\n    country\n    countryCode\n    verification {\n      __typename\n      id\n      isPhoneVerified\n    }\n    verificationCode\n    status\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getPhoneData", type: .object(GetPhoneDatum.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getPhoneData: GetPhoneDatum? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getPhoneData": getPhoneData.flatMap { (value: GetPhoneDatum) -> ResultMap in value.resultMap }])
    }

    public var getPhoneData: GetPhoneDatum? {
      get {
        return (resultMap["getPhoneData"] as? ResultMap).flatMap { GetPhoneDatum(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getPhoneData")
      }
    }

    public struct GetPhoneDatum: GraphQLSelectionSet {
      public static let possibleTypes = ["UserAccount"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("userId", type: .scalar(GraphQLID.self)),
        GraphQLField("profileId", type: .scalar(Int.self)),
        GraphQLField("phoneNumber", type: .scalar(String.self)),
        GraphQLField("country", type: .scalar(Int.self)),
        GraphQLField("countryCode", type: .scalar(String.self)),
        GraphQLField("verification", type: .object(Verification.selections)),
        GraphQLField("verificationCode", type: .scalar(Int.self)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userId: GraphQLID? = nil, profileId: Int? = nil, phoneNumber: String? = nil, country: Int? = nil, countryCode: String? = nil, verification: Verification? = nil, verificationCode: Int? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserAccount", "userId": userId, "profileId": profileId, "phoneNumber": phoneNumber, "country": country, "countryCode": countryCode, "verification": verification.flatMap { (value: Verification) -> ResultMap in value.resultMap }, "verificationCode": verificationCode, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userId: GraphQLID? {
        get {
          return resultMap["userId"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var profileId: Int? {
        get {
          return resultMap["profileId"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileId")
        }
      }

      public var phoneNumber: String? {
        get {
          return resultMap["phoneNumber"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phoneNumber")
        }
      }

      public var country: Int? {
        get {
          return resultMap["country"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "country")
        }
      }

      public var countryCode: String? {
        get {
          return resultMap["countryCode"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "countryCode")
        }
      }

      public var verification: Verification? {
        get {
          return (resultMap["verification"] as? ResultMap).flatMap { Verification(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "verification")
        }
      }

      public var verificationCode: Int? {
        get {
          return resultMap["verificationCode"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "verificationCode")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Verification: GraphQLSelectionSet {
        public static let possibleTypes = ["UserVerifiedInfo"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("isPhoneVerified", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, isPhoneVerified: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserVerifiedInfo", "id": id, "isPhoneVerified": isPhoneVerified])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var isPhoneVerified: Bool? {
          get {
            return resultMap["isPhoneVerified"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPhoneVerified")
          }
        }
      }
    }
  }
}

public final class AddPhoneNumberMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation AddPhoneNumber($countryCode: String!, $phoneNumber: String!) {\n  AddPhoneNumber(countryCode: $countryCode, phoneNumber: $phoneNumber) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var countryCode: String
  public var phoneNumber: String

  public init(countryCode: String, phoneNumber: String) {
    self.countryCode = countryCode
    self.phoneNumber = phoneNumber
  }

  public var variables: GraphQLMap? {
    return ["countryCode": countryCode, "phoneNumber": phoneNumber]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("AddPhoneNumber", arguments: ["countryCode": GraphQLVariable("countryCode"), "phoneNumber": GraphQLVariable("phoneNumber")], type: .object(AddPhoneNumber.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addPhoneNumber: AddPhoneNumber? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "AddPhoneNumber": addPhoneNumber.flatMap { (value: AddPhoneNumber) -> ResultMap in value.resultMap }])
    }

    public var addPhoneNumber: AddPhoneNumber? {
      get {
        return (resultMap["AddPhoneNumber"] as? ResultMap).flatMap { AddPhoneNumber(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "AddPhoneNumber")
      }
    }

    public struct AddPhoneNumber: GraphQLSelectionSet {
      public static let possibleTypes = ["UserAccount"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserAccount", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class VerifyPhoneNumberMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation VerifyPhoneNumber($verificationCode: Int!) {\n  VerifyPhoneNumber(verificationCode: $verificationCode) {\n    __typename\n    status\n  }\n}"

  public var verificationCode: Int

  public init(verificationCode: Int) {
    self.verificationCode = verificationCode
  }

  public var variables: GraphQLMap? {
    return ["verificationCode": verificationCode]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("VerifyPhoneNumber", arguments: ["verificationCode": GraphQLVariable("verificationCode")], type: .object(VerifyPhoneNumber.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(verifyPhoneNumber: VerifyPhoneNumber? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "VerifyPhoneNumber": verifyPhoneNumber.flatMap { (value: VerifyPhoneNumber) -> ResultMap in value.resultMap }])
    }

    public var verifyPhoneNumber: VerifyPhoneNumber? {
      get {
        return (resultMap["VerifyPhoneNumber"] as? ResultMap).flatMap { VerifyPhoneNumber(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "VerifyPhoneNumber")
      }
    }

    public struct VerifyPhoneNumber: GraphQLSelectionSet {
      public static let possibleTypes = ["UserAccount"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserAccount", "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}

public final class UserLanguageQuery: GraphQLQuery {
  public let operationDefinition =
    "query userLanguage {\n  userLanguages {\n    __typename\n    status\n    errorMessage\n    result {\n      __typename\n      label\n      value\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userLanguages", type: .object(UserLanguage.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userLanguages: UserLanguage? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "userLanguages": userLanguages.flatMap { (value: UserLanguage) -> ResultMap in value.resultMap }])
    }

    public var userLanguages: UserLanguage? {
      get {
        return (resultMap["userLanguages"] as? ResultMap).flatMap { UserLanguage(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userLanguages")
      }
    }

    public struct UserLanguage: GraphQLSelectionSet {
      public static let possibleTypes = ["UserLanguagesType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("result", type: .list(.object(Result.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, result: [Result?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserLanguagesType", "status": status, "errorMessage": errorMessage, "result": result.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var result: [Result?]? {
        get {
          return (resultMap["result"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "result")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["LanguageItemType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("label", type: .scalar(String.self)),
          GraphQLField("value", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(label: String? = nil, value: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "LanguageItemType", "label": label, "value": value])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var label: String? {
          get {
            return resultMap["label"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "label")
          }
        }

        public var value: String? {
          get {
            return resultMap["value"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "value")
          }
        }
      }
    }
  }
}

public final class GetCurrenciesListQuery: GraphQLQuery {
  public let operationDefinition =
    "query getCurrenciesList {\n  getCurrencies {\n    __typename\n    results {\n      __typename\n      id\n      symbol\n      isEnable\n      isPayment\n      isBaseCurrency\n    }\n    status\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getCurrencies", type: .object(GetCurrency.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getCurrencies: GetCurrency? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getCurrencies": getCurrencies.flatMap { (value: GetCurrency) -> ResultMap in value.resultMap }])
    }

    public var getCurrencies: GetCurrency? {
      get {
        return (resultMap["getCurrencies"] as? ResultMap).flatMap { GetCurrency(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getCurrencies")
      }
    }

    public struct GetCurrency: GraphQLSelectionSet {
      public static let possibleTypes = ["AllCurrenciesType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllCurrenciesType", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Currencies"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("symbol", type: .scalar(String.self)),
          GraphQLField("isEnable", type: .scalar(Bool.self)),
          GraphQLField("isPayment", type: .scalar(Bool.self)),
          GraphQLField("isBaseCurrency", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, symbol: String? = nil, isEnable: Bool? = nil, isPayment: Bool? = nil, isBaseCurrency: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "Currencies", "id": id, "symbol": symbol, "isEnable": isEnable, "isPayment": isPayment, "isBaseCurrency": isBaseCurrency])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var symbol: String? {
          get {
            return resultMap["symbol"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "symbol")
          }
        }

        public var isEnable: Bool? {
          get {
            return resultMap["isEnable"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isEnable")
          }
        }

        public var isPayment: Bool? {
          get {
            return resultMap["isPayment"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPayment")
          }
        }

        public var isBaseCurrency: Bool? {
          get {
            return resultMap["isBaseCurrency"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isBaseCurrency")
          }
        }
      }
    }
  }
}

public final class ContactSupportQuery: GraphQLQuery {
  public let operationDefinition =
    "query contactSupport($message: String, $listId: Int, $reservationId: Int, $userType: String) {\n  contactSupport(message: $message, listId: $listId, reservationId: $reservationId, userType: $userType) {\n    __typename\n    result {\n      __typename\n      userId\n      email\n      firstName\n    }\n    status\n    errorMessage\n  }\n}"

  public var message: String?
  public var listId: Int?
  public var reservationId: Int?
  public var userType: String?

  public init(message: String? = nil, listId: Int? = nil, reservationId: Int? = nil, userType: String? = nil) {
    self.message = message
    self.listId = listId
    self.reservationId = reservationId
    self.userType = userType
  }

  public var variables: GraphQLMap? {
    return ["message": message, "listId": listId, "reservationId": reservationId, "userType": userType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("contactSupport", arguments: ["message": GraphQLVariable("message"), "listId": GraphQLVariable("listId"), "reservationId": GraphQLVariable("reservationId"), "userType": GraphQLVariable("userType")], type: .object(ContactSupport.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(contactSupport: ContactSupport? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "contactSupport": contactSupport.flatMap { (value: ContactSupport) -> ResultMap in value.resultMap }])
    }

    public var contactSupport: ContactSupport? {
      get {
        return (resultMap["contactSupport"] as? ResultMap).flatMap { ContactSupport(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "contactSupport")
      }
    }

    public struct ContactSupport: GraphQLSelectionSet {
      public static let possibleTypes = ["UserCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserCommon", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["UserType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("email", type: .scalar(String.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: String? = nil, email: String? = nil, firstName: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserType", "userId": userId, "email": email, "firstName": firstName])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var email: String? {
          get {
            return resultMap["email"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }
      }
    }
  }
}

public final class PreapproveMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation preapprove($threadId: Int!, $content: String, $type: String, $startDate: String, $endDate: String, $personCapacity: Int, $reservationId: Int) {\n  sendMessage(threadId: $threadId, content: $content, type: $type, startDate: $startDate, endDate: $endDate, personCapacity: $personCapacity, reservationId: $reservationId) {\n    __typename\n    results {\n      __typename\n      id\n      sentBy\n      content\n      type\n      reservationId\n      startDate\n      endDate\n      createdAt\n      personCapacity\n    }\n    status\n    errorMessage\n  }\n}"

  public var threadId: Int
  public var content: String?
  public var type: String?
  public var startDate: String?
  public var endDate: String?
  public var personCapacity: Int?
  public var reservationId: Int?

  public init(threadId: Int, content: String? = nil, type: String? = nil, startDate: String? = nil, endDate: String? = nil, personCapacity: Int? = nil, reservationId: Int? = nil) {
    self.threadId = threadId
    self.content = content
    self.type = type
    self.startDate = startDate
    self.endDate = endDate
    self.personCapacity = personCapacity
    self.reservationId = reservationId
  }

  public var variables: GraphQLMap? {
    return ["threadId": threadId, "content": content, "type": type, "startDate": startDate, "endDate": endDate, "personCapacity": personCapacity, "reservationId": reservationId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("sendMessage", arguments: ["threadId": GraphQLVariable("threadId"), "content": GraphQLVariable("content"), "type": GraphQLVariable("type"), "startDate": GraphQLVariable("startDate"), "endDate": GraphQLVariable("endDate"), "personCapacity": GraphQLVariable("personCapacity"), "reservationId": GraphQLVariable("reservationId")], type: .object(SendMessage.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(sendMessage: SendMessage? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "sendMessage": sendMessage.flatMap { (value: SendMessage) -> ResultMap in value.resultMap }])
    }

    public var sendMessage: SendMessage? {
      get {
        return (resultMap["sendMessage"] as? ResultMap).flatMap { SendMessage(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "sendMessage")
      }
    }

    public struct SendMessage: GraphQLSelectionSet {
      public static let possibleTypes = ["SendMessage"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "SendMessage", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ThreadItems"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("sentBy", type: .scalar(String.self)),
          GraphQLField("content", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(String.self)),
          GraphQLField("reservationId", type: .scalar(Int.self)),
          GraphQLField("startDate", type: .scalar(String.self)),
          GraphQLField("endDate", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, sentBy: String? = nil, content: String? = nil, type: String? = nil, reservationId: Int? = nil, startDate: String? = nil, endDate: String? = nil, createdAt: String? = nil, personCapacity: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "ThreadItems", "id": id, "sentBy": sentBy, "content": content, "type": type, "reservationId": reservationId, "startDate": startDate, "endDate": endDate, "createdAt": createdAt, "personCapacity": personCapacity])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var sentBy: String? {
          get {
            return resultMap["sentBy"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "sentBy")
          }
        }

        public var content: String? {
          get {
            return resultMap["content"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "content")
          }
        }

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var reservationId: Int? {
          get {
            return resultMap["reservationId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationId")
          }
        }

        public var startDate: String? {
          get {
            return resultMap["startDate"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "startDate")
          }
        }

        public var endDate: String? {
          get {
            return resultMap["endDate"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "endDate")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }
      }
    }
  }
}

public final class GetSimilarListingQuery: GraphQLQuery {
  public let operationDefinition =
    "query getSimilarListing($lat: Float, $lng: Float, $listId: Int) {\n  getSimilarListing(listId: $listId, lat: $lat, lng: $lng) {\n    __typename\n    results {\n      __typename\n      id\n      title\n      personCapacity\n      beds\n      bookingType\n      reviewsCount\n      reviewsStarRating\n      listingData {\n        __typename\n        basePrice\n        currency\n        cleaningPrice\n      }\n      wishListStatus\n      isListOwner\n      listPhotoName\n      roomType\n    }\n    status\n  }\n}"

  public var lat: Double?
  public var lng: Double?
  public var listId: Int?

  public init(lat: Double? = nil, lng: Double? = nil, listId: Int? = nil) {
    self.lat = lat
    self.lng = lng
    self.listId = listId
  }

  public var variables: GraphQLMap? {
    return ["lat": lat, "lng": lng, "listId": listId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getSimilarListing", arguments: ["listId": GraphQLVariable("listId"), "lat": GraphQLVariable("lat"), "lng": GraphQLVariable("lng")], type: .object(GetSimilarListing.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getSimilarListing: GetSimilarListing? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getSimilarListing": getSimilarListing.flatMap { (value: GetSimilarListing) -> ResultMap in value.resultMap }])
    }

    public var getSimilarListing: GetSimilarListing? {
      get {
        return (resultMap["getSimilarListing"] as? ResultMap).flatMap { GetSimilarListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getSimilarListing")
      }
    }

    public struct GetSimilarListing: GraphQLSelectionSet {
      public static let possibleTypes = ["AllList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllList", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("bookingType", type: .scalar(String.self)),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
          GraphQLField("listingData", type: .object(ListingDatum.selections)),
          GraphQLField("wishListStatus", type: .scalar(Bool.self)),
          GraphQLField("isListOwner", type: .scalar(Bool.self)),
          GraphQLField("listPhotoName", type: .scalar(String.self)),
          GraphQLField("roomType", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, personCapacity: Int? = nil, beds: Int? = nil, bookingType: String? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, listingData: ListingDatum? = nil, wishListStatus: Bool? = nil, isListOwner: Bool? = nil, listPhotoName: String? = nil, roomType: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "personCapacity": personCapacity, "beds": beds, "bookingType": bookingType, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "wishListStatus": wishListStatus, "isListOwner": isListOwner, "listPhotoName": listPhotoName, "roomType": roomType])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var bookingType: String? {
          get {
            return resultMap["bookingType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingType")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var reviewsStarRating: Int? {
          get {
            return resultMap["reviewsStarRating"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsStarRating")
          }
        }

        public var listingData: ListingDatum? {
          get {
            return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
          }
        }

        public var wishListStatus: Bool? {
          get {
            return resultMap["wishListStatus"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListStatus")
          }
        }

        public var isListOwner: Bool? {
          get {
            return resultMap["isListOwner"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isListOwner")
          }
        }

        public var listPhotoName: String? {
          get {
            return resultMap["listPhotoName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listPhotoName")
          }
        }

        public var roomType: String? {
          get {
            return resultMap["roomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "roomType")
          }
        }

        public struct ListingDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["listingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("basePrice", type: .scalar(Double.self)),
            GraphQLField("currency", type: .scalar(String.self)),
            GraphQLField("cleaningPrice", type: .scalar(Double.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(basePrice: Double? = nil, currency: String? = nil, cleaningPrice: Double? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency, "cleaningPrice": cleaningPrice])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var basePrice: Double? {
            get {
              return resultMap["basePrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "basePrice")
            }
          }

          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }

          public var cleaningPrice: Double? {
            get {
              return resultMap["cleaningPrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "cleaningPrice")
            }
          }
        }
      }
    }
  }
}

public final class UserReviewsQuery: GraphQLQuery {
  public let operationDefinition =
    "query userReviews($ownerType: String, $currentPage: Int, $profileId: Int) {\n  userReviews(ownerType: $ownerType, currentPage: $currentPage, profileId: $profileId) {\n    __typename\n    results {\n      __typename\n      id\n      reservationId\n      listId\n      authorId\n      userId\n      reviewContent\n      rating\n      parentId\n      automated\n      createdAt\n      status\n      isAdmin\n      yourReviewsCount\n      reviewsCount\n      authorData {\n        __typename\n        ...profileFields\n      }\n      userData {\n        __typename\n        ...profileFields\n      }\n      response {\n        __typename\n        id\n        reservationId\n        listId\n        authorId\n        userId\n        reviewContent\n        rating\n        parentId\n        automated\n        createdAt\n        status\n        isAdmin\n        authorData {\n          __typename\n          ...profileFields\n        }\n        userData {\n          __typename\n          ...profileFields\n        }\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(ProfileFields.fragmentDefinition) }

  public var ownerType: String?
  public var currentPage: Int?
  public var profileId: Int?

  public init(ownerType: String? = nil, currentPage: Int? = nil, profileId: Int? = nil) {
    self.ownerType = ownerType
    self.currentPage = currentPage
    self.profileId = profileId
  }

  public var variables: GraphQLMap? {
    return ["ownerType": ownerType, "currentPage": currentPage, "profileId": profileId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userReviews", arguments: ["ownerType": GraphQLVariable("ownerType"), "currentPage": GraphQLVariable("currentPage"), "profileId": GraphQLVariable("profileId")], type: .object(UserReview.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userReviews: UserReview? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "userReviews": userReviews.flatMap { (value: UserReview) -> ResultMap in value.resultMap }])
    }

    public var userReviews: UserReview? {
      get {
        return (resultMap["userReviews"] as? ResultMap).flatMap { UserReview(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userReviews")
      }
    }

    public struct UserReview: GraphQLSelectionSet {
      public static let possibleTypes = ["Reviewlist"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Reviewlist", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Reviews"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("reservationId", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("authorId", type: .scalar(String.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("reviewContent", type: .scalar(String.self)),
          GraphQLField("rating", type: .scalar(Double.self)),
          GraphQLField("parentId", type: .scalar(Int.self)),
          GraphQLField("automated", type: .scalar(Bool.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(String.self)),
          GraphQLField("isAdmin", type: .scalar(Bool.self)),
          GraphQLField("yourReviewsCount", type: .scalar(Int.self)),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("authorData", type: .object(AuthorDatum.selections)),
          GraphQLField("userData", type: .object(UserDatum.selections)),
          GraphQLField("response", type: .object(Response.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, reservationId: Int? = nil, listId: Int? = nil, authorId: String? = nil, userId: String? = nil, reviewContent: String? = nil, rating: Double? = nil, parentId: Int? = nil, automated: Bool? = nil, createdAt: String? = nil, status: String? = nil, isAdmin: Bool? = nil, yourReviewsCount: Int? = nil, reviewsCount: Int? = nil, authorData: AuthorDatum? = nil, userData: UserDatum? = nil, response: Response? = nil) {
          self.init(unsafeResultMap: ["__typename": "Reviews", "id": id, "reservationId": reservationId, "listId": listId, "authorId": authorId, "userId": userId, "reviewContent": reviewContent, "rating": rating, "parentId": parentId, "automated": automated, "createdAt": createdAt, "status": status, "isAdmin": isAdmin, "yourReviewsCount": yourReviewsCount, "reviewsCount": reviewsCount, "authorData": authorData.flatMap { (value: AuthorDatum) -> ResultMap in value.resultMap }, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }, "response": response.flatMap { (value: Response) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var reservationId: Int? {
          get {
            return resultMap["reservationId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationId")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var authorId: String? {
          get {
            return resultMap["authorId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "authorId")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var reviewContent: String? {
          get {
            return resultMap["reviewContent"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewContent")
          }
        }

        public var rating: Double? {
          get {
            return resultMap["rating"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "rating")
          }
        }

        public var parentId: Int? {
          get {
            return resultMap["parentId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "parentId")
          }
        }

        public var automated: Bool? {
          get {
            return resultMap["automated"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "automated")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var status: String? {
          get {
            return resultMap["status"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public var isAdmin: Bool? {
          get {
            return resultMap["isAdmin"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isAdmin")
          }
        }

        public var yourReviewsCount: Int? {
          get {
            return resultMap["yourReviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "yourReviewsCount")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var authorData: AuthorDatum? {
          get {
            return (resultMap["authorData"] as? ResultMap).flatMap { AuthorDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "authorData")
          }
        }

        public var userData: UserDatum? {
          get {
            return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "userData")
          }
        }

        public var response: Response? {
          get {
            return (resultMap["response"] as? ResultMap).flatMap { Response(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "response")
          }
        }

        public struct AuthorDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(ProfileFields.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil, location: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture, "location": location])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var profileFields: ProfileFields {
              get {
                return ProfileFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }

        public struct UserDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(ProfileFields.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil, location: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture, "location": location])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var profileFields: ProfileFields {
              get {
                return ProfileFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }

        public struct Response: GraphQLSelectionSet {
          public static let possibleTypes = ["ReviewResponse"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("reservationId", type: .scalar(Int.self)),
            GraphQLField("listId", type: .scalar(Int.self)),
            GraphQLField("authorId", type: .scalar(String.self)),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("reviewContent", type: .scalar(String.self)),
            GraphQLField("rating", type: .scalar(Double.self)),
            GraphQLField("parentId", type: .scalar(Int.self)),
            GraphQLField("automated", type: .scalar(Bool.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
            GraphQLField("status", type: .scalar(String.self)),
            GraphQLField("isAdmin", type: .scalar(Bool.self)),
            GraphQLField("authorData", type: .object(AuthorDatum.selections)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, reservationId: Int? = nil, listId: Int? = nil, authorId: String? = nil, userId: String? = nil, reviewContent: String? = nil, rating: Double? = nil, parentId: Int? = nil, automated: Bool? = nil, createdAt: String? = nil, status: String? = nil, isAdmin: Bool? = nil, authorData: AuthorDatum? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "ReviewResponse", "id": id, "reservationId": reservationId, "listId": listId, "authorId": authorId, "userId": userId, "reviewContent": reviewContent, "rating": rating, "parentId": parentId, "automated": automated, "createdAt": createdAt, "status": status, "isAdmin": isAdmin, "authorData": authorData.flatMap { (value: AuthorDatum) -> ResultMap in value.resultMap }, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var reservationId: Int? {
            get {
              return resultMap["reservationId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reservationId")
            }
          }

          public var listId: Int? {
            get {
              return resultMap["listId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "listId")
            }
          }

          public var authorId: String? {
            get {
              return resultMap["authorId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "authorId")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var reviewContent: String? {
            get {
              return resultMap["reviewContent"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewContent")
            }
          }

          public var rating: Double? {
            get {
              return resultMap["rating"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "rating")
            }
          }

          public var parentId: Int? {
            get {
              return resultMap["parentId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "parentId")
            }
          }

          public var automated: Bool? {
            get {
              return resultMap["automated"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "automated")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }

          public var isAdmin: Bool? {
            get {
              return resultMap["isAdmin"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isAdmin")
            }
          }

          public var authorData: AuthorDatum? {
            get {
              return (resultMap["authorData"] as? ResultMap).flatMap { AuthorDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "authorData")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct AuthorDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["userProfile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ProfileFields.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil, location: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture, "location": location])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var profileFields: ProfileFields {
                get {
                  return ProfileFields(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["userProfile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ProfileFields.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil, location: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture, "location": location])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var profileFields: ProfileFields {
                get {
                  return ProfileFields(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class GetReviewsListQuery: GraphQLQuery {
  public let operationDefinition =
    "query getReviewsList($listId: Int, $currentPage: Int, $hostId: String!) {\n  getReviews(listId: $listId, currentPage: $currentPage, hostId: $hostId) {\n    __typename\n    results {\n      __typename\n      id\n      userId\n      reviewContent\n      rating\n      createdAt\n      isAdmin\n      userData {\n        __typename\n        userId\n        profileId\n        firstName\n        lastName\n        picture\n      }\n      authorData {\n        __typename\n        userId\n        profileId\n        firstName\n        lastName\n        picture\n      }\n    }\n    status\n    count\n  }\n}"

  public var listId: Int?
  public var currentPage: Int?
  public var hostId: String

  public init(listId: Int? = nil, currentPage: Int? = nil, hostId: String) {
    self.listId = listId
    self.currentPage = currentPage
    self.hostId = hostId
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "currentPage": currentPage, "hostId": hostId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getReviews", arguments: ["listId": GraphQLVariable("listId"), "currentPage": GraphQLVariable("currentPage"), "hostId": GraphQLVariable("hostId")], type: .object(GetReview.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getReviews: GetReview? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getReviews": getReviews.flatMap { (value: GetReview) -> ResultMap in value.resultMap }])
    }

    public var getReviews: GetReview? {
      get {
        return (resultMap["getReviews"] as? ResultMap).flatMap { GetReview(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getReviews")
      }
    }

    public struct GetReview: GraphQLSelectionSet {
      public static let possibleTypes = ["AllReview"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("count", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, count: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllReview", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "count": count])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Reviews"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("reviewContent", type: .scalar(String.self)),
          GraphQLField("rating", type: .scalar(Double.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("isAdmin", type: .scalar(Bool.self)),
          GraphQLField("userData", type: .object(UserDatum.selections)),
          GraphQLField("authorData", type: .object(AuthorDatum.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, userId: String? = nil, reviewContent: String? = nil, rating: Double? = nil, createdAt: String? = nil, isAdmin: Bool? = nil, userData: UserDatum? = nil, authorData: AuthorDatum? = nil) {
          self.init(unsafeResultMap: ["__typename": "Reviews", "id": id, "userId": userId, "reviewContent": reviewContent, "rating": rating, "createdAt": createdAt, "isAdmin": isAdmin, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }, "authorData": authorData.flatMap { (value: AuthorDatum) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var reviewContent: String? {
          get {
            return resultMap["reviewContent"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewContent")
          }
        }

        public var rating: Double? {
          get {
            return resultMap["rating"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "rating")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var isAdmin: Bool? {
          get {
            return resultMap["isAdmin"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isAdmin")
          }
        }

        public var userData: UserDatum? {
          get {
            return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "userData")
          }
        }

        public var authorData: AuthorDatum? {
          get {
            return (resultMap["authorData"] as? ResultMap).flatMap { AuthorDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "authorData")
          }
        }

        public struct UserDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userId: String? = nil, profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "userId": userId, "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }
        }

        public struct AuthorDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userId: String? = nil, profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "userId": userId, "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }
        }
      }
    }
  }
}

public final class GetAllReservationQuery: GraphQLQuery {
  public let operationDefinition =
    "query getAllReservation($userType: String, $currentPage: Int, $dateFilter: String) {\n  getAllReservation(userType: $userType, currentPage: $currentPage, dateFilter: $dateFilter) {\n    __typename\n    result {\n      __typename\n      id\n      listId\n      hostId\n      guestId\n      checkIn\n      checkOut\n      guests\n      guestServiceFee\n      hostServiceFee\n      reservationState\n      total\n      currency\n      messageData {\n        __typename\n        id\n      }\n      listData {\n        __typename\n        id\n        title\n        street\n        city\n        state\n        country\n        zipcode\n        reviewsCount\n        reviewsStarRating\n        roomType\n        bookingType\n        wishListStatus\n        listPhotoName\n        listPhotos {\n          __typename\n          id\n          name\n        }\n        listingData {\n          __typename\n          currency\n          basePrice\n          checkInStart\n          checkInEnd\n        }\n        settingsData {\n          __typename\n          id\n          listsettings {\n            __typename\n            id\n            itemName\n          }\n        }\n      }\n      hostData {\n        __typename\n        profileId\n        displayName\n        picture\n        phoneNumber\n        userId\n        userData {\n          __typename\n          email\n        }\n      }\n      guestData {\n        __typename\n        profileId\n        displayName\n        picture\n        phoneNumber\n        userId\n        userData {\n          __typename\n          email\n        }\n      }\n    }\n    count\n    status\n  }\n}"

  public var userType: String?
  public var currentPage: Int?
  public var dateFilter: String?

  public init(userType: String? = nil, currentPage: Int? = nil, dateFilter: String? = nil) {
    self.userType = userType
    self.currentPage = currentPage
    self.dateFilter = dateFilter
  }

  public var variables: GraphQLMap? {
    return ["userType": userType, "currentPage": currentPage, "dateFilter": dateFilter]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getAllReservation", arguments: ["userType": GraphQLVariable("userType"), "currentPage": GraphQLVariable("currentPage"), "dateFilter": GraphQLVariable("dateFilter")], type: .object(GetAllReservation.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAllReservation: GetAllReservation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAllReservation": getAllReservation.flatMap { (value: GetAllReservation) -> ResultMap in value.resultMap }])
    }

    public var getAllReservation: GetAllReservation? {
      get {
        return (resultMap["getAllReservation"] as? ResultMap).flatMap { GetAllReservation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getAllReservation")
      }
    }

    public struct GetAllReservation: GraphQLSelectionSet {
      public static let possibleTypes = ["AllReservation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .list(.object(Result.selections))),
        GraphQLField("count", type: .scalar(Int.self)),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: [Result?]? = nil, count: Int? = nil, status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllReservation", "result": result.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "count": count, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: [Result?]? {
        get {
          return (resultMap["result"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "result")
        }
      }

      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["Reservation"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("hostId", type: .scalar(String.self)),
          GraphQLField("guestId", type: .scalar(String.self)),
          GraphQLField("checkIn", type: .scalar(String.self)),
          GraphQLField("checkOut", type: .scalar(String.self)),
          GraphQLField("guests", type: .scalar(Int.self)),
          GraphQLField("guestServiceFee", type: .scalar(Double.self)),
          GraphQLField("hostServiceFee", type: .scalar(Double.self)),
          GraphQLField("reservationState", type: .scalar(String.self)),
          GraphQLField("total", type: .scalar(Double.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("messageData", type: .object(MessageDatum.selections)),
          GraphQLField("listData", type: .object(ListDatum.selections)),
          GraphQLField("hostData", type: .object(HostDatum.selections)),
          GraphQLField("guestData", type: .object(GuestDatum.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, hostId: String? = nil, guestId: String? = nil, checkIn: String? = nil, checkOut: String? = nil, guests: Int? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, reservationState: String? = nil, total: Double? = nil, currency: String? = nil, messageData: MessageDatum? = nil, listData: ListDatum? = nil, hostData: HostDatum? = nil, guestData: GuestDatum? = nil) {
          self.init(unsafeResultMap: ["__typename": "Reservation", "id": id, "listId": listId, "hostId": hostId, "guestId": guestId, "checkIn": checkIn, "checkOut": checkOut, "guests": guests, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "reservationState": reservationState, "total": total, "currency": currency, "messageData": messageData.flatMap { (value: MessageDatum) -> ResultMap in value.resultMap }, "listData": listData.flatMap { (value: ListDatum) -> ResultMap in value.resultMap }, "hostData": hostData.flatMap { (value: HostDatum) -> ResultMap in value.resultMap }, "guestData": guestData.flatMap { (value: GuestDatum) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var hostId: String? {
          get {
            return resultMap["hostId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostId")
          }
        }

        public var guestId: String? {
          get {
            return resultMap["guestId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestId")
          }
        }

        public var checkIn: String? {
          get {
            return resultMap["checkIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkIn")
          }
        }

        public var checkOut: String? {
          get {
            return resultMap["checkOut"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkOut")
          }
        }

        public var guests: Int? {
          get {
            return resultMap["guests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "guests")
          }
        }

        public var guestServiceFee: Double? {
          get {
            return resultMap["guestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFee")
          }
        }

        public var hostServiceFee: Double? {
          get {
            return resultMap["hostServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFee")
          }
        }

        public var reservationState: String? {
          get {
            return resultMap["reservationState"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationState")
          }
        }

        public var total: Double? {
          get {
            return resultMap["total"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "total")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var messageData: MessageDatum? {
          get {
            return (resultMap["messageData"] as? ResultMap).flatMap { MessageDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "messageData")
          }
        }

        public var listData: ListDatum? {
          get {
            return (resultMap["listData"] as? ResultMap).flatMap { ListDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listData")
          }
        }

        public var hostData: HostDatum? {
          get {
            return (resultMap["hostData"] as? ResultMap).flatMap { HostDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "hostData")
          }
        }

        public var guestData: GuestDatum? {
          get {
            return (resultMap["guestData"] as? ResultMap).flatMap { GuestDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "guestData")
          }
        }

        public struct MessageDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["Threads"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "Threads", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }

        public struct ListDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["ShowListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("street", type: .scalar(String.self)),
            GraphQLField("city", type: .scalar(String.self)),
            GraphQLField("state", type: .scalar(String.self)),
            GraphQLField("country", type: .scalar(String.self)),
            GraphQLField("zipcode", type: .scalar(String.self)),
            GraphQLField("reviewsCount", type: .scalar(Int.self)),
            GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
            GraphQLField("roomType", type: .scalar(String.self)),
            GraphQLField("bookingType", type: .scalar(String.self)),
            GraphQLField("wishListStatus", type: .scalar(Bool.self)),
            GraphQLField("listPhotoName", type: .scalar(String.self)),
            GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
            GraphQLField("listingData", type: .object(ListingDatum.selections)),
            GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, title: String? = nil, street: String? = nil, city: String? = nil, state: String? = nil, country: String? = nil, zipcode: String? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, roomType: String? = nil, bookingType: String? = nil, wishListStatus: Bool? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil, settingsData: [SettingsDatum?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "street": street, "city": city, "state": state, "country": country, "zipcode": zipcode, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "roomType": roomType, "bookingType": bookingType, "wishListStatus": wishListStatus, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var street: String? {
            get {
              return resultMap["street"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "street")
            }
          }

          public var city: String? {
            get {
              return resultMap["city"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var state: String? {
            get {
              return resultMap["state"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var country: String? {
            get {
              return resultMap["country"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "country")
            }
          }

          public var zipcode: String? {
            get {
              return resultMap["zipcode"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipcode")
            }
          }

          public var reviewsCount: Int? {
            get {
              return resultMap["reviewsCount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsCount")
            }
          }

          public var reviewsStarRating: Int? {
            get {
              return resultMap["reviewsStarRating"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsStarRating")
            }
          }

          public var roomType: String? {
            get {
              return resultMap["roomType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "roomType")
            }
          }

          public var bookingType: String? {
            get {
              return resultMap["bookingType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "bookingType")
            }
          }

          public var wishListStatus: Bool? {
            get {
              return resultMap["wishListStatus"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "wishListStatus")
            }
          }

          public var listPhotoName: String? {
            get {
              return resultMap["listPhotoName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "listPhotoName")
            }
          }

          public var listPhotos: [ListPhoto?]? {
            get {
              return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
            }
          }

          public var listingData: ListingDatum? {
            get {
              return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
            }
          }

          public var settingsData: [SettingsDatum?]? {
            get {
              return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
            }
          }

          public struct ListPhoto: GraphQLSelectionSet {
            public static let possibleTypes = ["listPhotosData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct ListingDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["listingData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("currency", type: .scalar(String.self)),
              GraphQLField("basePrice", type: .scalar(Double.self)),
              GraphQLField("checkInStart", type: .scalar(String.self)),
              GraphQLField("checkInEnd", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(currency: String? = nil, basePrice: Double? = nil, checkInStart: String? = nil, checkInEnd: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingData", "currency": currency, "basePrice": basePrice, "checkInStart": checkInStart, "checkInEnd": checkInEnd])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var currency: String? {
              get {
                return resultMap["currency"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "currency")
              }
            }

            public var basePrice: Double? {
              get {
                return resultMap["basePrice"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "basePrice")
              }
            }

            public var checkInStart: String? {
              get {
                return resultMap["checkInStart"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "checkInStart")
              }
            }

            public var checkInEnd: String? {
              get {
                return resultMap["checkInEnd"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "checkInEnd")
              }
            }
          }

          public struct SettingsDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["userListingData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("listsettings", type: .object(Listsetting.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, listsettings: Listsetting? = nil) {
              self.init(unsafeResultMap: ["__typename": "userListingData", "id": id, "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var listsettings: Listsetting? {
              get {
                return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
              }
            }

            public struct Listsetting: GraphQLSelectionSet {
              public static let possibleTypes = ["singleListSettings"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .scalar(Int.self)),
                GraphQLField("itemName", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: Int? = nil, itemName: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: Int? {
                get {
                  return resultMap["id"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var itemName: String? {
                get {
                  return resultMap["itemName"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "itemName")
                }
              }
            }
          }
        }

        public struct HostDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("phoneNumber", type: .scalar(String.self)),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(profileId: Int? = nil, displayName: String? = nil, picture: String? = nil, phoneNumber: String? = nil, userId: String? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "displayName": displayName, "picture": picture, "phoneNumber": phoneNumber, "userId": userId, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var phoneNumber: String? {
            get {
              return resultMap["phoneNumber"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "phoneNumber")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["UserType"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("email", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(email: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserType", "email": email])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var email: String? {
              get {
                return resultMap["email"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }
          }
        }

        public struct GuestDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileId", type: .scalar(Int.self)),
            GraphQLField("displayName", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("phoneNumber", type: .scalar(String.self)),
            GraphQLField("userId", type: .scalar(String.self)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(profileId: Int? = nil, displayName: String? = nil, picture: String? = nil, phoneNumber: String? = nil, userId: String? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "displayName": displayName, "picture": picture, "phoneNumber": phoneNumber, "userId": userId, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var profileId: Int? {
            get {
              return resultMap["profileId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "profileId")
            }
          }

          public var displayName: String? {
            get {
              return resultMap["displayName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayName")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var phoneNumber: String? {
            get {
              return resultMap["phoneNumber"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "phoneNumber")
            }
          }

          public var userId: String? {
            get {
              return resultMap["userId"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["UserType"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("email", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(email: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserType", "email": email])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var email: String? {
              get {
                return resultMap["email"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "email")
              }
            }
          }
        }
      }
    }
  }
}

public final class CreateListingMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation createListing($listId: Int, $roomType: String, $houseType: String, $residenceType: String, $bedrooms: String, $buildingSize: String, $bedType: String, $beds: Int, $personCapacity: Int, $bathrooms: Float, $bathroomType: String, $country: String, $street: String, $buildingName: String, $city: String, $state: String, $zipcode: String, $lat: Float, $lng: Float, $bedTypes: String, $isMapTouched: Boolean, $amenities: [Int], $safetyAmenities: [Int], $spaces: [Int]) {\n  createListing(listId: $listId, roomType: $roomType, houseType: $houseType, residenceType: $residenceType, bedrooms: $bedrooms, buildingSize: $buildingSize, bedType: $bedType, beds: $beds, personCapacity: $personCapacity, bathrooms: $bathrooms, bathroomType: $bathroomType, country: $country, street: $street, buildingName: $buildingName, city: $city, state: $state, zipcode: $zipcode, lat: $lat, lng: $lng, bedTypes: $bedTypes, isMapTouched: $isMapTouched, amenities: $amenities, safetyAmenities: $safetyAmenities, spaces: $spaces) {\n    __typename\n    id\n    results {\n      __typename\n      roomType\n      houseType\n      residenceType\n      bedrooms\n      buildingSize\n      bedType\n      beds\n      personCapacity\n      bathrooms\n      bathroomType\n      country\n      street\n      buildingName\n      city\n      state\n      zipcode\n      lat\n      lng\n      bedTypes\n      isMapTouched\n      amenities\n      safetyAmenities\n      spaces\n    }\n    status\n    errorMessage\n    actionType\n  }\n}"

  public var listId: Int?
  public var roomType: String?
  public var houseType: String?
  public var residenceType: String?
  public var bedrooms: String?
  public var buildingSize: String?
  public var bedType: String?
  public var beds: Int?
  public var personCapacity: Int?
  public var bathrooms: Double?
  public var bathroomType: String?
  public var country: String?
  public var street: String?
  public var buildingName: String?
  public var city: String?
  public var state: String?
  public var zipcode: String?
  public var lat: Double?
  public var lng: Double?
  public var bedTypes: String?
  public var isMapTouched: Bool?
  public var amenities: [Int?]?
  public var safetyAmenities: [Int?]?
  public var spaces: [Int?]?

  public init(listId: Int? = nil, roomType: String? = nil, houseType: String? = nil, residenceType: String? = nil, bedrooms: String? = nil, buildingSize: String? = nil, bedType: String? = nil, beds: Int? = nil, personCapacity: Int? = nil, bathrooms: Double? = nil, bathroomType: String? = nil, country: String? = nil, street: String? = nil, buildingName: String? = nil, city: String? = nil, state: String? = nil, zipcode: String? = nil, lat: Double? = nil, lng: Double? = nil, bedTypes: String? = nil, isMapTouched: Bool? = nil, amenities: [Int?]? = nil, safetyAmenities: [Int?]? = nil, spaces: [Int?]? = nil) {
    self.listId = listId
    self.roomType = roomType
    self.houseType = houseType
    self.residenceType = residenceType
    self.bedrooms = bedrooms
    self.buildingSize = buildingSize
    self.bedType = bedType
    self.beds = beds
    self.personCapacity = personCapacity
    self.bathrooms = bathrooms
    self.bathroomType = bathroomType
    self.country = country
    self.street = street
    self.buildingName = buildingName
    self.city = city
    self.state = state
    self.zipcode = zipcode
    self.lat = lat
    self.lng = lng
    self.bedTypes = bedTypes
    self.isMapTouched = isMapTouched
    self.amenities = amenities
    self.safetyAmenities = safetyAmenities
    self.spaces = spaces
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "roomType": roomType, "houseType": houseType, "residenceType": residenceType, "bedrooms": bedrooms, "buildingSize": buildingSize, "bedType": bedType, "beds": beds, "personCapacity": personCapacity, "bathrooms": bathrooms, "bathroomType": bathroomType, "country": country, "street": street, "buildingName": buildingName, "city": city, "state": state, "zipcode": zipcode, "lat": lat, "lng": lng, "bedTypes": bedTypes, "isMapTouched": isMapTouched, "amenities": amenities, "safetyAmenities": safetyAmenities, "spaces": spaces]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createListing", arguments: ["listId": GraphQLVariable("listId"), "roomType": GraphQLVariable("roomType"), "houseType": GraphQLVariable("houseType"), "residenceType": GraphQLVariable("residenceType"), "bedrooms": GraphQLVariable("bedrooms"), "buildingSize": GraphQLVariable("buildingSize"), "bedType": GraphQLVariable("bedType"), "beds": GraphQLVariable("beds"), "personCapacity": GraphQLVariable("personCapacity"), "bathrooms": GraphQLVariable("bathrooms"), "bathroomType": GraphQLVariable("bathroomType"), "country": GraphQLVariable("country"), "street": GraphQLVariable("street"), "buildingName": GraphQLVariable("buildingName"), "city": GraphQLVariable("city"), "state": GraphQLVariable("state"), "zipcode": GraphQLVariable("zipcode"), "lat": GraphQLVariable("lat"), "lng": GraphQLVariable("lng"), "bedTypes": GraphQLVariable("bedTypes"), "isMapTouched": GraphQLVariable("isMapTouched"), "amenities": GraphQLVariable("amenities"), "safetyAmenities": GraphQLVariable("safetyAmenities"), "spaces": GraphQLVariable("spaces")], type: .object(CreateListing.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createListing: CreateListing? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createListing": createListing.flatMap { (value: CreateListing) -> ResultMap in value.resultMap }])
    }

    public var createListing: CreateListing? {
      get {
        return (resultMap["createListing"] as? ResultMap).flatMap { CreateListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createListing")
      }
    }

    public struct CreateListing: GraphQLSelectionSet {
      public static let possibleTypes = ["ListingResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(Int.self)),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("actionType", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int? = nil, results: Result? = nil, status: Int? = nil, errorMessage: String? = nil, actionType: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ListingResponse", "id": id, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage, "actionType": actionType])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var actionType: String? {
        get {
          return resultMap["actionType"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "actionType")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["CreateListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("roomType", type: .scalar(String.self)),
          GraphQLField("houseType", type: .scalar(String.self)),
          GraphQLField("residenceType", type: .scalar(String.self)),
          GraphQLField("bedrooms", type: .scalar(String.self)),
          GraphQLField("buildingSize", type: .scalar(String.self)),
          GraphQLField("bedType", type: .scalar(String.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("bathrooms", type: .scalar(Double.self)),
          GraphQLField("bathroomType", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
          GraphQLField("street", type: .scalar(String.self)),
          GraphQLField("buildingName", type: .scalar(String.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("state", type: .scalar(String.self)),
          GraphQLField("zipcode", type: .scalar(String.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("lng", type: .scalar(Double.self)),
          GraphQLField("bedTypes", type: .scalar(String.self)),
          GraphQLField("isMapTouched", type: .scalar(Bool.self)),
          GraphQLField("amenities", type: .list(.scalar(Int.self))),
          GraphQLField("safetyAmenities", type: .list(.scalar(Int.self))),
          GraphQLField("spaces", type: .list(.scalar(Int.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(roomType: String? = nil, houseType: String? = nil, residenceType: String? = nil, bedrooms: String? = nil, buildingSize: String? = nil, bedType: String? = nil, beds: Int? = nil, personCapacity: Int? = nil, bathrooms: Double? = nil, bathroomType: String? = nil, country: String? = nil, street: String? = nil, buildingName: String? = nil, city: String? = nil, state: String? = nil, zipcode: String? = nil, lat: Double? = nil, lng: Double? = nil, bedTypes: String? = nil, isMapTouched: Bool? = nil, amenities: [Int?]? = nil, safetyAmenities: [Int?]? = nil, spaces: [Int?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "CreateListing", "roomType": roomType, "houseType": houseType, "residenceType": residenceType, "bedrooms": bedrooms, "buildingSize": buildingSize, "bedType": bedType, "beds": beds, "personCapacity": personCapacity, "bathrooms": bathrooms, "bathroomType": bathroomType, "country": country, "street": street, "buildingName": buildingName, "city": city, "state": state, "zipcode": zipcode, "lat": lat, "lng": lng, "bedTypes": bedTypes, "isMapTouched": isMapTouched, "amenities": amenities, "safetyAmenities": safetyAmenities, "spaces": spaces])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var roomType: String? {
          get {
            return resultMap["roomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "roomType")
          }
        }

        public var houseType: String? {
          get {
            return resultMap["houseType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "houseType")
          }
        }

        public var residenceType: String? {
          get {
            return resultMap["residenceType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "residenceType")
          }
        }

        public var bedrooms: String? {
          get {
            return resultMap["bedrooms"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bedrooms")
          }
        }

        public var buildingSize: String? {
          get {
            return resultMap["buildingSize"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "buildingSize")
          }
        }

        public var bedType: String? {
          get {
            return resultMap["bedType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bedType")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var bathrooms: Double? {
          get {
            return resultMap["bathrooms"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "bathrooms")
          }
        }

        public var bathroomType: String? {
          get {
            return resultMap["bathroomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bathroomType")
          }
        }

        public var country: String? {
          get {
            return resultMap["country"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "country")
          }
        }

        public var street: String? {
          get {
            return resultMap["street"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "street")
          }
        }

        public var buildingName: String? {
          get {
            return resultMap["buildingName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "buildingName")
          }
        }

        public var city: String? {
          get {
            return resultMap["city"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var state: String? {
          get {
            return resultMap["state"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var zipcode: String? {
          get {
            return resultMap["zipcode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
          }
        }

        public var lat: Double? {
          get {
            return resultMap["lat"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var lng: Double? {
          get {
            return resultMap["lng"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lng")
          }
        }

        public var bedTypes: String? {
          get {
            return resultMap["bedTypes"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bedTypes")
          }
        }

        public var isMapTouched: Bool? {
          get {
            return resultMap["isMapTouched"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isMapTouched")
          }
        }

        public var amenities: [Int?]? {
          get {
            return resultMap["amenities"] as? [Int?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "amenities")
          }
        }

        public var safetyAmenities: [Int?]? {
          get {
            return resultMap["safetyAmenities"] as? [Int?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "safetyAmenities")
          }
        }

        public var spaces: [Int?]? {
          get {
            return resultMap["spaces"] as? [Int?]
          }
          set {
            resultMap.updateValue(newValue, forKey: "spaces")
          }
        }
      }
    }
  }
}

public final class ContactHostMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation ContactHost($listId: Int!, $hostId: String!, $content: String!, $userId: String!, $type: String, $startDate: String!, $endDate: String!, $personCapacity: Int) {\n  CreateEnquiry(listId: $listId, hostId: $hostId, userId: $userId, content: $content, type: $type, startDate: $startDate, endDate: $endDate, personCapacity: $personCapacity) {\n    __typename\n    status\n  }\n}"

  public var listId: Int
  public var hostId: String
  public var content: String
  public var userId: String
  public var type: String?
  public var startDate: String
  public var endDate: String
  public var personCapacity: Int?

  public init(listId: Int, hostId: String, content: String, userId: String, type: String? = nil, startDate: String, endDate: String, personCapacity: Int? = nil) {
    self.listId = listId
    self.hostId = hostId
    self.content = content
    self.userId = userId
    self.type = type
    self.startDate = startDate
    self.endDate = endDate
    self.personCapacity = personCapacity
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "hostId": hostId, "content": content, "userId": userId, "type": type, "startDate": startDate, "endDate": endDate, "personCapacity": personCapacity]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("CreateEnquiry", arguments: ["listId": GraphQLVariable("listId"), "hostId": GraphQLVariable("hostId"), "userId": GraphQLVariable("userId"), "content": GraphQLVariable("content"), "type": GraphQLVariable("type"), "startDate": GraphQLVariable("startDate"), "endDate": GraphQLVariable("endDate"), "personCapacity": GraphQLVariable("personCapacity")], type: .object(CreateEnquiry.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createEnquiry: CreateEnquiry? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "CreateEnquiry": createEnquiry.flatMap { (value: CreateEnquiry) -> ResultMap in value.resultMap }])
    }

    public var createEnquiry: CreateEnquiry? {
      get {
        return (resultMap["CreateEnquiry"] as? ResultMap).flatMap { CreateEnquiry(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "CreateEnquiry")
      }
    }

    public struct CreateEnquiry: GraphQLSelectionSet {
      public static let possibleTypes = ["Enquiry"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Enquiry", "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}

public final class SocialLoginQuery: GraphQLQuery {
  public let operationDefinition =
    "query SocialLogin($firstName: String, $lastName: String, $email: String!, $dateOfBirth: String, $deviceType: String!, $deviceDetail: String, $deviceId: String!, $registerType: String, $gender: String, $profilePicture: String) {\n  userSocialLogin(firstName: $firstName, lastName: $lastName, email: $email, dateOfBirth: $dateOfBirth, deviceType: $deviceType, deviceDetail: $deviceDetail, deviceId: $deviceId, registerType: $registerType, gender: $gender, profilePicture: $profilePicture) {\n    __typename\n    result {\n      __typename\n      userId\n      userToken\n      status\n      errorMessage\n      user {\n        __typename\n        firstName\n        lastName\n        gender\n        dateOfBirth\n        phoneNumber\n        preferredLanguage\n        preferredCurrency\n        createdAt\n        picture\n        verification {\n          __typename\n          id\n          isPhoneVerified\n          isEmailConfirmed\n          isIdVerification\n          isGoogleConnected\n          isFacebookConnected\n        }\n        userData {\n          __typename\n          type\n        }\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var firstName: String?
  public var lastName: String?
  public var email: String
  public var dateOfBirth: String?
  public var deviceType: String
  public var deviceDetail: String?
  public var deviceId: String
  public var registerType: String?
  public var gender: String?
  public var profilePicture: String?

  public init(firstName: String? = nil, lastName: String? = nil, email: String, dateOfBirth: String? = nil, deviceType: String, deviceDetail: String? = nil, deviceId: String, registerType: String? = nil, gender: String? = nil, profilePicture: String? = nil) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.dateOfBirth = dateOfBirth
    self.deviceType = deviceType
    self.deviceDetail = deviceDetail
    self.deviceId = deviceId
    self.registerType = registerType
    self.gender = gender
    self.profilePicture = profilePicture
  }

  public var variables: GraphQLMap? {
    return ["firstName": firstName, "lastName": lastName, "email": email, "dateOfBirth": dateOfBirth, "deviceType": deviceType, "deviceDetail": deviceDetail, "deviceId": deviceId, "registerType": registerType, "gender": gender, "profilePicture": profilePicture]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("userSocialLogin", arguments: ["firstName": GraphQLVariable("firstName"), "lastName": GraphQLVariable("lastName"), "email": GraphQLVariable("email"), "dateOfBirth": GraphQLVariable("dateOfBirth"), "deviceType": GraphQLVariable("deviceType"), "deviceDetail": GraphQLVariable("deviceDetail"), "deviceId": GraphQLVariable("deviceId"), "registerType": GraphQLVariable("registerType"), "gender": GraphQLVariable("gender"), "profilePicture": GraphQLVariable("profilePicture")], type: .object(UserSocialLogin.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userSocialLogin: UserSocialLogin? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "userSocialLogin": userSocialLogin.flatMap { (value: UserSocialLogin) -> ResultMap in value.resultMap }])
    }

    public var userSocialLogin: UserSocialLogin? {
      get {
        return (resultMap["userSocialLogin"] as? ResultMap).flatMap { UserSocialLogin(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "userSocialLogin")
      }
    }

    public struct UserSocialLogin: GraphQLSelectionSet {
      public static let possibleTypes = ["UserCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("result", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserCommon", "result": result.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Result? {
        get {
          return (resultMap["result"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "result")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["UserType"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("userToken", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(Int.self)),
          GraphQLField("errorMessage", type: .scalar(String.self)),
          GraphQLField("user", type: .object(User.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: String? = nil, userToken: String? = nil, status: Int? = nil, errorMessage: String? = nil, user: User? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserType", "userId": userId, "userToken": userToken, "status": status, "errorMessage": errorMessage, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var userToken: String? {
          get {
            return resultMap["userToken"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userToken")
          }
        }

        public var status: Int? {
          get {
            return resultMap["status"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public var errorMessage: String? {
          get {
            return resultMap["errorMessage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "errorMessage")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["userEditProfile"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .scalar(String.self)),
            GraphQLField("gender", type: .scalar(String.self)),
            GraphQLField("dateOfBirth", type: .scalar(String.self)),
            GraphQLField("phoneNumber", type: .scalar(String.self)),
            GraphQLField("preferredLanguage", type: .scalar(String.self)),
            GraphQLField("preferredCurrency", type: .scalar(String.self)),
            GraphQLField("createdAt", type: .scalar(String.self)),
            GraphQLField("picture", type: .scalar(String.self)),
            GraphQLField("verification", type: .object(Verification.selections)),
            GraphQLField("userData", type: .object(UserDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(firstName: String? = nil, lastName: String? = nil, gender: String? = nil, dateOfBirth: String? = nil, phoneNumber: String? = nil, preferredLanguage: String? = nil, preferredCurrency: String? = nil, createdAt: String? = nil, picture: String? = nil, verification: Verification? = nil, userData: UserDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "userEditProfile", "firstName": firstName, "lastName": lastName, "gender": gender, "dateOfBirth": dateOfBirth, "phoneNumber": phoneNumber, "preferredLanguage": preferredLanguage, "preferredCurrency": preferredCurrency, "createdAt": createdAt, "picture": picture, "verification": verification.flatMap { (value: Verification) -> ResultMap in value.resultMap }, "userData": userData.flatMap { (value: UserDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String? {
            get {
              return resultMap["lastName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var gender: String? {
            get {
              return resultMap["gender"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "gender")
            }
          }

          public var dateOfBirth: String? {
            get {
              return resultMap["dateOfBirth"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "dateOfBirth")
            }
          }

          public var phoneNumber: String? {
            get {
              return resultMap["phoneNumber"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "phoneNumber")
            }
          }

          public var preferredLanguage: String? {
            get {
              return resultMap["preferredLanguage"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "preferredLanguage")
            }
          }

          public var preferredCurrency: String? {
            get {
              return resultMap["preferredCurrency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "preferredCurrency")
            }
          }

          public var createdAt: String? {
            get {
              return resultMap["createdAt"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "createdAt")
            }
          }

          public var picture: String? {
            get {
              return resultMap["picture"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "picture")
            }
          }

          public var verification: Verification? {
            get {
              return (resultMap["verification"] as? ResultMap).flatMap { Verification(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "verification")
            }
          }

          public var userData: UserDatum? {
            get {
              return (resultMap["userData"] as? ResultMap).flatMap { UserDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "userData")
            }
          }

          public struct Verification: GraphQLSelectionSet {
            public static let possibleTypes = ["UserVerifiedInfo"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("isPhoneVerified", type: .scalar(Bool.self)),
              GraphQLField("isEmailConfirmed", type: .scalar(Bool.self)),
              GraphQLField("isIdVerification", type: .scalar(Bool.self)),
              GraphQLField("isGoogleConnected", type: .scalar(Bool.self)),
              GraphQLField("isFacebookConnected", type: .scalar(Bool.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, isPhoneVerified: Bool? = nil, isEmailConfirmed: Bool? = nil, isIdVerification: Bool? = nil, isGoogleConnected: Bool? = nil, isFacebookConnected: Bool? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserVerifiedInfo", "id": id, "isPhoneVerified": isPhoneVerified, "isEmailConfirmed": isEmailConfirmed, "isIdVerification": isIdVerification, "isGoogleConnected": isGoogleConnected, "isFacebookConnected": isFacebookConnected])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var isPhoneVerified: Bool? {
              get {
                return resultMap["isPhoneVerified"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isPhoneVerified")
              }
            }

            public var isEmailConfirmed: Bool? {
              get {
                return resultMap["isEmailConfirmed"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isEmailConfirmed")
              }
            }

            public var isIdVerification: Bool? {
              get {
                return resultMap["isIdVerification"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isIdVerification")
              }
            }

            public var isGoogleConnected: Bool? {
              get {
                return resultMap["isGoogleConnected"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isGoogleConnected")
              }
            }

            public var isFacebookConnected: Bool? {
              get {
                return resultMap["isFacebookConnected"] as? Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "isFacebookConnected")
              }
            }
          }

          public struct UserDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["UserProfile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(type: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "UserProfile", "type": type])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var type: String? {
              get {
                return resultMap["type"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "type")
              }
            }
          }
        }
      }
    }
  }
}

public final class CancellationDataQuery: GraphQLQuery {
  public let operationDefinition =
    "query CancellationData($reservationId: Int!, $userType: String!, $currency: String) {\n  cancelReservationData(reservationId: $reservationId, userType: $userType, currency: $currency) {\n    __typename\n    results {\n      __typename\n      reservationId\n      cancellationPolicy\n      nonRefundableNightPrice\n      refundToGuest\n      payoutToHost\n      guestServiceFee\n      hostServiceFee\n      startedIn\n      stayingFor\n      total\n      listId\n      guests\n      threadId\n      checkIn\n      checkOut\n      currency\n      cancelledBy\n      listTitle\n      confirmationCode\n      hostEmail\n      guestName\n      hostName\n      guestProfilePicture\n      hostProfilePicture\n      isSpecialPriceAverage\n      listData {\n        __typename\n        title\n        id\n        roomType\n        reviewsCount\n        reviewsStarRating\n        bookingType\n        listPhotos {\n          __typename\n          id\n          name\n        }\n        listingData {\n          __typename\n          basePrice\n          currency\n        }\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var reservationId: Int
  public var userType: String
  public var currency: String?

  public init(reservationId: Int, userType: String, currency: String? = nil) {
    self.reservationId = reservationId
    self.userType = userType
    self.currency = currency
  }

  public var variables: GraphQLMap? {
    return ["reservationId": reservationId, "userType": userType, "currency": currency]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("cancelReservationData", arguments: ["reservationId": GraphQLVariable("reservationId"), "userType": GraphQLVariable("userType"), "currency": GraphQLVariable("currency")], type: .object(CancelReservationDatum.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(cancelReservationData: CancelReservationDatum? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "cancelReservationData": cancelReservationData.flatMap { (value: CancelReservationDatum) -> ResultMap in value.resultMap }])
    }

    public var cancelReservationData: CancelReservationDatum? {
      get {
        return (resultMap["cancelReservationData"] as? ResultMap).flatMap { CancelReservationDatum(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "cancelReservationData")
      }
    }

    public struct CancelReservationDatum: GraphQLSelectionSet {
      public static let possibleTypes = ["CancellationResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "CancellationResponse", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ReservationCancel"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("reservationId", type: .scalar(Int.self)),
          GraphQLField("cancellationPolicy", type: .scalar(String.self)),
          GraphQLField("nonRefundableNightPrice", type: .scalar(Double.self)),
          GraphQLField("refundToGuest", type: .scalar(Double.self)),
          GraphQLField("payoutToHost", type: .scalar(Double.self)),
          GraphQLField("guestServiceFee", type: .scalar(Double.self)),
          GraphQLField("hostServiceFee", type: .scalar(Double.self)),
          GraphQLField("startedIn", type: .scalar(Int.self)),
          GraphQLField("stayingFor", type: .scalar(Double.self)),
          GraphQLField("total", type: .scalar(Double.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("guests", type: .scalar(Int.self)),
          GraphQLField("threadId", type: .scalar(Int.self)),
          GraphQLField("checkIn", type: .scalar(String.self)),
          GraphQLField("checkOut", type: .scalar(String.self)),
          GraphQLField("currency", type: .scalar(String.self)),
          GraphQLField("cancelledBy", type: .scalar(String.self)),
          GraphQLField("listTitle", type: .scalar(String.self)),
          GraphQLField("confirmationCode", type: .scalar(Int.self)),
          GraphQLField("hostEmail", type: .scalar(String.self)),
          GraphQLField("guestName", type: .scalar(String.self)),
          GraphQLField("hostName", type: .scalar(String.self)),
          GraphQLField("guestProfilePicture", type: .scalar(String.self)),
          GraphQLField("hostProfilePicture", type: .scalar(String.self)),
          GraphQLField("isSpecialPriceAverage", type: .scalar(Double.self)),
          GraphQLField("listData", type: .object(ListDatum.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(reservationId: Int? = nil, cancellationPolicy: String? = nil, nonRefundableNightPrice: Double? = nil, refundToGuest: Double? = nil, payoutToHost: Double? = nil, guestServiceFee: Double? = nil, hostServiceFee: Double? = nil, startedIn: Int? = nil, stayingFor: Double? = nil, total: Double? = nil, listId: Int? = nil, guests: Int? = nil, threadId: Int? = nil, checkIn: String? = nil, checkOut: String? = nil, currency: String? = nil, cancelledBy: String? = nil, listTitle: String? = nil, confirmationCode: Int? = nil, hostEmail: String? = nil, guestName: String? = nil, hostName: String? = nil, guestProfilePicture: String? = nil, hostProfilePicture: String? = nil, isSpecialPriceAverage: Double? = nil, listData: ListDatum? = nil) {
          self.init(unsafeResultMap: ["__typename": "ReservationCancel", "reservationId": reservationId, "cancellationPolicy": cancellationPolicy, "nonRefundableNightPrice": nonRefundableNightPrice, "refundToGuest": refundToGuest, "payoutToHost": payoutToHost, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "startedIn": startedIn, "stayingFor": stayingFor, "total": total, "listId": listId, "guests": guests, "threadId": threadId, "checkIn": checkIn, "checkOut": checkOut, "currency": currency, "cancelledBy": cancelledBy, "listTitle": listTitle, "confirmationCode": confirmationCode, "hostEmail": hostEmail, "guestName": guestName, "hostName": hostName, "guestProfilePicture": guestProfilePicture, "hostProfilePicture": hostProfilePicture, "isSpecialPriceAverage": isSpecialPriceAverage, "listData": listData.flatMap { (value: ListDatum) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var reservationId: Int? {
          get {
            return resultMap["reservationId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reservationId")
          }
        }

        public var cancellationPolicy: String? {
          get {
            return resultMap["cancellationPolicy"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "cancellationPolicy")
          }
        }

        public var nonRefundableNightPrice: Double? {
          get {
            return resultMap["nonRefundableNightPrice"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "nonRefundableNightPrice")
          }
        }

        public var refundToGuest: Double? {
          get {
            return resultMap["refundToGuest"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "refundToGuest")
          }
        }

        public var payoutToHost: Double? {
          get {
            return resultMap["payoutToHost"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "payoutToHost")
          }
        }

        public var guestServiceFee: Double? {
          get {
            return resultMap["guestServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestServiceFee")
          }
        }

        public var hostServiceFee: Double? {
          get {
            return resultMap["hostServiceFee"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostServiceFee")
          }
        }

        public var startedIn: Int? {
          get {
            return resultMap["startedIn"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "startedIn")
          }
        }

        public var stayingFor: Double? {
          get {
            return resultMap["stayingFor"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "stayingFor")
          }
        }

        public var total: Double? {
          get {
            return resultMap["total"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "total")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var guests: Int? {
          get {
            return resultMap["guests"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "guests")
          }
        }

        public var threadId: Int? {
          get {
            return resultMap["threadId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "threadId")
          }
        }

        public var checkIn: String? {
          get {
            return resultMap["checkIn"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkIn")
          }
        }

        public var checkOut: String? {
          get {
            return resultMap["checkOut"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "checkOut")
          }
        }

        public var currency: String? {
          get {
            return resultMap["currency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var cancelledBy: String? {
          get {
            return resultMap["cancelledBy"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "cancelledBy")
          }
        }

        public var listTitle: String? {
          get {
            return resultMap["listTitle"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listTitle")
          }
        }

        public var confirmationCode: Int? {
          get {
            return resultMap["confirmationCode"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "confirmationCode")
          }
        }

        public var hostEmail: String? {
          get {
            return resultMap["hostEmail"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostEmail")
          }
        }

        public var guestName: String? {
          get {
            return resultMap["guestName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestName")
          }
        }

        public var hostName: String? {
          get {
            return resultMap["hostName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostName")
          }
        }

        public var guestProfilePicture: String? {
          get {
            return resultMap["guestProfilePicture"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "guestProfilePicture")
          }
        }

        public var hostProfilePicture: String? {
          get {
            return resultMap["hostProfilePicture"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hostProfilePicture")
          }
        }

        public var isSpecialPriceAverage: Double? {
          get {
            return resultMap["isSpecialPriceAverage"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "isSpecialPriceAverage")
          }
        }

        public var listData: ListDatum? {
          get {
            return (resultMap["listData"] as? ResultMap).flatMap { ListDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listData")
          }
        }

        public struct ListDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["ShowListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("roomType", type: .scalar(String.self)),
            GraphQLField("reviewsCount", type: .scalar(Int.self)),
            GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
            GraphQLField("bookingType", type: .scalar(String.self)),
            GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
            GraphQLField("listingData", type: .object(ListingDatum.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(title: String? = nil, id: Int? = nil, roomType: String? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, bookingType: String? = nil, listPhotos: [ListPhoto?]? = nil, listingData: ListingDatum? = nil) {
            self.init(unsafeResultMap: ["__typename": "ShowListing", "title": title, "id": id, "roomType": roomType, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "bookingType": bookingType, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var roomType: String? {
            get {
              return resultMap["roomType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "roomType")
            }
          }

          public var reviewsCount: Int? {
            get {
              return resultMap["reviewsCount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsCount")
            }
          }

          public var reviewsStarRating: Int? {
            get {
              return resultMap["reviewsStarRating"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reviewsStarRating")
            }
          }

          public var bookingType: String? {
            get {
              return resultMap["bookingType"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "bookingType")
            }
          }

          public var listPhotos: [ListPhoto?]? {
            get {
              return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
            }
          }

          public var listingData: ListingDatum? {
            get {
              return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
            }
          }

          public struct ListPhoto: GraphQLSelectionSet {
            public static let possibleTypes = ["listPhotosData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }

          public struct ListingDatum: GraphQLSelectionSet {
            public static let possibleTypes = ["listingData"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("basePrice", type: .scalar(Double.self)),
              GraphQLField("currency", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(basePrice: Double? = nil, currency: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "listingData", "basePrice": basePrice, "currency": currency])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var basePrice: Double? {
              get {
                return resultMap["basePrice"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "basePrice")
              }
            }

            public var currency: String? {
              get {
                return resultMap["currency"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "currency")
              }
            }
          }
        }
      }
    }
  }
}

public final class CancelReservationMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CancelReservation($reservationId: Int!, $cancellationPolicy: String!, $refundToGuest: Float!, $payoutToHost: Float!, $guestServiceFee: Float!, $hostServiceFee: Float!, $total: Float!, $currency: String!, $threadId: Int!, $cancelledBy: String!, $message: String!, $checkIn: String!, $checkOut: String!, $guests: Int!) {\n  cancelReservation(reservationId: $reservationId, cancellationPolicy: $cancellationPolicy, refundToGuest: $refundToGuest, payoutToHost: $payoutToHost, guestServiceFee: $guestServiceFee, hostServiceFee: $hostServiceFee, total: $total, currency: $currency, threadId: $threadId, cancelledBy: $cancelledBy, message: $message, checkIn: $checkIn, checkOut: $checkOut, guests: $guests) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var reservationId: Int
  public var cancellationPolicy: String
  public var refundToGuest: Double
  public var payoutToHost: Double
  public var guestServiceFee: Double
  public var hostServiceFee: Double
  public var total: Double
  public var currency: String
  public var threadId: Int
  public var cancelledBy: String
  public var message: String
  public var checkIn: String
  public var checkOut: String
  public var guests: Int

  public init(reservationId: Int, cancellationPolicy: String, refundToGuest: Double, payoutToHost: Double, guestServiceFee: Double, hostServiceFee: Double, total: Double, currency: String, threadId: Int, cancelledBy: String, message: String, checkIn: String, checkOut: String, guests: Int) {
    self.reservationId = reservationId
    self.cancellationPolicy = cancellationPolicy
    self.refundToGuest = refundToGuest
    self.payoutToHost = payoutToHost
    self.guestServiceFee = guestServiceFee
    self.hostServiceFee = hostServiceFee
    self.total = total
    self.currency = currency
    self.threadId = threadId
    self.cancelledBy = cancelledBy
    self.message = message
    self.checkIn = checkIn
    self.checkOut = checkOut
    self.guests = guests
  }

  public var variables: GraphQLMap? {
    return ["reservationId": reservationId, "cancellationPolicy": cancellationPolicy, "refundToGuest": refundToGuest, "payoutToHost": payoutToHost, "guestServiceFee": guestServiceFee, "hostServiceFee": hostServiceFee, "total": total, "currency": currency, "threadId": threadId, "cancelledBy": cancelledBy, "message": message, "checkIn": checkIn, "checkOut": checkOut, "guests": guests]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("cancelReservation", arguments: ["reservationId": GraphQLVariable("reservationId"), "cancellationPolicy": GraphQLVariable("cancellationPolicy"), "refundToGuest": GraphQLVariable("refundToGuest"), "payoutToHost": GraphQLVariable("payoutToHost"), "guestServiceFee": GraphQLVariable("guestServiceFee"), "hostServiceFee": GraphQLVariable("hostServiceFee"), "total": GraphQLVariable("total"), "currency": GraphQLVariable("currency"), "threadId": GraphQLVariable("threadId"), "cancelledBy": GraphQLVariable("cancelledBy"), "message": GraphQLVariable("message"), "checkIn": GraphQLVariable("checkIn"), "checkOut": GraphQLVariable("checkOut"), "guests": GraphQLVariable("guests")], type: .object(CancelReservation.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(cancelReservation: CancelReservation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "cancelReservation": cancelReservation.flatMap { (value: CancelReservation) -> ResultMap in value.resultMap }])
    }

    public var cancelReservation: CancelReservation? {
      get {
        return (resultMap["cancelReservation"] as? ResultMap).flatMap { CancelReservation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "cancelReservation")
      }
    }

    public struct CancelReservation: GraphQLSelectionSet {
      public static let possibleTypes = ["Reservationlist"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Reservationlist", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class ShowUserProfileQuery: GraphQLQuery {
  public let operationDefinition =
    "query showUserProfile($profileId: Int, $isUser: Boolean) {\n  showUserProfile(profileId: $profileId, isUser: $isUser) {\n    __typename\n    results {\n      __typename\n      userId\n      profileId\n      firstName\n      lastName\n      dateOfBirth\n      gender\n      phoneNumber\n      preferredLanguage\n      preferredCurrency\n      location\n      info\n      createdAt\n      picture\n      reviewsCount\n      userVerifiedInfo {\n        __typename\n        id\n        isEmailConfirmed\n        isFacebookConnected\n        isGoogleConnected\n        isIdVerification\n        isPhoneVerified\n        status\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var profileId: Int?
  public var isUser: Bool?

  public init(profileId: Int? = nil, isUser: Bool? = nil) {
    self.profileId = profileId
    self.isUser = isUser
  }

  public var variables: GraphQLMap? {
    return ["profileId": profileId, "isUser": isUser]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("showUserProfile", arguments: ["profileId": GraphQLVariable("profileId"), "isUser": GraphQLVariable("isUser")], type: .object(ShowUserProfile.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(showUserProfile: ShowUserProfile? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "showUserProfile": showUserProfile.flatMap { (value: ShowUserProfile) -> ResultMap in value.resultMap }])
    }

    public var showUserProfile: ShowUserProfile? {
      get {
        return (resultMap["showUserProfile"] as? ResultMap).flatMap { ShowUserProfile(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "showUserProfile")
      }
    }

    public struct ShowUserProfile: GraphQLSelectionSet {
      public static let possibleTypes = ["ShowUserProfileCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ShowUserProfileCommon", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowUserProfile"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("profileId", type: .scalar(Int.self)),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("dateOfBirth", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
          GraphQLField("phoneNumber", type: .scalar(String.self)),
          GraphQLField("preferredLanguage", type: .scalar(String.self)),
          GraphQLField("preferredCurrency", type: .scalar(String.self)),
          GraphQLField("location", type: .scalar(String.self)),
          GraphQLField("info", type: .scalar(String.self)),
          GraphQLField("createdAt", type: .scalar(String.self)),
          GraphQLField("picture", type: .scalar(String.self)),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("userVerifiedInfo", type: .object(UserVerifiedInfo.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: String? = nil, profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, dateOfBirth: String? = nil, gender: String? = nil, phoneNumber: String? = nil, preferredLanguage: String? = nil, preferredCurrency: String? = nil, location: String? = nil, info: String? = nil, createdAt: String? = nil, picture: String? = nil, reviewsCount: Int? = nil, userVerifiedInfo: UserVerifiedInfo? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowUserProfile", "userId": userId, "profileId": profileId, "firstName": firstName, "lastName": lastName, "dateOfBirth": dateOfBirth, "gender": gender, "phoneNumber": phoneNumber, "preferredLanguage": preferredLanguage, "preferredCurrency": preferredCurrency, "location": location, "info": info, "createdAt": createdAt, "picture": picture, "reviewsCount": reviewsCount, "userVerifiedInfo": userVerifiedInfo.flatMap { (value: UserVerifiedInfo) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var profileId: Int? {
          get {
            return resultMap["profileId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileId")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var dateOfBirth: String? {
          get {
            return resultMap["dateOfBirth"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dateOfBirth")
          }
        }

        public var gender: String? {
          get {
            return resultMap["gender"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "gender")
          }
        }

        public var phoneNumber: String? {
          get {
            return resultMap["phoneNumber"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phoneNumber")
          }
        }

        public var preferredLanguage: String? {
          get {
            return resultMap["preferredLanguage"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "preferredLanguage")
          }
        }

        public var preferredCurrency: String? {
          get {
            return resultMap["preferredCurrency"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "preferredCurrency")
          }
        }

        public var location: String? {
          get {
            return resultMap["location"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "location")
          }
        }

        public var info: String? {
          get {
            return resultMap["info"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "info")
          }
        }

        public var createdAt: String? {
          get {
            return resultMap["createdAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var picture: String? {
          get {
            return resultMap["picture"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "picture")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var userVerifiedInfo: UserVerifiedInfo? {
          get {
            return (resultMap["userVerifiedInfo"] as? ResultMap).flatMap { UserVerifiedInfo(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "userVerifiedInfo")
          }
        }

        public struct UserVerifiedInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["UserVerifiedInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("isEmailConfirmed", type: .scalar(Bool.self)),
            GraphQLField("isFacebookConnected", type: .scalar(Bool.self)),
            GraphQLField("isGoogleConnected", type: .scalar(Bool.self)),
            GraphQLField("isIdVerification", type: .scalar(Bool.self)),
            GraphQLField("isPhoneVerified", type: .scalar(Bool.self)),
            GraphQLField("status", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, isEmailConfirmed: Bool? = nil, isFacebookConnected: Bool? = nil, isGoogleConnected: Bool? = nil, isIdVerification: Bool? = nil, isPhoneVerified: Bool? = nil, status: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserVerifiedInfo", "id": id, "isEmailConfirmed": isEmailConfirmed, "isFacebookConnected": isFacebookConnected, "isGoogleConnected": isGoogleConnected, "isIdVerification": isIdVerification, "isPhoneVerified": isPhoneVerified, "status": status])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var isEmailConfirmed: Bool? {
            get {
              return resultMap["isEmailConfirmed"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isEmailConfirmed")
            }
          }

          public var isFacebookConnected: Bool? {
            get {
              return resultMap["isFacebookConnected"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isFacebookConnected")
            }
          }

          public var isGoogleConnected: Bool? {
            get {
              return resultMap["isGoogleConnected"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isGoogleConnected")
            }
          }

          public var isIdVerification: Bool? {
            get {
              return resultMap["isIdVerification"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isIdVerification")
            }
          }

          public var isPhoneVerified: Bool? {
            get {
              return resultMap["isPhoneVerified"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isPhoneVerified")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }
        }
      }
    }
  }
}

public final class ViewListingDetailsQuery: GraphQLQuery {
  public let operationDefinition =
    "query viewListingDetails($listId: Int!, $preview: Boolean) {\n  viewListing(listId: $listId, preview: $preview) {\n    __typename\n    results {\n      __typename\n      id\n      userId\n      title\n      description\n      coverPhoto\n      city\n      state\n      country\n      isPublished\n      lat\n      lng\n      houseType\n      roomType\n      bookingType\n      bedrooms\n      beds\n      personCapacity\n      bathrooms\n      coverPhoto\n      listPhotoName\n      listPhotos {\n        __typename\n        id\n        name\n      }\n      listingPhotos {\n        __typename\n        id\n        name\n      }\n      user {\n        __typename\n        email\n        profile {\n          __typename\n          profileId\n          displayName\n          picture\n          firstName\n        }\n      }\n      userAmenities {\n        __typename\n        id\n        itemName\n      }\n      userSafetyAmenities {\n        __typename\n        id\n        itemName\n      }\n      userSpaces {\n        __typename\n        id\n        itemName\n      }\n      houseRules {\n        __typename\n        id\n        itemName\n      }\n      listingData {\n        __typename\n        bookingNoticeTime\n        checkInStart\n        checkInEnd\n        maxDaysNotice\n        minNight\n        maxNight\n        basePrice\n        cleaningPrice\n        currency\n        weeklyDiscount\n        monthlyDiscount\n        cancellation {\n          __typename\n          id\n          policyName\n          policyContent\n        }\n      }\n      blockedDates {\n        __typename\n        blockedDates\n        reservationId\n        calendarStatus\n        isSpecialPrice\n        listId\n      }\n      reviewsCount\n      reviewsStarRating\n      isListOwner\n      wishListStatus\n      wishListGroupCount\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: Int
  public var preview: Bool?

  public init(listId: Int, preview: Bool? = nil) {
    self.listId = listId
    self.preview = preview
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "preview": preview]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewListing", arguments: ["listId": GraphQLVariable("listId"), "preview": GraphQLVariable("preview")], type: .object(ViewListing.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewListing: ViewListing? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewListing": viewListing.flatMap { (value: ViewListing) -> ResultMap in value.resultMap }])
    }

    public var viewListing: ViewListing? {
      get {
        return (resultMap["viewListing"] as? ResultMap).flatMap { ViewListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "viewListing")
      }
    }

    public struct ViewListing: GraphQLSelectionSet {
      public static let possibleTypes = ["AllListing"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllListing", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("state", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
          GraphQLField("isPublished", type: .scalar(Bool.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("lng", type: .scalar(Double.self)),
          GraphQLField("houseType", type: .scalar(String.self)),
          GraphQLField("roomType", type: .scalar(String.self)),
          GraphQLField("bookingType", type: .scalar(String.self)),
          GraphQLField("bedrooms", type: .scalar(String.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("bathrooms", type: .scalar(Double.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
          GraphQLField("listPhotoName", type: .scalar(String.self)),
          GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
          GraphQLField("listingPhotos", type: .list(.object(ListingPhoto.selections))),
          GraphQLField("user", type: .object(User.selections)),
          GraphQLField("userAmenities", type: .list(.object(UserAmenity.selections))),
          GraphQLField("userSafetyAmenities", type: .list(.object(UserSafetyAmenity.selections))),
          GraphQLField("userSpaces", type: .list(.object(UserSpace.selections))),
          GraphQLField("houseRules", type: .list(.object(HouseRule.selections))),
          GraphQLField("listingData", type: .object(ListingDatum.selections)),
          GraphQLField("blockedDates", type: .list(.object(BlockedDate.selections))),
          GraphQLField("reviewsCount", type: .scalar(Int.self)),
          GraphQLField("reviewsStarRating", type: .scalar(Int.self)),
          GraphQLField("isListOwner", type: .scalar(Bool.self)),
          GraphQLField("wishListStatus", type: .scalar(Bool.self)),
          GraphQLField("wishListGroupCount", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, userId: String? = nil, title: String? = nil, description: String? = nil, coverPhoto: Int? = nil, city: String? = nil, state: String? = nil, country: String? = nil, isPublished: Bool? = nil, lat: Double? = nil, lng: Double? = nil, houseType: String? = nil, roomType: String? = nil, bookingType: String? = nil, bedrooms: String? = nil, beds: Int? = nil, personCapacity: Int? = nil, bathrooms: Double? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, listingPhotos: [ListingPhoto?]? = nil, user: User? = nil, userAmenities: [UserAmenity?]? = nil, userSafetyAmenities: [UserSafetyAmenity?]? = nil, userSpaces: [UserSpace?]? = nil, houseRules: [HouseRule?]? = nil, listingData: ListingDatum? = nil, blockedDates: [BlockedDate?]? = nil, reviewsCount: Int? = nil, reviewsStarRating: Int? = nil, isListOwner: Bool? = nil, wishListStatus: Bool? = nil, wishListGroupCount: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "userId": userId, "title": title, "description": description, "coverPhoto": coverPhoto, "city": city, "state": state, "country": country, "isPublished": isPublished, "lat": lat, "lng": lng, "houseType": houseType, "roomType": roomType, "bookingType": bookingType, "bedrooms": bedrooms, "beds": beds, "personCapacity": personCapacity, "bathrooms": bathrooms, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "listingPhotos": listingPhotos.flatMap { (value: [ListingPhoto?]) -> [ResultMap?] in value.map { (value: ListingPhoto?) -> ResultMap? in value.flatMap { (value: ListingPhoto) -> ResultMap in value.resultMap } } }, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "userAmenities": userAmenities.flatMap { (value: [UserAmenity?]) -> [ResultMap?] in value.map { (value: UserAmenity?) -> ResultMap? in value.flatMap { (value: UserAmenity) -> ResultMap in value.resultMap } } }, "userSafetyAmenities": userSafetyAmenities.flatMap { (value: [UserSafetyAmenity?]) -> [ResultMap?] in value.map { (value: UserSafetyAmenity?) -> ResultMap? in value.flatMap { (value: UserSafetyAmenity) -> ResultMap in value.resultMap } } }, "userSpaces": userSpaces.flatMap { (value: [UserSpace?]) -> [ResultMap?] in value.map { (value: UserSpace?) -> ResultMap? in value.flatMap { (value: UserSpace) -> ResultMap in value.resultMap } } }, "houseRules": houseRules.flatMap { (value: [HouseRule?]) -> [ResultMap?] in value.map { (value: HouseRule?) -> ResultMap? in value.flatMap { (value: HouseRule) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "blockedDates": blockedDates.flatMap { (value: [BlockedDate?]) -> [ResultMap?] in value.map { (value: BlockedDate?) -> ResultMap? in value.flatMap { (value: BlockedDate) -> ResultMap in value.resultMap } } }, "reviewsCount": reviewsCount, "reviewsStarRating": reviewsStarRating, "isListOwner": isListOwner, "wishListStatus": wishListStatus, "wishListGroupCount": wishListGroupCount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }

        public var city: String? {
          get {
            return resultMap["city"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var state: String? {
          get {
            return resultMap["state"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var country: String? {
          get {
            return resultMap["country"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "country")
          }
        }

        public var isPublished: Bool? {
          get {
            return resultMap["isPublished"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPublished")
          }
        }

        public var lat: Double? {
          get {
            return resultMap["lat"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var lng: Double? {
          get {
            return resultMap["lng"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lng")
          }
        }

        public var houseType: String? {
          get {
            return resultMap["houseType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "houseType")
          }
        }

        public var roomType: String? {
          get {
            return resultMap["roomType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "roomType")
          }
        }

        public var bookingType: String? {
          get {
            return resultMap["bookingType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingType")
          }
        }

        public var bedrooms: String? {
          get {
            return resultMap["bedrooms"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bedrooms")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var bathrooms: Double? {
          get {
            return resultMap["bathrooms"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "bathrooms")
          }
        }

        public var listPhotoName: String? {
          get {
            return resultMap["listPhotoName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listPhotoName")
          }
        }

        public var listPhotos: [ListPhoto?]? {
          get {
            return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
          }
        }

        public var listingPhotos: [ListingPhoto?]? {
          get {
            return (resultMap["listingPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListingPhoto?] in value.map { (value: ResultMap?) -> ListingPhoto? in value.flatMap { (value: ResultMap) -> ListingPhoto in ListingPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListingPhoto?]) -> [ResultMap?] in value.map { (value: ListingPhoto?) -> ResultMap? in value.flatMap { (value: ListingPhoto) -> ResultMap in value.resultMap } } }, forKey: "listingPhotos")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public var userAmenities: [UserAmenity?]? {
          get {
            return (resultMap["userAmenities"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserAmenity?] in value.map { (value: ResultMap?) -> UserAmenity? in value.flatMap { (value: ResultMap) -> UserAmenity in UserAmenity(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserAmenity?]) -> [ResultMap?] in value.map { (value: UserAmenity?) -> ResultMap? in value.flatMap { (value: UserAmenity) -> ResultMap in value.resultMap } } }, forKey: "userAmenities")
          }
        }

        public var userSafetyAmenities: [UserSafetyAmenity?]? {
          get {
            return (resultMap["userSafetyAmenities"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserSafetyAmenity?] in value.map { (value: ResultMap?) -> UserSafetyAmenity? in value.flatMap { (value: ResultMap) -> UserSafetyAmenity in UserSafetyAmenity(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserSafetyAmenity?]) -> [ResultMap?] in value.map { (value: UserSafetyAmenity?) -> ResultMap? in value.flatMap { (value: UserSafetyAmenity) -> ResultMap in value.resultMap } } }, forKey: "userSafetyAmenities")
          }
        }

        public var userSpaces: [UserSpace?]? {
          get {
            return (resultMap["userSpaces"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserSpace?] in value.map { (value: ResultMap?) -> UserSpace? in value.flatMap { (value: ResultMap) -> UserSpace in UserSpace(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserSpace?]) -> [ResultMap?] in value.map { (value: UserSpace?) -> ResultMap? in value.flatMap { (value: UserSpace) -> ResultMap in value.resultMap } } }, forKey: "userSpaces")
          }
        }

        public var houseRules: [HouseRule?]? {
          get {
            return (resultMap["houseRules"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [HouseRule?] in value.map { (value: ResultMap?) -> HouseRule? in value.flatMap { (value: ResultMap) -> HouseRule in HouseRule(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [HouseRule?]) -> [ResultMap?] in value.map { (value: HouseRule?) -> ResultMap? in value.flatMap { (value: HouseRule) -> ResultMap in value.resultMap } } }, forKey: "houseRules")
          }
        }

        public var listingData: ListingDatum? {
          get {
            return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
          }
        }

        public var blockedDates: [BlockedDate?]? {
          get {
            return (resultMap["blockedDates"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [BlockedDate?] in value.map { (value: ResultMap?) -> BlockedDate? in value.flatMap { (value: ResultMap) -> BlockedDate in BlockedDate(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [BlockedDate?]) -> [ResultMap?] in value.map { (value: BlockedDate?) -> ResultMap? in value.flatMap { (value: BlockedDate) -> ResultMap in value.resultMap } } }, forKey: "blockedDates")
          }
        }

        public var reviewsCount: Int? {
          get {
            return resultMap["reviewsCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var reviewsStarRating: Int? {
          get {
            return resultMap["reviewsStarRating"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsStarRating")
          }
        }

        public var isListOwner: Bool? {
          get {
            return resultMap["isListOwner"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isListOwner")
          }
        }

        public var wishListStatus: Bool? {
          get {
            return resultMap["wishListStatus"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListStatus")
          }
        }

        public var wishListGroupCount: Int? {
          get {
            return resultMap["wishListGroupCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "wishListGroupCount")
          }
        }

        public struct ListPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct ListingPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["user"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("email", type: .scalar(String.self)),
            GraphQLField("profile", type: .object(Profile.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(email: String? = nil, profile: Profile? = nil) {
            self.init(unsafeResultMap: ["__typename": "user", "email": email, "profile": profile.flatMap { (value: Profile) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var email: String? {
            get {
              return resultMap["email"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "email")
            }
          }

          public var profile: Profile? {
            get {
              return (resultMap["profile"] as? ResultMap).flatMap { Profile(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "profile")
            }
          }

          public struct Profile: GraphQLSelectionSet {
            public static let possibleTypes = ["profile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("profileId", type: .scalar(Int.self)),
              GraphQLField("displayName", type: .scalar(String.self)),
              GraphQLField("picture", type: .scalar(String.self)),
              GraphQLField("firstName", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(profileId: Int? = nil, displayName: String? = nil, picture: String? = nil, firstName: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "profile", "profileId": profileId, "displayName": displayName, "picture": picture, "firstName": firstName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var profileId: Int? {
              get {
                return resultMap["profileId"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "profileId")
              }
            }

            public var displayName: String? {
              get {
                return resultMap["displayName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "displayName")
              }
            }

            public var picture: String? {
              get {
                return resultMap["picture"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "picture")
              }
            }

            public var firstName: String? {
              get {
                return resultMap["firstName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "firstName")
              }
            }
          }
        }

        public struct UserAmenity: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct UserSafetyAmenity: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct UserSpace: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct HouseRule: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct ListingDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["listingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("bookingNoticeTime", type: .scalar(String.self)),
            GraphQLField("checkInStart", type: .scalar(String.self)),
            GraphQLField("checkInEnd", type: .scalar(String.self)),
            GraphQLField("maxDaysNotice", type: .scalar(String.self)),
            GraphQLField("minNight", type: .scalar(Int.self)),
            GraphQLField("maxNight", type: .scalar(Int.self)),
            GraphQLField("basePrice", type: .scalar(Double.self)),
            GraphQLField("cleaningPrice", type: .scalar(Double.self)),
            GraphQLField("currency", type: .scalar(String.self)),
            GraphQLField("weeklyDiscount", type: .scalar(Int.self)),
            GraphQLField("monthlyDiscount", type: .scalar(Int.self)),
            GraphQLField("cancellation", type: .object(Cancellation.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(bookingNoticeTime: String? = nil, checkInStart: String? = nil, checkInEnd: String? = nil, maxDaysNotice: String? = nil, minNight: Int? = nil, maxNight: Int? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, weeklyDiscount: Int? = nil, monthlyDiscount: Int? = nil, cancellation: Cancellation? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingData", "bookingNoticeTime": bookingNoticeTime, "checkInStart": checkInStart, "checkInEnd": checkInEnd, "maxDaysNotice": maxDaysNotice, "minNight": minNight, "maxNight": maxNight, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "weeklyDiscount": weeklyDiscount, "monthlyDiscount": monthlyDiscount, "cancellation": cancellation.flatMap { (value: Cancellation) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var bookingNoticeTime: String? {
            get {
              return resultMap["bookingNoticeTime"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "bookingNoticeTime")
            }
          }

          public var checkInStart: String? {
            get {
              return resultMap["checkInStart"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "checkInStart")
            }
          }

          public var checkInEnd: String? {
            get {
              return resultMap["checkInEnd"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "checkInEnd")
            }
          }

          public var maxDaysNotice: String? {
            get {
              return resultMap["maxDaysNotice"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxDaysNotice")
            }
          }

          public var minNight: Int? {
            get {
              return resultMap["minNight"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "minNight")
            }
          }

          public var maxNight: Int? {
            get {
              return resultMap["maxNight"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxNight")
            }
          }

          public var basePrice: Double? {
            get {
              return resultMap["basePrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "basePrice")
            }
          }

          public var cleaningPrice: Double? {
            get {
              return resultMap["cleaningPrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "cleaningPrice")
            }
          }

          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }

          public var weeklyDiscount: Int? {
            get {
              return resultMap["weeklyDiscount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "weeklyDiscount")
            }
          }

          public var monthlyDiscount: Int? {
            get {
              return resultMap["monthlyDiscount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "monthlyDiscount")
            }
          }

          public var cancellation: Cancellation? {
            get {
              return (resultMap["cancellation"] as? ResultMap).flatMap { Cancellation(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "cancellation")
            }
          }

          public struct Cancellation: GraphQLSelectionSet {
            public static let possibleTypes = ["Cancellation"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("policyName", type: .scalar(String.self)),
              GraphQLField("policyContent", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, policyName: String? = nil, policyContent: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Cancellation", "id": id, "policyName": policyName, "policyContent": policyContent])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var policyName: String? {
              get {
                return resultMap["policyName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "policyName")
              }
            }

            public var policyContent: String? {
              get {
                return resultMap["policyContent"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "policyContent")
              }
            }
          }
        }

        public struct BlockedDate: GraphQLSelectionSet {
          public static let possibleTypes = ["listBlockedDates"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("blockedDates", type: .scalar(String.self)),
            GraphQLField("reservationId", type: .scalar(Int.self)),
            GraphQLField("calendarStatus", type: .scalar(String.self)),
            GraphQLField("isSpecialPrice", type: .scalar(Double.self)),
            GraphQLField("listId", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(blockedDates: String? = nil, reservationId: Int? = nil, calendarStatus: String? = nil, isSpecialPrice: Double? = nil, listId: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "listBlockedDates", "blockedDates": blockedDates, "reservationId": reservationId, "calendarStatus": calendarStatus, "isSpecialPrice": isSpecialPrice, "listId": listId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var blockedDates: String? {
            get {
              return resultMap["blockedDates"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "blockedDates")
            }
          }

          public var reservationId: Int? {
            get {
              return resultMap["reservationId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reservationId")
            }
          }

          public var calendarStatus: String? {
            get {
              return resultMap["calendarStatus"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "calendarStatus")
            }
          }

          public var isSpecialPrice: Double? {
            get {
              return resultMap["isSpecialPrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "isSpecialPrice")
            }
          }

          public var listId: Int? {
            get {
              return resultMap["listId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "listId")
            }
          }
        }
      }
    }
  }
}

public final class ManageListingsQuery: GraphQLQuery {
  public let operationDefinition =
    "query ManageListings {\n  ManageListings {\n    __typename\n    results {\n      __typename\n      id\n      title\n      city\n      updatedAt\n      coverPhoto\n      isPublished\n      isReady\n      listPhotoName\n      listPhotos {\n        __typename\n        id\n        name\n      }\n      settingsData {\n        __typename\n        listsettings {\n          __typename\n          id\n          itemName\n        }\n      }\n      listingSteps {\n        __typename\n        id\n        step1\n        step2\n        step3\n      }\n      user {\n        __typename\n        userBanStatus\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("ManageListings", type: .object(ManageListing.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(manageListings: ManageListing? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "ManageListings": manageListings.flatMap { (value: ManageListing) -> ResultMap in value.resultMap }])
    }

    public var manageListings: ManageListing? {
      get {
        return (resultMap["ManageListings"] as? ResultMap).flatMap { ManageListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "ManageListings")
      }
    }

    public struct ManageListing: GraphQLSelectionSet {
      public static let possibleTypes = ["WholeManageListingsType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "WholeManageListingsType", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("updatedAt", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
          GraphQLField("isPublished", type: .scalar(Bool.self)),
          GraphQLField("isReady", type: .scalar(Bool.self)),
          GraphQLField("listPhotoName", type: .scalar(String.self)),
          GraphQLField("listPhotos", type: .list(.object(ListPhoto.selections))),
          GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          GraphQLField("listingSteps", type: .object(ListingStep.selections)),
          GraphQLField("user", type: .object(User.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, city: String? = nil, updatedAt: String? = nil, coverPhoto: Int? = nil, isPublished: Bool? = nil, isReady: Bool? = nil, listPhotoName: String? = nil, listPhotos: [ListPhoto?]? = nil, settingsData: [SettingsDatum?]? = nil, listingSteps: ListingStep? = nil, user: User? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "title": title, "city": city, "updatedAt": updatedAt, "coverPhoto": coverPhoto, "isPublished": isPublished, "isReady": isReady, "listPhotoName": listPhotoName, "listPhotos": listPhotos.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, "listingSteps": listingSteps.flatMap { (value: ListingStep) -> ResultMap in value.resultMap }, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var city: String? {
          get {
            return resultMap["city"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var updatedAt: String? {
          get {
            return resultMap["updatedAt"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "updatedAt")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }

        public var isPublished: Bool? {
          get {
            return resultMap["isPublished"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPublished")
          }
        }

        public var isReady: Bool? {
          get {
            return resultMap["isReady"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isReady")
          }
        }

        public var listPhotoName: String? {
          get {
            return resultMap["listPhotoName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "listPhotoName")
          }
        }

        public var listPhotos: [ListPhoto?]? {
          get {
            return (resultMap["listPhotos"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [ListPhoto?] in value.map { (value: ResultMap?) -> ListPhoto? in value.flatMap { (value: ResultMap) -> ListPhoto in ListPhoto(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [ListPhoto?]) -> [ResultMap?] in value.map { (value: ListPhoto?) -> ResultMap? in value.flatMap { (value: ListPhoto) -> ResultMap in value.resultMap } } }, forKey: "listPhotos")
          }
        }

        public var settingsData: [SettingsDatum?]? {
          get {
            return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
          }
        }

        public var listingSteps: ListingStep? {
          get {
            return (resultMap["listingSteps"] as? ResultMap).flatMap { ListingStep(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingSteps")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public struct ListPhoto: GraphQLSelectionSet {
          public static let possibleTypes = ["listPhotosData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "listPhotosData", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct SettingsDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userListingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("listsettings", type: .object(Listsetting.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(listsettings: Listsetting? = nil) {
            self.init(unsafeResultMap: ["__typename": "userListingData", "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var listsettings: Listsetting? {
            get {
              return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
            }
          }

          public struct Listsetting: GraphQLSelectionSet {
            public static let possibleTypes = ["singleListSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, itemName: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }
          }
        }

        public struct ListingStep: GraphQLSelectionSet {
          public static let possibleTypes = ["userListingSteps"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("step1", type: .scalar(String.self)),
            GraphQLField("step2", type: .scalar(String.self)),
            GraphQLField("step3", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, step1: String? = nil, step2: String? = nil, step3: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "userListingSteps", "id": id, "step1": step1, "step2": step2, "step3": step3])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var step1: String? {
            get {
              return resultMap["step1"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step1")
            }
          }

          public var step2: String? {
            get {
              return resultMap["step2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step2")
            }
          }

          public var step3: String? {
            get {
              return resultMap["step3"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "step3")
            }
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["user"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("userBanStatus", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(userBanStatus: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "user", "userBanStatus": userBanStatus])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var userBanStatus: Int? {
            get {
              return resultMap["userBanStatus"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "userBanStatus")
            }
          }
        }
      }
    }
  }
}

public final class ManagePublishStatusMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation managePublishStatus($listId: Int!, $action: String!) {\n  managePublishStatus(listId: $listId, action: $action) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var listId: Int
  public var action: String

  public init(listId: Int, action: String) {
    self.listId = listId
    self.action = action
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "action": action]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("managePublishStatus", arguments: ["listId": GraphQLVariable("listId"), "action": GraphQLVariable("action")], type: .object(ManagePublishStatus.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(managePublishStatus: ManagePublishStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "managePublishStatus": managePublishStatus.flatMap { (value: ManagePublishStatus) -> ResultMap in value.resultMap }])
    }

    public var managePublishStatus: ManagePublishStatus? {
      get {
        return (resultMap["managePublishStatus"] as? ResultMap).flatMap { ManagePublishStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "managePublishStatus")
      }
    }

    public struct ManagePublishStatus: GraphQLSelectionSet {
      public static let possibleTypes = ["AllList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllList", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class ShowListingStepsQuery: GraphQLQuery {
  public let operationDefinition =
    "query ShowListingSteps($listId: String!) {\n  showListingSteps(listId: $listId) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      step1\n      step2\n      step3\n      listing {\n        __typename\n        id\n        isReady\n        isPublished\n        user {\n          __typename\n          userBanStatus\n        }\n      }\n      isPhotosAdded\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: String

  public init(listId: String) {
    self.listId = listId
  }

  public var variables: GraphQLMap? {
    return ["listId": listId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("showListingSteps", arguments: ["listId": GraphQLVariable("listId")], type: .object(ShowListingStep.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(showListingSteps: ShowListingStep? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "showListingSteps": showListingSteps.flatMap { (value: ShowListingStep) -> ResultMap in value.resultMap }])
    }

    public var showListingSteps: ShowListingStep? {
      get {
        return (resultMap["showListingSteps"] as? ResultMap).flatMap { ShowListingStep(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "showListingSteps")
      }
    }

    public struct ShowListingStep: GraphQLSelectionSet {
      public static let possibleTypes = ["ShowListingCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ShowListingCommon", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListingSteps"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("step1", type: .scalar(String.self)),
          GraphQLField("step2", type: .scalar(String.self)),
          GraphQLField("step3", type: .scalar(String.self)),
          GraphQLField("listing", type: .object(Listing.selections)),
          GraphQLField("isPhotosAdded", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, step1: String? = nil, step2: String? = nil, step3: String? = nil, listing: Listing? = nil, isPhotosAdded: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListingSteps", "id": id, "listId": listId, "step1": step1, "step2": step2, "step3": step3, "listing": listing.flatMap { (value: Listing) -> ResultMap in value.resultMap }, "isPhotosAdded": isPhotosAdded])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var step1: String? {
          get {
            return resultMap["step1"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step1")
          }
        }

        public var step2: String? {
          get {
            return resultMap["step2"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step2")
          }
        }

        public var step3: String? {
          get {
            return resultMap["step3"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step3")
          }
        }

        public var listing: Listing? {
          get {
            return (resultMap["listing"] as? ResultMap).flatMap { Listing(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listing")
          }
        }

        public var isPhotosAdded: Bool? {
          get {
            return resultMap["isPhotosAdded"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPhotosAdded")
          }
        }

        public struct Listing: GraphQLSelectionSet {
          public static let possibleTypes = ["ShowListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("isReady", type: .scalar(Bool.self)),
            GraphQLField("isPublished", type: .scalar(Bool.self)),
            GraphQLField("user", type: .object(User.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, isReady: Bool? = nil, isPublished: Bool? = nil, user: User? = nil) {
            self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "isReady": isReady, "isPublished": isPublished, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var isReady: Bool? {
            get {
              return resultMap["isReady"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isReady")
            }
          }

          public var isPublished: Bool? {
            get {
              return resultMap["isPublished"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isPublished")
            }
          }

          public var user: User? {
            get {
              return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "user")
            }
          }

          public struct User: GraphQLSelectionSet {
            public static let possibleTypes = ["user"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("userBanStatus", type: .scalar(Int.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(userBanStatus: Int? = nil) {
              self.init(unsafeResultMap: ["__typename": "user", "userBanStatus": userBanStatus])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var userBanStatus: Int? {
              get {
                return resultMap["userBanStatus"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "userBanStatus")
              }
            }
          }
        }
      }
    }
  }
}

public final class ShowListPhotosQuery: GraphQLQuery {
  public let operationDefinition =
    "query ShowListPhotos($listId: Int!) {\n  showListPhotos(listId: $listId) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      name\n      type\n      isCover\n      photosCount\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: Int

  public init(listId: Int) {
    self.listId = listId
  }

  public var variables: GraphQLMap? {
    return ["listId": listId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("showListPhotos", arguments: ["listId": GraphQLVariable("listId")], type: .object(ShowListPhoto.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(showListPhotos: ShowListPhoto? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "showListPhotos": showListPhotos.flatMap { (value: ShowListPhoto) -> ResultMap in value.resultMap }])
    }

    public var showListPhotos: ShowListPhoto? {
      get {
        return (resultMap["showListPhotos"] as? ResultMap).flatMap { ShowListPhoto(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "showListPhotos")
      }
    }

    public struct ShowListPhoto: GraphQLSelectionSet {
      public static let possibleTypes = ["ListPhotosCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ListPhotosCommon", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ListPhotos"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("listId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("type", type: .scalar(String.self)),
          GraphQLField("isCover", type: .scalar(Int.self)),
          GraphQLField("photosCount", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, listId: Int, name: String? = nil, type: String? = nil, isCover: Int? = nil, photosCount: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "ListPhotos", "id": id, "listId": listId, "name": name, "type": type, "isCover": isCover, "photosCount": photosCount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int {
          get {
            return resultMap["listId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var isCover: Int? {
          get {
            return resultMap["isCover"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "isCover")
          }
        }

        public var photosCount: Int? {
          get {
            return resultMap["photosCount"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "photosCount")
          }
        }
      }
    }
  }
}

public final class UpdateListingStep2Mutation: GraphQLMutation {
  public let operationDefinition =
    "mutation UpdateListingStep2($id: Int, $description: String, $title: String, $coverPhoto: Int) {\n  updateListingStep2(id: $id, description: $description, title: $title, coverPhoto: $coverPhoto) {\n    __typename\n    status\n    results {\n      __typename\n      id\n      title\n      description\n      coverPhoto\n    }\n    errorMessage\n  }\n}"

  public var id: Int?
  public var description: String?
  public var title: String?
  public var coverPhoto: Int?

  public init(id: Int? = nil, description: String? = nil, title: String? = nil, coverPhoto: Int? = nil) {
    self.id = id
    self.description = description
    self.title = title
    self.coverPhoto = coverPhoto
  }

  public var variables: GraphQLMap? {
    return ["id": id, "description": description, "title": title, "coverPhoto": coverPhoto]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateListingStep2", arguments: ["id": GraphQLVariable("id"), "description": GraphQLVariable("description"), "title": GraphQLVariable("title"), "coverPhoto": GraphQLVariable("coverPhoto")], type: .object(UpdateListingStep2.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateListingStep2: UpdateListingStep2? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateListingStep2": updateListingStep2.flatMap { (value: UpdateListingStep2) -> ResultMap in value.resultMap }])
    }

    public var updateListingStep2: UpdateListingStep2? {
      get {
        return (resultMap["updateListingStep2"] as? ResultMap).flatMap { UpdateListingStep2(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateListingStep2")
      }
    }

    public struct UpdateListingStep2: GraphQLSelectionSet {
      public static let possibleTypes = ["EditListingResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, results: Result? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "EditListingResponse", "status": status, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["EditListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, title: String? = nil, description: String? = nil, coverPhoto: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "EditListing", "id": id, "title": title, "description": description, "coverPhoto": coverPhoto])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }
      }
    }
  }
}

public final class GetListingDetailsStep2Query: GraphQLQuery {
  public let operationDefinition =
    "query getListingDetailsStep2($listId: String!, $preview: Boolean) {\n  getListingDetails(listId: $listId, preview: $preview) {\n    __typename\n    results {\n      __typename\n      id\n      userId\n      title\n      description\n      coverPhoto\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: String
  public var preview: Bool?

  public init(listId: String, preview: Bool? = nil) {
    self.listId = listId
    self.preview = preview
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "preview": preview]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getListingDetails", arguments: ["listId": GraphQLVariable("listId"), "preview": GraphQLVariable("preview")], type: .object(GetListingDetail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getListingDetails: GetListingDetail? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getListingDetails": getListingDetails.flatMap { (value: GetListingDetail) -> ResultMap in value.resultMap }])
    }

    public var getListingDetails: GetListingDetail? {
      get {
        return (resultMap["getListingDetails"] as? ResultMap).flatMap { GetListingDetail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getListingDetails")
      }
    }

    public struct GetListingDetail: GraphQLSelectionSet {
      public static let possibleTypes = ["AllListing"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllListing", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("description", type: .scalar(String.self)),
          GraphQLField("coverPhoto", type: .scalar(Int.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, userId: String? = nil, title: String? = nil, description: String? = nil, coverPhoto: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "userId": userId, "title": title, "description": description, "coverPhoto": coverPhoto])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var coverPhoto: Int? {
          get {
            return resultMap["coverPhoto"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "coverPhoto")
          }
        }
      }
    }
  }
}

public final class RemoveListPhotosMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation RemoveListPhotos($listId: Int!, $name: String) {\n  RemoveListPhotos(listId: $listId, name: $name) {\n    __typename\n    status\n    errorMessage\n  }\n}"

  public var listId: Int
  public var name: String?

  public init(listId: Int, name: String? = nil) {
    self.listId = listId
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("RemoveListPhotos", arguments: ["listId": GraphQLVariable("listId"), "name": GraphQLVariable("name")], type: .object(RemoveListPhoto.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeListPhotos: RemoveListPhoto? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "RemoveListPhotos": removeListPhotos.flatMap { (value: RemoveListPhoto) -> ResultMap in value.resultMap }])
    }

    public var removeListPhotos: RemoveListPhoto? {
      get {
        return (resultMap["RemoveListPhotos"] as? ResultMap).flatMap { RemoveListPhoto(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "RemoveListPhotos")
      }
    }

    public struct RemoveListPhoto: GraphQLSelectionSet {
      public static let possibleTypes = ["ListPhotosCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ListPhotosCommon", "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }
    }
  }
}

public final class ManageListingStepsMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation manageListingSteps($listId: String!, $currentStep: Int!) {\n  ManageListingSteps(listId: $listId, currentStep: $currentStep) {\n    __typename\n    results {\n      __typename\n      id\n      listId\n      step1\n      step2\n      step3\n      listing {\n        __typename\n        id\n        isReady\n        isPublished\n        user {\n          __typename\n          userBanStatus\n        }\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: String
  public var currentStep: Int

  public init(listId: String, currentStep: Int) {
    self.listId = listId
    self.currentStep = currentStep
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "currentStep": currentStep]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("ManageListingSteps", arguments: ["listId": GraphQLVariable("listId"), "currentStep": GraphQLVariable("currentStep")], type: .object(ManageListingStep.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(manageListingSteps: ManageListingStep? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "ManageListingSteps": manageListingSteps.flatMap { (value: ManageListingStep) -> ResultMap in value.resultMap }])
    }

    public var manageListingSteps: ManageListingStep? {
      get {
        return (resultMap["ManageListingSteps"] as? ResultMap).flatMap { ManageListingStep(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "ManageListingSteps")
      }
    }

    public struct ManageListingStep: GraphQLSelectionSet {
      public static let possibleTypes = ["ShowListingCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ShowListingCommon", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListingSteps"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("listId", type: .scalar(Int.self)),
          GraphQLField("step1", type: .scalar(String.self)),
          GraphQLField("step2", type: .scalar(String.self)),
          GraphQLField("step3", type: .scalar(String.self)),
          GraphQLField("listing", type: .object(Listing.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, listId: Int? = nil, step1: String? = nil, step2: String? = nil, step3: String? = nil, listing: Listing? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListingSteps", "id": id, "listId": listId, "step1": step1, "step2": step2, "step3": step3, "listing": listing.flatMap { (value: Listing) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var listId: Int? {
          get {
            return resultMap["listId"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "listId")
          }
        }

        public var step1: String? {
          get {
            return resultMap["step1"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step1")
          }
        }

        public var step2: String? {
          get {
            return resultMap["step2"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step2")
          }
        }

        public var step3: String? {
          get {
            return resultMap["step3"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "step3")
          }
        }

        public var listing: Listing? {
          get {
            return (resultMap["listing"] as? ResultMap).flatMap { Listing(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listing")
          }
        }

        public struct Listing: GraphQLSelectionSet {
          public static let possibleTypes = ["ShowListing"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("isReady", type: .scalar(Bool.self)),
            GraphQLField("isPublished", type: .scalar(Bool.self)),
            GraphQLField("user", type: .object(User.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, isReady: Bool? = nil, isPublished: Bool? = nil, user: User? = nil) {
            self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "isReady": isReady, "isPublished": isPublished, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var isReady: Bool? {
            get {
              return resultMap["isReady"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isReady")
            }
          }

          public var isPublished: Bool? {
            get {
              return resultMap["isPublished"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isPublished")
            }
          }

          public var user: User? {
            get {
              return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "user")
            }
          }

          public struct User: GraphQLSelectionSet {
            public static let possibleTypes = ["user"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("userBanStatus", type: .scalar(Int.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(userBanStatus: Int? = nil) {
              self.init(unsafeResultMap: ["__typename": "user", "userBanStatus": userBanStatus])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var userBanStatus: Int? {
              get {
                return resultMap["userBanStatus"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "userBanStatus")
              }
            }
          }
        }
      }
    }
  }
}

public final class RemoveListingMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation RemoveListing($listId: Int!) {\n  RemoveListing(listId: $listId) {\n    __typename\n    results {\n      __typename\n      id\n      name\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: Int

  public init(listId: Int) {
    self.listId = listId
  }

  public var variables: GraphQLMap? {
    return ["listId": listId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("RemoveListing", arguments: ["listId": GraphQLVariable("listId")], type: .object(RemoveListing.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeListing: RemoveListing? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "RemoveListing": removeListing.flatMap { (value: RemoveListing) -> ResultMap in value.resultMap }])
    }

    public var removeListing: RemoveListing? {
      get {
        return (resultMap["RemoveListing"] as? ResultMap).flatMap { RemoveListing(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "RemoveListing")
      }
    }

    public struct RemoveListing: GraphQLSelectionSet {
      public static let possibleTypes = ["ListPhotosCommon"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .list(.object(Result.selections))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: [Result?]? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "ListPhotosCommon", "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: [Result?]? {
        get {
          return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ListPhotos"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .scalar(String.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "ListPhotos", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}

public final class GetStep1ListingDetailsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getStep1ListingDetails($listId: String!, $preview: Boolean) {\n  getListingDetails(listId: $listId, preview: $preview) {\n    __typename\n    status\n    errorMessage\n    results {\n      __typename\n      id\n      userId\n      country\n      street\n      buildingName\n      city\n      state\n      zipcode\n      lat\n      lng\n      isMapTouched\n      bedrooms\n      residenceType\n      beds\n      personCapacity\n      bathrooms\n      user {\n        __typename\n        email\n        userBanStatus\n        profile {\n          __typename\n          firstName\n          lastName\n          dateOfBirth\n        }\n      }\n      userAmenities {\n        __typename\n        id\n        itemName\n      }\n      userSafetyAmenities {\n        __typename\n        id\n        itemName\n      }\n      userSpaces {\n        __typename\n        id\n        itemName\n      }\n      settingsData {\n        __typename\n        id\n        settingsId\n        listsettings {\n          __typename\n          id\n          itemName\n          settingsType {\n            __typename\n            typeName\n          }\n        }\n      }\n      userBedsTypes {\n        __typename\n        id\n        listId\n        bedCount\n        bedType\n      }\n    }\n  }\n}"

  public var listId: String
  public var preview: Bool?

  public init(listId: String, preview: Bool? = nil) {
    self.listId = listId
    self.preview = preview
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "preview": preview]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getListingDetails", arguments: ["listId": GraphQLVariable("listId"), "preview": GraphQLVariable("preview")], type: .object(GetListingDetail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getListingDetails: GetListingDetail? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getListingDetails": getListingDetails.flatMap { (value: GetListingDetail) -> ResultMap in value.resultMap }])
    }

    public var getListingDetails: GetListingDetail? {
      get {
        return (resultMap["getListingDetails"] as? ResultMap).flatMap { GetListingDetail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getListingDetails")
      }
    }

    public struct GetListingDetail: GraphQLSelectionSet {
      public static let possibleTypes = ["AllListing"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
        GraphQLField("results", type: .object(Result.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: Int? = nil, errorMessage: String? = nil, results: Result? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllListing", "status": status, "errorMessage": errorMessage, "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("country", type: .scalar(String.self)),
          GraphQLField("street", type: .scalar(String.self)),
          GraphQLField("buildingName", type: .scalar(String.self)),
          GraphQLField("city", type: .scalar(String.self)),
          GraphQLField("state", type: .scalar(String.self)),
          GraphQLField("zipcode", type: .scalar(String.self)),
          GraphQLField("lat", type: .scalar(Double.self)),
          GraphQLField("lng", type: .scalar(Double.self)),
          GraphQLField("isMapTouched", type: .scalar(Bool.self)),
          GraphQLField("bedrooms", type: .scalar(String.self)),
          GraphQLField("residenceType", type: .scalar(String.self)),
          GraphQLField("beds", type: .scalar(Int.self)),
          GraphQLField("personCapacity", type: .scalar(Int.self)),
          GraphQLField("bathrooms", type: .scalar(Double.self)),
          GraphQLField("user", type: .object(User.selections)),
          GraphQLField("userAmenities", type: .list(.object(UserAmenity.selections))),
          GraphQLField("userSafetyAmenities", type: .list(.object(UserSafetyAmenity.selections))),
          GraphQLField("userSpaces", type: .list(.object(UserSpace.selections))),
          GraphQLField("settingsData", type: .list(.object(SettingsDatum.selections))),
          GraphQLField("userBedsTypes", type: .list(.object(UserBedsType.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, userId: String? = nil, country: String? = nil, street: String? = nil, buildingName: String? = nil, city: String? = nil, state: String? = nil, zipcode: String? = nil, lat: Double? = nil, lng: Double? = nil, isMapTouched: Bool? = nil, bedrooms: String? = nil, residenceType: String? = nil, beds: Int? = nil, personCapacity: Int? = nil, bathrooms: Double? = nil, user: User? = nil, userAmenities: [UserAmenity?]? = nil, userSafetyAmenities: [UserSafetyAmenity?]? = nil, userSpaces: [UserSpace?]? = nil, settingsData: [SettingsDatum?]? = nil, userBedsTypes: [UserBedsType?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "userId": userId, "country": country, "street": street, "buildingName": buildingName, "city": city, "state": state, "zipcode": zipcode, "lat": lat, "lng": lng, "isMapTouched": isMapTouched, "bedrooms": bedrooms, "residenceType": residenceType, "beds": beds, "personCapacity": personCapacity, "bathrooms": bathrooms, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "userAmenities": userAmenities.flatMap { (value: [UserAmenity?]) -> [ResultMap?] in value.map { (value: UserAmenity?) -> ResultMap? in value.flatMap { (value: UserAmenity) -> ResultMap in value.resultMap } } }, "userSafetyAmenities": userSafetyAmenities.flatMap { (value: [UserSafetyAmenity?]) -> [ResultMap?] in value.map { (value: UserSafetyAmenity?) -> ResultMap? in value.flatMap { (value: UserSafetyAmenity) -> ResultMap in value.resultMap } } }, "userSpaces": userSpaces.flatMap { (value: [UserSpace?]) -> [ResultMap?] in value.map { (value: UserSpace?) -> ResultMap? in value.flatMap { (value: UserSpace) -> ResultMap in value.resultMap } } }, "settingsData": settingsData.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, "userBedsTypes": userBedsTypes.flatMap { (value: [UserBedsType?]) -> [ResultMap?] in value.map { (value: UserBedsType?) -> ResultMap? in value.flatMap { (value: UserBedsType) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var country: String? {
          get {
            return resultMap["country"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "country")
          }
        }

        public var street: String? {
          get {
            return resultMap["street"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "street")
          }
        }

        public var buildingName: String? {
          get {
            return resultMap["buildingName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "buildingName")
          }
        }

        public var city: String? {
          get {
            return resultMap["city"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "city")
          }
        }

        public var state: String? {
          get {
            return resultMap["state"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "state")
          }
        }

        public var zipcode: String? {
          get {
            return resultMap["zipcode"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "zipcode")
          }
        }

        public var lat: Double? {
          get {
            return resultMap["lat"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lat")
          }
        }

        public var lng: Double? {
          get {
            return resultMap["lng"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "lng")
          }
        }

        public var isMapTouched: Bool? {
          get {
            return resultMap["isMapTouched"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isMapTouched")
          }
        }

        public var bedrooms: String? {
          get {
            return resultMap["bedrooms"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bedrooms")
          }
        }

        public var residenceType: String? {
          get {
            return resultMap["residenceType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "residenceType")
          }
        }

        public var beds: Int? {
          get {
            return resultMap["beds"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "beds")
          }
        }

        public var personCapacity: Int? {
          get {
            return resultMap["personCapacity"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "personCapacity")
          }
        }

        public var bathrooms: Double? {
          get {
            return resultMap["bathrooms"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "bathrooms")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public var userAmenities: [UserAmenity?]? {
          get {
            return (resultMap["userAmenities"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserAmenity?] in value.map { (value: ResultMap?) -> UserAmenity? in value.flatMap { (value: ResultMap) -> UserAmenity in UserAmenity(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserAmenity?]) -> [ResultMap?] in value.map { (value: UserAmenity?) -> ResultMap? in value.flatMap { (value: UserAmenity) -> ResultMap in value.resultMap } } }, forKey: "userAmenities")
          }
        }

        public var userSafetyAmenities: [UserSafetyAmenity?]? {
          get {
            return (resultMap["userSafetyAmenities"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserSafetyAmenity?] in value.map { (value: ResultMap?) -> UserSafetyAmenity? in value.flatMap { (value: ResultMap) -> UserSafetyAmenity in UserSafetyAmenity(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserSafetyAmenity?]) -> [ResultMap?] in value.map { (value: UserSafetyAmenity?) -> ResultMap? in value.flatMap { (value: UserSafetyAmenity) -> ResultMap in value.resultMap } } }, forKey: "userSafetyAmenities")
          }
        }

        public var userSpaces: [UserSpace?]? {
          get {
            return (resultMap["userSpaces"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserSpace?] in value.map { (value: ResultMap?) -> UserSpace? in value.flatMap { (value: ResultMap) -> UserSpace in UserSpace(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserSpace?]) -> [ResultMap?] in value.map { (value: UserSpace?) -> ResultMap? in value.flatMap { (value: UserSpace) -> ResultMap in value.resultMap } } }, forKey: "userSpaces")
          }
        }

        public var settingsData: [SettingsDatum?]? {
          get {
            return (resultMap["settingsData"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [SettingsDatum?] in value.map { (value: ResultMap?) -> SettingsDatum? in value.flatMap { (value: ResultMap) -> SettingsDatum in SettingsDatum(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [SettingsDatum?]) -> [ResultMap?] in value.map { (value: SettingsDatum?) -> ResultMap? in value.flatMap { (value: SettingsDatum) -> ResultMap in value.resultMap } } }, forKey: "settingsData")
          }
        }

        public var userBedsTypes: [UserBedsType?]? {
          get {
            return (resultMap["userBedsTypes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [UserBedsType?] in value.map { (value: ResultMap?) -> UserBedsType? in value.flatMap { (value: ResultMap) -> UserBedsType in UserBedsType(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [UserBedsType?]) -> [ResultMap?] in value.map { (value: UserBedsType?) -> ResultMap? in value.flatMap { (value: UserBedsType) -> ResultMap in value.resultMap } } }, forKey: "userBedsTypes")
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes = ["user"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("email", type: .scalar(String.self)),
            GraphQLField("userBanStatus", type: .scalar(Int.self)),
            GraphQLField("profile", type: .object(Profile.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(email: String? = nil, userBanStatus: Int? = nil, profile: Profile? = nil) {
            self.init(unsafeResultMap: ["__typename": "user", "email": email, "userBanStatus": userBanStatus, "profile": profile.flatMap { (value: Profile) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var email: String? {
            get {
              return resultMap["email"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "email")
            }
          }

          public var userBanStatus: Int? {
            get {
              return resultMap["userBanStatus"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "userBanStatus")
            }
          }

          public var profile: Profile? {
            get {
              return (resultMap["profile"] as? ResultMap).flatMap { Profile(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "profile")
            }
          }

          public struct Profile: GraphQLSelectionSet {
            public static let possibleTypes = ["profile"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("firstName", type: .scalar(String.self)),
              GraphQLField("lastName", type: .scalar(String.self)),
              GraphQLField("dateOfBirth", type: .scalar(String.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(firstName: String? = nil, lastName: String? = nil, dateOfBirth: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "profile", "firstName": firstName, "lastName": lastName, "dateOfBirth": dateOfBirth])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var firstName: String? {
              get {
                return resultMap["firstName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "firstName")
              }
            }

            public var lastName: String? {
              get {
                return resultMap["lastName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "lastName")
              }
            }

            public var dateOfBirth: String? {
              get {
                return resultMap["dateOfBirth"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "dateOfBirth")
              }
            }
          }
        }

        public struct UserAmenity: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct UserSafetyAmenity: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct UserSpace: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("itemName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, itemName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id, "itemName": itemName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var itemName: String? {
            get {
              return resultMap["itemName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "itemName")
            }
          }
        }

        public struct SettingsDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["userListingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("settingsId", type: .scalar(Int.self)),
            GraphQLField("listsettings", type: .object(Listsetting.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, settingsId: Int? = nil, listsettings: Listsetting? = nil) {
            self.init(unsafeResultMap: ["__typename": "userListingData", "id": id, "settingsId": settingsId, "listsettings": listsettings.flatMap { (value: Listsetting) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var settingsId: Int? {
            get {
              return resultMap["settingsId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "settingsId")
            }
          }

          public var listsettings: Listsetting? {
            get {
              return (resultMap["listsettings"] as? ResultMap).flatMap { Listsetting(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "listsettings")
            }
          }

          public struct Listsetting: GraphQLSelectionSet {
            public static let possibleTypes = ["singleListSettings"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .scalar(Int.self)),
              GraphQLField("itemName", type: .scalar(String.self)),
              GraphQLField("settingsType", type: .object(SettingsType.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int? = nil, itemName: String? = nil, settingsType: SettingsType? = nil) {
              self.init(unsafeResultMap: ["__typename": "singleListSettings", "id": id, "itemName": itemName, "settingsType": settingsType.flatMap { (value: SettingsType) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int? {
              get {
                return resultMap["id"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var itemName: String? {
              get {
                return resultMap["itemName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "itemName")
              }
            }

            public var settingsType: SettingsType? {
              get {
                return (resultMap["settingsType"] as? ResultMap).flatMap { SettingsType(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "settingsType")
              }
            }

            public struct SettingsType: GraphQLSelectionSet {
              public static let possibleTypes = ["listSettingsTypes"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("typeName", type: .scalar(String.self)),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(typeName: String? = nil) {
                self.init(unsafeResultMap: ["__typename": "listSettingsTypes", "typeName": typeName])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var typeName: String? {
                get {
                  return resultMap["typeName"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "typeName")
                }
              }
            }
          }
        }

        public struct UserBedsType: GraphQLSelectionSet {
          public static let possibleTypes = ["BedTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
            GraphQLField("listId", type: .scalar(Int.self)),
            GraphQLField("bedCount", type: .scalar(Int.self)),
            GraphQLField("bedType", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil, listId: Int? = nil, bedCount: Int? = nil, bedType: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "BedTypes", "id": id, "listId": listId, "bedCount": bedCount, "bedType": bedType])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var listId: Int? {
            get {
              return resultMap["listId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "listId")
            }
          }

          public var bedCount: Int? {
            get {
              return resultMap["bedCount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "bedCount")
            }
          }

          public var bedType: Int? {
            get {
              return resultMap["bedType"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "bedType")
            }
          }
        }
      }
    }
  }
}

public final class GetListingDetailsStep3Query: GraphQLQuery {
  public let operationDefinition =
    "query GetListingDetailsStep3($listId: String!, $preview: Boolean) {\n  getListingDetails(listId: $listId, preview: $preview) {\n    __typename\n    results {\n      __typename\n      id\n      userId\n      bookingType\n      isPublished\n      houseRules {\n        __typename\n        id\n      }\n      listingData {\n        __typename\n        bookingNoticeTime\n        checkInStart\n        checkInEnd\n        maxDaysNotice\n        minNight\n        maxNight\n        basePrice\n        cleaningPrice\n        currency\n        weeklyDiscount\n        monthlyDiscount\n        cancellationPolicy\n      }\n      blockedDates {\n        __typename\n        blockedDates\n        reservationId\n      }\n      calendars {\n        __typename\n        id\n        name\n        url\n        listId\n        status\n      }\n    }\n    status\n    errorMessage\n  }\n}"

  public var listId: String
  public var preview: Bool?

  public init(listId: String, preview: Bool? = nil) {
    self.listId = listId
    self.preview = preview
  }

  public var variables: GraphQLMap? {
    return ["listId": listId, "preview": preview]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getListingDetails", arguments: ["listId": GraphQLVariable("listId"), "preview": GraphQLVariable("preview")], type: .object(GetListingDetail.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getListingDetails: GetListingDetail? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getListingDetails": getListingDetails.flatMap { (value: GetListingDetail) -> ResultMap in value.resultMap }])
    }

    public var getListingDetails: GetListingDetail? {
      get {
        return (resultMap["getListingDetails"] as? ResultMap).flatMap { GetListingDetail(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getListingDetails")
      }
    }

    public struct GetListingDetail: GraphQLSelectionSet {
      public static let possibleTypes = ["AllListing"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("results", type: .object(Result.selections)),
        GraphQLField("status", type: .scalar(Int.self)),
        GraphQLField("errorMessage", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(results: Result? = nil, status: Int? = nil, errorMessage: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "AllListing", "results": results.flatMap { (value: Result) -> ResultMap in value.resultMap }, "status": status, "errorMessage": errorMessage])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var results: Result? {
        get {
          return (resultMap["results"] as? ResultMap).flatMap { Result(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "results")
        }
      }

      public var status: Int? {
        get {
          return resultMap["status"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public struct Result: GraphQLSelectionSet {
        public static let possibleTypes = ["ShowListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("userId", type: .scalar(String.self)),
          GraphQLField("bookingType", type: .scalar(String.self)),
          GraphQLField("isPublished", type: .scalar(Bool.self)),
          GraphQLField("houseRules", type: .list(.object(HouseRule.selections))),
          GraphQLField("listingData", type: .object(ListingDatum.selections)),
          GraphQLField("blockedDates", type: .list(.object(BlockedDate.selections))),
          GraphQLField("calendars", type: .list(.object(Calendar.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int? = nil, userId: String? = nil, bookingType: String? = nil, isPublished: Bool? = nil, houseRules: [HouseRule?]? = nil, listingData: ListingDatum? = nil, blockedDates: [BlockedDate?]? = nil, calendars: [Calendar?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ShowListing", "id": id, "userId": userId, "bookingType": bookingType, "isPublished": isPublished, "houseRules": houseRules.flatMap { (value: [HouseRule?]) -> [ResultMap?] in value.map { (value: HouseRule?) -> ResultMap? in value.flatMap { (value: HouseRule) -> ResultMap in value.resultMap } } }, "listingData": listingData.flatMap { (value: ListingDatum) -> ResultMap in value.resultMap }, "blockedDates": blockedDates.flatMap { (value: [BlockedDate?]) -> [ResultMap?] in value.map { (value: BlockedDate?) -> ResultMap? in value.flatMap { (value: BlockedDate) -> ResultMap in value.resultMap } } }, "calendars": calendars.flatMap { (value: [Calendar?]) -> [ResultMap?] in value.map { (value: Calendar?) -> ResultMap? in value.flatMap { (value: Calendar) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int? {
          get {
            return resultMap["id"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var userId: String? {
          get {
            return resultMap["userId"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var bookingType: String? {
          get {
            return resultMap["bookingType"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "bookingType")
          }
        }

        public var isPublished: Bool? {
          get {
            return resultMap["isPublished"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isPublished")
          }
        }

        public var houseRules: [HouseRule?]? {
          get {
            return (resultMap["houseRules"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [HouseRule?] in value.map { (value: ResultMap?) -> HouseRule? in value.flatMap { (value: ResultMap) -> HouseRule in HouseRule(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [HouseRule?]) -> [ResultMap?] in value.map { (value: HouseRule?) -> ResultMap? in value.flatMap { (value: HouseRule) -> ResultMap in value.resultMap } } }, forKey: "houseRules")
          }
        }

        public var listingData: ListingDatum? {
          get {
            return (resultMap["listingData"] as? ResultMap).flatMap { ListingDatum(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "listingData")
          }
        }

        public var blockedDates: [BlockedDate?]? {
          get {
            return (resultMap["blockedDates"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [BlockedDate?] in value.map { (value: ResultMap?) -> BlockedDate? in value.flatMap { (value: ResultMap) -> BlockedDate in BlockedDate(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [BlockedDate?]) -> [ResultMap?] in value.map { (value: BlockedDate?) -> ResultMap? in value.flatMap { (value: BlockedDate) -> ResultMap in value.resultMap } } }, forKey: "blockedDates")
          }
        }

        public var calendars: [Calendar?]? {
          get {
            return (resultMap["calendars"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Calendar?] in value.map { (value: ResultMap?) -> Calendar? in value.flatMap { (value: ResultMap) -> Calendar in Calendar(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Calendar?]) -> [ResultMap?] in value.map { (value: Calendar?) -> ResultMap? in value.flatMap { (value: Calendar) -> ResultMap in value.resultMap } } }, forKey: "calendars")
          }
        }

        public struct HouseRule: GraphQLSelectionSet {
          public static let possibleTypes = ["allListSettingTypes"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "allListSettingTypes", "id": id])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int? {
            get {
              return resultMap["id"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }
        }

        public struct ListingDatum: GraphQLSelectionSet {
          public static let possibleTypes = ["listingData"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("bookingNoticeTime", type: .scalar(String.self)),
            GraphQLField("checkInStart", type: .scalar(String.self)),
            GraphQLField("checkInEnd", type: .scalar(String.self)),
            GraphQLField("maxDaysNotice", type: .scalar(String.self)),
            GraphQLField("minNight", type: .scalar(Int.self)),
            GraphQLField("maxNight", type: .scalar(Int.self)),
            GraphQLField("basePrice", type: .scalar(Double.self)),
            GraphQLField("cleaningPrice", type: .scalar(Double.self)),
            GraphQLField("currency", type: .scalar(String.self)),
            GraphQLField("weeklyDiscount", type: .scalar(Int.self)),
            GraphQLField("monthlyDiscount", type: .scalar(Int.self)),
            GraphQLField("cancellationPolicy", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(bookingNoticeTime: String? = nil, checkInStart: String? = nil, checkInEnd: String? = nil, maxDaysNotice: String? = nil, minNight: Int? = nil, maxNight: Int? = nil, basePrice: Double? = nil, cleaningPrice: Double? = nil, currency: String? = nil, weeklyDiscount: Int? = nil, monthlyDiscount: Int? = nil, cancellationPolicy: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "listingData", "bookingNoticeTime": bookingNoticeTime, "checkInStart": checkInStart, "checkInEnd": checkInEnd, "maxDaysNotice": maxDaysNotice, "minNight": minNight, "maxNight": maxNight, "basePrice": basePrice, "cleaningPrice": cleaningPrice, "currency": currency, "weeklyDiscount": weeklyDiscount, "monthlyDiscount": monthlyDiscount, "cancellationPolicy": cancellationPolicy])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var bookingNoticeTime: String? {
            get {
              return resultMap["bookingNoticeTime"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "bookingNoticeTime")
            }
          }

          public var checkInStart: String? {
            get {
              return resultMap["checkInStart"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "checkInStart")
            }
          }

          public var checkInEnd: String? {
            get {
              return resultMap["checkInEnd"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "checkInEnd")
            }
          }

          public var maxDaysNotice: String? {
            get {
              return resultMap["maxDaysNotice"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxDaysNotice")
            }
          }

          public var minNight: Int? {
            get {
              return resultMap["minNight"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "minNight")
            }
          }

          public var maxNight: Int? {
            get {
              return resultMap["maxNight"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "maxNight")
            }
          }

          public var basePrice: Double? {
            get {
              return resultMap["basePrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "basePrice")
            }
          }

          public var cleaningPrice: Double? {
            get {
              return resultMap["cleaningPrice"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "cleaningPrice")
            }
          }

          public var currency: String? {
            get {
              return resultMap["currency"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "currency")
            }
          }

          public var weeklyDiscount: Int? {
            get {
              return resultMap["weeklyDiscount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "weeklyDiscount")
            }
          }

          public var monthlyDiscount: Int? {
            get {
              return resultMap["monthlyDiscount"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "monthlyDiscount")
            }
          }

          public var cancellationPolicy: Int? {
            get {
              return resultMap["cancellationPolicy"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "cancellationPolicy")
            }
          }
        }

        public struct BlockedDate: GraphQLSelectionSet {
          public static let possibleTypes = ["listBlockedDates"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("blockedDates", type: .scalar(String.self)),
            GraphQLField("reservationId", type: .scalar(Int.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(blockedDates: String? = nil, reservationId: Int? = nil) {
            self.init(unsafeResultMap: ["__typename": "listBlockedDates", "blockedDates": blockedDates, "reservationId": reservationId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var blockedDates: String? {
            get {
              return resultMap["blockedDates"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "blockedDates")
            }
          }

          public var reservationId: Int? {
            get {
              return resultMap["reservationId"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "reservationId")
            }
          }
        }

        public struct Calendar: GraphQLSelectionSet {
          public static let possibleTypes = ["ListCalendar"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("url", type: .scalar(String.self)),
            GraphQLField("listId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("status", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String? = nil, url: String? = nil, listId: Int, status: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "ListCalendar", "id": id, "name": name, "url": url, "listId": listId, "status": status])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var url: String? {
            get {
              return resultMap["url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }

          public var listId: Int {
            get {
              return resultMap["listId"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "listId")
            }
          }

          public var status: String? {
            get {
              return resultMap["status"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "status")
            }
          }
        }
      }
    }
  }
}

public struct ProfileFields: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment profileFields on userProfile {\n  __typename\n  profileId\n  firstName\n  lastName\n  picture\n  location\n}"

  public static let possibleTypes = ["userProfile"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("profileId", type: .scalar(Int.self)),
    GraphQLField("firstName", type: .scalar(String.self)),
    GraphQLField("lastName", type: .scalar(String.self)),
    GraphQLField("picture", type: .scalar(String.self)),
    GraphQLField("location", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(profileId: Int? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil, location: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "userProfile", "profileId": profileId, "firstName": firstName, "lastName": lastName, "picture": picture, "location": location])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var profileId: Int? {
    get {
      return resultMap["profileId"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "profileId")
    }
  }

  public var firstName: String? {
    get {
      return resultMap["firstName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var picture: String? {
    get {
      return resultMap["picture"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "picture")
    }
  }

  public var location: String? {
    get {
      return resultMap["location"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "location")
    }
  }
}