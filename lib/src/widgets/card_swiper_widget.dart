import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class CardSwiper extends StatelessWidget {
  
   List<Pelicula> peliculas;
  
  CardSwiper({required this.peliculas} );

  
  @override
  Widget build(BuildContext context) {
    
    //final _screenSize = MediaQuery.of(context).size;

    return CarouselSlider.builder(
      itemCount: this.peliculas.length,
      itemBuilder: (context, index, realIndex) => MoviePosterImage(pelicula: this.peliculas[index]), 
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      )
    );

    /* return Container(
       padding: EdgeInsets.only(top: 10.0),
       child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index){

            peliculas[index].uniqueId = '${ peliculas[index].id }-tarjeta';

            return Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: MoviePosterImage(peliculas: peliculas),
                )
              ),
            );
            
          },
          itemCount: peliculas.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
      ),
    ); */

  }
}

class MoviePosterImage extends StatelessWidget {
  const MoviePosterImage({
    Key? key,
    required this.pelicula,
  }) : super(key: key);

  final Pelicula pelicula;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: ()=> Navigator.pushNamed(context, 'detalle', arguments: pelicula),
      child: Hero(
        tag: pelicula.uniqueIdBanner,
        child: FadeInImage(
          image: NetworkImage( pelicula.getBackgroundImg()  ),
          placeholder: AssetImage('assets/img/no-image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
