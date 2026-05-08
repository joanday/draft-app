class Film {
  final String id;
  final String title;
  final int year;
  final String genre;
  final double rating;
  final String thumbnailUrl;
  final String description;
  final String videoUrl;

  const Film({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.thumbnailUrl,
    required this.description,
    required this.videoUrl,
  });
}

final List<Film> sampleFilms = [
  Film(
      id: '1',
      title: 'Ang Huling El Bimbo',
      year: 2022,
      genre: 'Drama',
      rating: 4.7,
      thumbnailUrl: 'https://picsum.photos/seed/film1/300/450',
      description: 'A nostalgic journey through friendship and choices.',
      videoUrl: ''),
  Film(
      id: '2',
      title: 'Sa Aking Puso',
      year: 2023,
      genre: 'Romance',
      rating: 4.2,
      thumbnailUrl: 'https://picsum.photos/seed/film2/300/450',
      description: 'A heartfelt story of love across generations.',
      videoUrl: ''),
  Film(
      id: '3',
      title: 'Bagong Liwanag',
      year: 2024,
      genre: 'Thriller',
      rating: 4.5,
      thumbnailUrl: 'https://picsum.photos/seed/film3/300/450',
      description: 'When the lights go out, the truth emerges.',
      videoUrl: ''),
  Film(
      id: '4',
      title: 'Lupang Tinubuan',
      year: 2023,
      genre: 'Documentary',
      rating: 4.9,
      thumbnailUrl: 'https://picsum.photos/seed/film4/300/450',
      description: 'Exploring the roots of Philippine culture.',
      videoUrl: ''),
];

const List<String> filmThemes = [
  'All',
  'Drama',
  'Romance',
  'Thriller',
  'Documentary',
  'Comedy',
  'Short Film',
];
