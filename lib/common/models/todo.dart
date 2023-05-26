class TodoTrial {
  int? id;
  String? title;
  String? desc;
  String? createdAt;
 

  TodoTrial({
    this.id,
    this.title,
    this.desc,
    this.createdAt,
   
  });

  TodoTrial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    createdAt = json['createdAt'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    return data;
  }
}
