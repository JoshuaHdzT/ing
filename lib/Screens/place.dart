class EnglishPlace{
  EnglishPlace({
    required this.name,
    required this.user,
    required this.imagesUrl,
    this.id = '',
    this.description = '',
    this.locationDesc = '',
    this.statusTag = StatusTag.popular,
    this.shared = 0,
    this.likes = 0,

  });

  final String id;
  final String name;
  final EnglishUser user;
  final StatusTag statusTag;
  final int shared;
  final int likes;
  final String locationDesc;
  final String description;
  final List<String> imagesUrl;

  static final places =[
    EnglishPlace(
      id: '3',
      name: 'Colores Primarios',
      likes: 500,
      shared: 240,
      description:
      'El verbo tobe es un elemento escencial para saber hacer originalmente oraciones en ingles',
      imagesUrl:[
        'https://cdn.pixabay.com/photo/2017/10/11/17/09/read-2841723_640.jpg'

      ],
      statusTag: StatusTag.popular,
      user: EnglishUser.alex,
      locationDesc: 'Aprendamos',
    ),
    EnglishPlace(
      id: '1',
      name: 'Colores Secundarios',
      likes: 159,
      shared: 49,
      description:
      'Los colores son algo basico',
      imagesUrl:[
        'https://cdn.pixabay.com/photo/2017/10/11/17/09/read-2841723_640.jpg'

      ],
      statusTag: StatusTag.event,
      user: EnglishUser.jafet,
      locationDesc: 'Aprendamos',
    ),
    EnglishPlace(
      id: '2',
      name: 'Aplicaciones',
      likes: 159,
      shared: 49,
      description:
      'Los colores son algo basico',
      imagesUrl:[
        'https://cdn.pixabay.com/photo/2017/10/11/17/09/read-2841723_640.jpg'

      ],
      statusTag: StatusTag.event,
      user: EnglishUser.jafet,
      locationDesc: 'Aprendamos',
    ),
  ];
}

class EnglishUser {
  EnglishUser(this.name,this.urlPhoto);

  final String name;
  final String urlPhoto;

  static EnglishUser alex = EnglishUser('Lenguague 4U', 'https://cdn.pixabay.com/photo/2018/08/28/13/29/avatar-3637561_640.png');
  static EnglishUser jafet= EnglishUser('Lenguague 4U', 'https://cdn.pixabay.com/photo/2018/08/28/13/29/avatar-3637561_640.png');

  static List<EnglishUser> users = [alex, jafet];
}

enum StatusTag {popular, event}