class Notification {
  String time;
  bool isImportant;
  List<String> tags;
  String title;
  String content;

   Notification(this.time, this.title, this.content, this.tags, this.isImportant);
}

List <Notification> getNotificationMockData() {
  return [
    Notification("17/05/2023", "Thong bao di - hon trong mai", "Hòn Trống Mái là một tuyệt tác của thiên nhiên khiến bất cứ ai cũng phải trầm trồ. Nơi đây đã trở thành nguồn cảm hứng cho nhiều nghệ sĩ, trở thành hình ảnh nổi bật trong thơ ca và các tác phẩm nghệ thuật", ["BO", "Relipa"], false),
    Notification("17/05/2023", "An choi team BO", "An choi team BO", ["BO", "Marketing", "HR"], true)
  ];
}