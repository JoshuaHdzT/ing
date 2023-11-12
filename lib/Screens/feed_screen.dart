import 'dart:ui';

import 'package:ing/Screens/place.dart';
import 'package:ing/Screens/text_theme_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class FeedScreen extends StatefulWidget {

  const FeedScreen({Key? key,
  }) : super(key: key);


  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lección 1'),
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(CupertinoIcons.search),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.star)
          ),
        ],
      ),
      body: ListView.builder(
         itemCount: EnglishPlace.places.length,
        itemExtent: 350,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index){
           final place = EnglishPlace.places[index];
           return PlaceCard(
               place: place,
                onPreseed: ()async{
                 Navigator.push(
                     context, PageRouteBuilder(
                     pageBuilder: (_,animation, __)=>FadeTransition(
                         opacity: animation,
                       child: PlaceDetailsScreen(place: place, screenHeight: MediaQuery.of(context).size.height,),
                     )));
                },


           );
        },
      ),
      extendBody: true,
      bottomNavigationBar: TravelNavigationBar(),
    );
  }
}

class PlaceDetailsScreen extends StatefulWidget {
  const PlaceDetailsScreen({Key? key,
    required this.place,
    required this.screenHeight,
  }) : super(key: key);

  final EnglishPlace place;
  final double screenHeight;

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late ScrollController _controller;
  @override
  void initState(){
    _controller = ScrollController(initialScrollOffset: widget.screenHeight * .3);
    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomScrollView(
       physics: const BouncingScrollPhysics(),
       controller: _controller,
       slivers: [
         SliverPersistentHeader(
           pinned: true,
           delegate: BuilderPersistentDelegate(
             maxExtent: MediaQuery.of(context).size.height,
             minExtent: 240,
             builder: (percent){
               return AnimatedDetailHeader(
                 topPercent: ((1 - percent) / .7).clamp(0.0, 1.0),
                   bottomPercent: (percent /.3).clamp(0.0, 1.0),
                   place: widget.place
               );
             }
           ),
         ),

         SliverToBoxAdapter(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             child: Column(
               children: [
                 Row(
                   children: [
                     const Icon(Icons.location_on, color: Colors.black26),
                     Flexible(
                       child: Text(
                         widget.place.locationDesc,
                         style: context.bodyMedium.copyWith(color: Colors.blue),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 10),
                 Text(widget.place.description),
               ],
             ),
           ),
         ),


          SliverToBoxAdapter(
            child:Padding(
              padding: EdgeInsets.only(left: 20,top: 50, right: 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: (
                      ){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> FeedScreen()));
                  },
                  child: Text('Ver video'),
                ),
              ),
            ),
             ),
        // const SliverToBoxAdapter(child: Placeholder()),
       ],
     ),
    );
  }
}

class AnimatedDetailHeader extends StatelessWidget {
  const AnimatedDetailHeader({Key? key,
    required this.place,
    required this.topPercent,
    required this.bottomPercent,
  }) : super(key: key);

  final EnglishPlace place;
  final double topPercent;
  final double bottomPercent;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final imagesUrl = place.imagesUrl;

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRect(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: (20+topPadding)*(1-bottomPercent),
                  bottom: 160 * (1-bottomPercent),
                ),
                //child: Positioned.fill(
                  child: Transform.scale(
                    scale: lerpDouble(1,1.3,bottomPercent)!,
                    child: PlaceImagesPageView(place: place, imagesUrl: imagesUrl),
                  ),
                ),
              Positioned(
                top: topPadding,
                  left: -60*(1-bottomPercent),
                  child: BackButton(
                    color: Colors.white,
                  ),
              ),
              Positioned(
                  top: topPadding,
                  right: -60*(1-bottomPercent),
                  child: IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
              ),
              Positioned(
                top: lerpDouble(20, 140, topPercent)!.clamp(topPadding + 10, 140),
                left: lerpDouble(60, 20, topPercent)!.clamp(20.0, 50.0),
                child: Text(
                place.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: lerpDouble(20, 40, topPercent),
                    fontWeight: FontWeight.bold
                    ),
                  ),
              ),

            ],
          ),
          ),

        Positioned.fill(
          top: null,
          child: TranslateAnimation(
            child: _LikesAndSheresContainer(place: place),
          ),

        ),
        Positioned.fill(
          top: null,
          child: TranslateAnimation(
            child: _UserInfoContairner(place: place),
          ),
        ),
      ],
    );


  }
}

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 1, end: 0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        builder: (context, value, child){
          return Transform.translate(
              offset: Offset(0,100*value),
            child: child,
          );
        },
      child: child,
    );
  }
}

