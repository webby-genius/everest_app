class ApiUrlPage {
  static String baseUrl = "https://thameserp.pixelscloud.co.uk";
  static String pathUrl = "/api/MobileApp";

  // ------ POST API ( LOGIN FLOW )------
  // static String loginUrls = "https://thameserp.pixelscloud.co.uk/oauth/token";
  static String loginUrl = "$baseUrl/oauth/token";
  static String userInfoUrl = "$baseUrl$pathUrl/GetCurrentUserInfo";
  static String categoryUrl = "$baseUrl$pathUrl/GetCategoryList";
  static String itemListUrl = "$baseUrl$pathUrl/GetItemList";
  static String getSingleItemByBarcodeUrl = "$baseUrl$pathUrl/GetSingleItemByBarcode";
  static String saveOrderCartUrl = "$baseUrl$pathUrl/UpdateCart";
  static String proceedToOrderUrl = "$baseUrl$pathUrl/AddNewSale";
  static String getShoppingCartItemListUrl = "$baseUrl$pathUrl/GetShoppingCartItemList";
  static String getCustomerOrdersUrl = "$baseUrl$pathUrl/GetCustomerOrders";
}
