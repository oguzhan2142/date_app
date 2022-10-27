enum OrderImageType { API, WILL_UPLOAD, API_DELETE }

class OrderImage {
  final OrderImageType orderImageType;
  final dynamic data;

  OrderImage({
    required this.orderImageType,
    this.data,
  });
}
