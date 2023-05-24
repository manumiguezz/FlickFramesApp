import 'package:animate_do/animate_do.dart';
import 'package:app_cinema/config/helpers/human_formats.dart';
import 'package:app_cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/movie_icon_average.dart';

class MovieHorizontalListView extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({super.key, required this.movies, this.subTitle, this.loadNextPage, this.title});

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
      
      
    });

  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(widget.title != null || widget.subTitle != null)
          _Title(title: widget.title, subtitle: widget.subTitle,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index],));
              },
            ),
          )


        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  
  final Movie movie;
  
  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children:[ 
          SizedBox(
            width: 150,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(20),

              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null){
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2,),),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/home/0/movie/${movie.id}'),
                    child: FadeIn(child: child)
                  );
                }
              ),
            ),
          ),

          const SizedBox(height: 5,),


          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
              ),
          ),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                MovieIconAverage(movie: movie),
                const SizedBox(width: 3,),
                Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall,)
              ],
            ),
          )
        ]
      ),
    );
  }
}

//to set different icons for each vote average
// class MovieIconAverage extends StatelessWidget {

//   final Movie movie;

//   const MovieIconAverage({required this.movie});

//   @override
//   Widget build(BuildContext context) {

//     if (movie.voteAverage < 6.5){
//       return Icon(Icons.star_border_outlined, color: Colors.yellow.shade800,);
//     } else if (movie.voteAverage < 8){
//       return Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,);
//     } else if (movie.voteAverage < 10){
//       return Icon(Icons.star, color: Colors.yellow.shade800,); 
//     } else {
//       return Icon(Icons.abc, color: Colors.yellow.shade800,);
//     }
//   }
// }


class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;
  const _Title({
    this.title, this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if (title != null)
            Text(title!, style: titleStyle,),

          const Spacer(),

          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {}, 
              child: Text(subtitle!,)
            )
        ],
      ),
    );
  }
}