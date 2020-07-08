import 'package:diagonal/diagonal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news/bloc/news_bloc.dart';
import 'package:flutter_news/bloc/news_event.dart';
import 'package:flutter_news/news_web.dart';
import 'bloc/news_state.dart';
import 'model/news.dart';

class NewsFeed extends StatelessWidget {
  final _newsBloc = NewsBloc(LoadingNewsState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.8)),
        child: BlocBuilder(
          bloc: _newsBloc,
          builder: (BuildContext context, NewsState state) {
            if (state is LoadingNewsState) {
              _newsBloc.add(LoadNewsEvent());
              return Center(child: CircularProgressIndicator());
            }

            if (state is LoadedNewsState) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.cats.length,
                itemBuilder: (BuildContext context, int index) {
                  return _newsCategory(state.cats[index], context);
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _newsCard(News news, BuildContext context) {
    return Container(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Stack(
            children: [
              SizedBox(
                width: 250,
                height: 220,
                child: Diagonal(
                  position: Position.BOTTOM_RIGHT,
                  clipHeight: 100.0,
                  child: Image.network(
                    news.img != null
                        ? news.img
                        : 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJoAAACaCAMAAABmIaElAAAAIVBMVEX////d3d35+fng4ODt7e3y8vL8/Pz19fXl5eXa2trp6eleAlUVAAABkklEQVR4nO3Y2a6CMBRAUTvR4f8/+AIp4tUyWMNpjXu9aULcKdDW3m4AAAAAAAAAAAAAAECUtrX0xWVDUJWiubjNxdo0pezFafVll6d1PGpTWnDvClJp7/+GJe0r0rTXw6nLpNN8mF+JM5cJp+UpLqbu0rTJ01X0vaXZ++Qbektb1/kT6zZp+TfSmnZ8mfBrsJTFwvQxeOcex1J48rC5rPAWzDOeSmuc9JRrjRo/2df1YNnUmfu0Ir5QjbfNF16Bh+3mcq87Wd79w+5xGbc+0p626L6ftPv6tYyb6yVNqxeujzRd+Js6jVv7tMG8ls3j1jxtSMWy8T1tnbZz6GAap9mDv88tR812m3Z0IiKfptO6xdgdN/E0Oz3iweX9x97zJpymQ24x+cuw3SaaNj74Mc8MKpr5SPR5DW2U9rQsjXHD3i2VSyvM/VPcxmIlmebLc3+wrdO2lss9Mmlu+2Fvm5ZS1WHzj5+Ak/ZuWn3ZD4+aPy7YdOpA+gPW1ErnzvE/oGtdXgYAAAAAAAAAAAAAAP75A57zEErxShYlAAAAAElFTkSuQmCC',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 190.0, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: news.title,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        height: 3,
                        width: 100,
                        child: Container(
                          color: Colors.red,
                        )),
                    SizedBox(
                      height: 50,
                      child: Container(
                        width: 200,
                        child: Text(
                          news.text.length > 150 - news.title.length
                              ? news.text.substring(0, 150 - news.title.length)
                              : news.text,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsInAWeb(news.url)));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newsCategory(NewsCategory cats, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 530,
      child: Column(
        children: <Widget>[
          Text(
            'Discover ${cats.category.toUpperCase()}',
            style: TextStyle(fontSize: 33, fontWeight: FontWeight.w800),
          ),
          Container(
            width: double.infinity,
            height: 450,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cats.news.length,
              itemBuilder: (BuildContext context, int index) {
                return _newsCard(cats.news[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
