class InteractionEntity{
  InteractionType interactionType;
  NewsIDEntity newsIDEntity;
  InteractionEntity({required this.interactionType,required this.newsIDEntity});
}


enum InteractionType {SeeLess,SeeMore,Mute,Report}

extension InteractionTypeExtention on InteractionType {
  String get value {
    switch (this) {
      case InteractionType.SeeMore:
        return "see-more";
      case InteractionType.SeeLess:
        return "see-less";
      case InteractionType.Report:
        return "report-story";
      case InteractionType.Mute:
        return "mute-story";
    }
  }
}

class NewsIDEntity{
  String newsID;
  NewsIDEntity({required this.newsID});

  Map<String,dynamic> toJson(){
    return {
      "newsId":newsID
    };
  }
}