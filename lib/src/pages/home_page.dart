import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola'
                );
            },
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 20,),
              _swiperTarjetas(),
              SizedBox(height: 20,),
              _footer(context)
            ],
          ),
        ),
      )
       
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if ( snapshot.hasData ) {
          //return CardSwiper( peliculas: [],  );
          return CardSwiper( peliculas: snapshot.data!,  );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
        
      },
    );

  }

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
     // height: 200,
     margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text('Populares', style: Theme.of(context).textTheme.bodyText1  )
          ),
          SizedBox(height: 10.0),

          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              
              if ( snapshot.hasData ) {
                return MovieHorizontal(
                   
                  //peliculas: [],
                  peliculas: snapshot.data!,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

        ],
      ),
    );


  }

}