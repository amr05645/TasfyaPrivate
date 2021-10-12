//
//  AllOrder.swift
//  Tasfya
//
//  Created by BMS on 10/10/2021.
//


import Foundation

// MARK: - Welcome
struct AllOrder: Codable {
    var success: String?
    var data: [OrderData]?
    var message: String?
}

// MARK: - WelcomeDatum
struct OrderData: Codable {
    var ordersID, totalTax, customersID, customersName: String?
    var customersCompany: String?
    var customersStreetAddress, customersSuburb, customersCity, customersPostcode: String?
    var customersState, customersCountry, customersTelephone, email: String?
    var customersAddressFormatID: String?
    var deliveryName: String?
    var deliveryCompany: String?
    var deliveryStreetAddress, deliverySuburb, deliveryCity, deliveryPostcode: String?
    var deliveryState, deliveryCountry: String?
    var deliveryAddressFormatID: String?
    var billingName: String?
    var billingCompany: String?
    var billingStreetAddress, billingSuburb, billingCity, billingPostcode: String?
    var billingState, billingCountry, billingAddressFormatID, paymentMethod: String?
    var ccType, ccOwner, ccNumber, ccExpires: String?
    var lastModified, datePurchased: String?
    var ordersDateFinished: String?
    var currency: String?
    var currencyValue: String?
    var orderPrice, shippingCost, shippingMethod: String?
    var shippingDuration: String?
    var orderInformation, isSeen, couponAmount, excludeProductIDS: String?
    var productCategories, excludedProductCategories, freeShipping, productIDS: String?
    var orderedSource, deliveryPhone, billingPhone: String?
    var transactionID: String?
    var coupons: [String]?
    var ordersStatusID, ordersStatus, customerComments, adminComments: String?
    var data: [DatumDatum]?

    enum CodingKeys: String, CodingKey {
        case ordersID = "orders_id"
        case totalTax = "total_tax"
        case customersID = "customers_id"
        case customersName = "customers_name"
        case customersCompany = "customers_company"
        case customersStreetAddress = "customers_street_address"
        case customersSuburb = "customers_suburb"
        case customersCity = "customers_city"
        case customersPostcode = "customers_postcode"
        case customersState = "customers_state"
        case customersCountry = "customers_country"
        case customersTelephone = "customers_telephone"
        case email = "customers_email_address"
        case customersAddressFormatID = "customers_address_format_id"
        case deliveryName = "delivery_name"
        case deliveryCompany = "delivery_company"
        case deliveryStreetAddress = "delivery_street_address"
        case deliverySuburb = "delivery_suburb"
        case deliveryCity = "delivery_city"
        case deliveryPostcode = "delivery_postcode"
        case deliveryState = "delivery_state"
        case deliveryCountry = "delivery_country"
        case deliveryAddressFormatID = "delivery_address_format_id"
        case billingName = "billing_name"
        case billingCompany = "billing_company"
        case billingStreetAddress = "billing_street_address"
        case billingSuburb = "billing_suburb"
        case billingCity = "billing_city"
        case billingPostcode = "billing_postcode"
        case billingState = "billing_state"
        case billingCountry = "billing_country"
        case billingAddressFormatID = "billing_address_format_id"
        case paymentMethod = "payment_method"
        case ccType = "cc_type"
        case ccOwner = "cc_owner"
        case ccNumber = "cc_number"
        case ccExpires = "cc_expires"
        case lastModified = "last_modified"
        case datePurchased = "date_purchased"
        case ordersDateFinished = "orders_date_finished"
        case currency = "currency"
        case currencyValue = "currency_value"
        case orderPrice = "order_price"
        case shippingCost = "shipping_cost"
        case shippingMethod = "shipping_method"
        case shippingDuration = "shipping_duration"
        case orderInformation = "order_information"
        case isSeen = "is_seen"
        case couponAmount = "coupon_amount"
        case excludeProductIDS = "exclude_product_ids"
        case productCategories = "product_categories"
        case excludedProductCategories = "excluded_product_categories"
        case freeShipping = "free_shipping"
        case productIDS = "product_ids"
        case orderedSource = "ordered_source"
        case deliveryPhone = "delivery_phone"
        case billingPhone = "billing_phone"
        case transactionID = "transaction_id"
        case coupons = "coupons"
        case ordersStatusID = "orders_status_id"
        case ordersStatus = "orders_status"
        case customerComments = "customer_comments"
        case adminComments = "admin_comments"
        case data = "data"
    }
}

// MARK: - DatumDatum
struct DatumDatum: Codable {
    var ordersProductsID, ordersID, productsID: String?
    var productsModel: String?
    var productsName: String?
    var productsPrice, finalPrice, productsTax, productsQuantity: String?
    var image, categoriesDescriptionID, categoriesID, languageID: String?
    var categoriesName: String?
    var attributes: [OrderAttribute]?

    enum CodingKeys: String, CodingKey {
        case ordersProductsID = "orders_products_id"
        case ordersID = "orders_id"
        case productsID = "products_id"
        case productsModel = "products_model"
        case productsName = "products_name"
        case productsPrice = "products_price"
        case finalPrice = "final_price"
        case productsTax = "products_tax"
        case productsQuantity = "products_quantity"
        case image = "image"
        case categoriesDescriptionID = "categories_description_id"
        case categoriesID = "categories_id"
        case languageID = "language_id"
        case categoriesName = "categories_name"
        case attributes
    }
}
struct OrderAttribute: Codable {
    var ordersProductsAttributesID, ordersID, ordersProductsID, productsID: String?
    var productsOptions: String?
    var productsOptionsValues, optionsValuesPrice: String?
    var pricePrefix: String?

    enum CodingKeys: String, CodingKey {
        case ordersProductsAttributesID = "orders_products_attributes_id"
        case ordersID = "orders_id"
        case ordersProductsID = "orders_products_id"
        case productsID = "products_id"
        case productsOptions = "products_options"
        case productsOptionsValues = "products_options_values"
        case optionsValuesPrice = "options_values_price"
        case pricePrefix = "price_prefix"
    }
}

//enum ProductsName: String, Codable {
//    case standardFitCottonPopover = "STANDARD FIT COTTON POPOVER"
//    case test = "test"
//}

