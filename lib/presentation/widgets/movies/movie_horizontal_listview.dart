import '../shared/movie_icon_average.dart';
import 'package:animate_do/animate_do.dart';
import 'package:app_cinema/config/helpers/human_formats.dart';
import 'package:app_cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              child: GestureDetector(
                onTap: () => context.push('/home/0/movie/${ movie.id }'),
                child: FadeInImage(
                  height: 220,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/loading-circle.gif'), 
                  image: NetworkImage(movie.posterPath)
                ),
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
                Text(HumanFormats.number(movie.voteAverage, 1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
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
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if (title != null)
            Text(title!, style: titleStyle,),

          const SizedBox(height: 5,),

        ],
      ),
    );
  }
}