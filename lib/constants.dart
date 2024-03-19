import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Widgets/recomCard.dart';

List<RecomCard> newsList = [
  RecomCard(Article(
      newsAuthor: 'BBC News',
      newsDate: 'DateTime(DateTime(DateTime.daysPerWeek).day)',
      newsImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjXgWZk1TCbW6pKaPu_x0lgTL4mPHxF-RSQ&usqp=CAU',
      newsTitle: 'Scammers profit from Turkey-Syria earthquake',
      content: 'content'))
];

RecomCard getArticleList() {
  return RecomCard(Article(
      newsAuthor: 'BBC News',
      newsDate: 'DateTime(DateTime(DateTime.daysPerWeek).day)',
      newsImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjXgWZk1TCbW6pKaPu_x0lgTL4mPHxF-RSQ&usqp=CAU',
      newsTitle: 'Scammers profit from Turkey-Syria earthquake',
      content: 'content'));
}
// RecomCard(
//               imagepath:
//                   'https://ichef.bbci.co.uk/news/976/cpsprodpb/DFAD/production/_128616275_originalwithwatermark.jpg.webp',
//               author: ,
//               category: '',
//               date: ,',
//               authorPic:
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIjXgWZk1TCbW6pKaPu_x0lgTL4mPHxF-RSQ&usqp=CAU',
//             ),
//             RecomCard(
//               imagepath:
//                   'https://www.channelstv.com/wp-content/uploads/2023/10/ABAT.jpg',
//               author: 'Channels',
//               category: 'Nigeria',
//               date: DateTime(DateTime(DateTime.daysPerWeek).day),
//               newsTitle:
//                   'Tinubu Seven Months Old In Office, Needs More Time – FG',
//               authorPic:
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5MufvetN3MjDpfScmp-BwI3Idb4IgOy0CYQ&usqp=CAU',
//             ),
//             RecomCard(
//               imagepath:
//                   'https://e0.365dm.com/24/01/1600x900/skysports-liverpool-chelsea_6439873.jpg?20240131221347',
//               author: 'Sky Sports',
//               date: DateTime(DateTime(DateTime.daysPerWeek).day),
//               category: 'Sports',
//               newsTitle: 'Liverpool thrash sorry Chelsea at Anfield',
//               authorPic:
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNKi1PGe69CXH5kdj-OW5R2u1xJuqdr6l-nQ&usqp=CAU',
//             ),
//             RecomCard(
//               date: DateTime(DateTime(DateTime.daysPerWeek).day),
//               imagepath:
//                   'https://cdn.vanguardngr.com/wp-content/uploads/2024/01/roque.jpg',
//               author: 'Vanguard',
//               category: 'Sports',
//               newsTitle:
//                   'Brazil wonderkid Roque fires Barcelona to narrow win over Osasuna',
//               authorPic:
//                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1Wjqxt4m0loFsNkr1EA9oG9rC5X--_nJw4A&usqp=CAU',
//             ),
