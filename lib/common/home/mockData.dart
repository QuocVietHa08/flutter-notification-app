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

class Event {
  String time;
  List<String> tags;
  String title;
  int status;
  int people;
  String address;


  Event(this.time, this.tags, this.title, this.address, this.people, this.status);
}

List <Event> getEventMockData() {
  return [
    Event("17:00 17/05/2023", ["Relipa"], "Gala Dinner", "FLC Resort Ballroom", 103, 1),
    Event("17:00 17/05/2023", ["Bo"], "Uong coffee ban tron", "Secret Room", 11, 2),
    Event("17:00 17/05/2023", ["Relipa"], "Di tam bien", "Bai tam", 11, 0 ),

  ];
}