class _UserInfoContairner extends StatelessWidget {
  const _UserInfoContairner({Key? key,
    required this.place,
  }) : super(key: key);

  final EnglishPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)
          ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(place.user.urlPhoto),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                place.user.name,
                style: context.bodyLarge
              ),

              Text(
                'Tema colores',
                style: context.bodyLarge.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              foregroundColor: Colors.blue.shade600,
              textStyle: context.titleSmall,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),

            child: const Text('+Follow'),
          ),
        ],
      ),

    );
  }
}

class _LikesAndSheresContainer extends StatelessWidget {
  const _LikesAndSheresContainer({
    super.key,
    required this.place,
  });

  final EnglishPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: context.titleSmall,
              shape: const StadiumBorder(),
            ),
            icon: const Icon(CupertinoIcons.heart,size: 26,),
            label: Text(place.likes.toString()),
          ),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: context.titleSmall,
              shape: const StadiumBorder(),
            ),
            icon: const Icon(CupertinoIcons.reply,size: 26,),
            label: Text(place.shared.toString()),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              foregroundColor: Colors.blue.shade600,
              textStyle: context.titleSmall,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            icon: const Icon(Icons.check_circle_outline,size: 26,),
            label: Text('Checking'),
          ),
        ],
      ),
    );
  }
}

class PlaceImagesPageView extends StatelessWidget {
  const PlaceImagesPageView({Key? key,
    required this.place,
    required this.imagesUrl,
  }) : super(key: key);


  final EnglishPlace place;
  final List<String> imagesUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              itemCount: place.imagesUrl.length,
              physics: const BouncingScrollPhysics(),
              controller: PageController(viewportFraction: .9),
              itemBuilder: (context, index){
                final imageUrl = place.imagesUrl[index];
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      )],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Colors.black26,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imagesUrl.length,
                (index) => Container(
              color: Colors.black12,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 3,
              width: 10,

            ),

          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class BuilderPersistentDelegate extends SliverPersistentHeaderDelegate{
  BuilderPersistentDelegate({
    required double maxExtent,
    required double minExtent,
    required this.builder,

}): _maxExtent=maxExtent, _minExtent=minExtent;

  final double _maxExtent;
  final double _minExtent;
  final Widget Function (double percent) builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);

  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
   return false;
  }
}

class TravelNavigationBar extends StatelessWidget {
  const TravelNavigationBar({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NavPainter(),
      child: Container(
        height: kToolbarHeight,
        //color: Colors.pink,
      ),

    );
  }
}

class _NavPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    final w =size.width;
    final h = size.height;
    final h5 = h * .5;
    final w5 = w * .5;
    final h6 = h* .6;

    final path = Path()..lineTo(w5-80, 0)
      ..cubicTo(w5-40, 0, w5-50, h5, w5, h6)
      ..lineTo(w5, h)
      ..lineTo(w, h)
      ..lineTo(w, 0)
      ..lineTo(w5+80, 0)
      ..cubicTo(w5+40, 0, w5+50, h5, w5, h6)
      ..lineTo(w5, h6)
      ..lineTo(w5, h)
      ..lineTo(0, h);
    canvas.drawShadow(path, Colors.black26, 10, false);
    canvas.drawPath(path, Paint()..color=Colors.white);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;


}


class PlaceCard extends StatelessWidget {
  const PlaceCard({Key? key,

    required this.place,
    required this.onPreseed,
  }) : super(key: key);

  final EnglishPlace place;
  final VoidCallback onPreseed;

  @override
  Widget build(BuildContext context) {
    final statusTag = place.statusTag;
    return InkWell(
      onTap: onPreseed,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(place.imagesUrl.first),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black26,
                BlendMode.darken,
              ),
            ),
          ),
//----------------------------
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(place.user.urlPhoto),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.user.name,
                        style: context.bodyLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        'Tema colores',
                        style: context.bodyLarge.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                place.name,
                style: context.displayMedium,
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.red,
                child: Text(place.statusTag.toString()),
              ),

              const Spacer(),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    icon: const Icon(CupertinoIcons.heart),
                    label: Text(place.likes.toString()),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    icon: const Icon(CupertinoIcons.reply),
                    label: Text(place.shared.toString()),
                  ),
                ],
              ),

            ],
          ),
//--------------------------------------

        )
    );

  }

}

