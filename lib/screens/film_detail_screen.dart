import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../theme/app_theme.dart';
import '../models/film.dart';

class FilmDetailScreen extends StatefulWidget {
  final Film film;
  const FilmDetailScreen({super.key, required this.film});
  @override
  State<FilmDetailScreen> createState() => _FilmDetailScreenState();
}

class _FilmDetailScreenState extends State<FilmDetailScreen> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _inWatchlist = false;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    if (widget.film.videoUrl.isEmpty) return;
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.film.videoUrl));
    await _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_controller == null) return;
    setState(() {
      _isPlaying ? _controller!.pause() : _controller!.play();
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Column(
        children: [
          _buildVideoHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(widget.film.title,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary)),
                      ),
                      Row(children: [
                        const Icon(Icons.star_rounded,
                            color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text('${widget.film.rating}',
                            style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(children: [
                    _metaTag('${widget.film.year}'),
                    const SizedBox(width: 8),
                    _metaTag(widget.film.genre),
                  ]),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _inWatchlist
                              ? AppTheme.greenPrime
                              : AppTheme.textPrimary,
                          side: BorderSide(
                              color: _inWatchlist
                                  ? AppTheme.greenPrime
                                  : AppTheme.borderColor),
                          minimumSize: const Size(0, 44),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () =>
                            setState(() => _inWatchlist = !_inWatchlist),
                        icon: Icon(
                            _inWatchlist
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 18),
                        label: Text(_inWatchlist ? 'Saved' : '+ Watchlist'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: _downloading
                            ? null
                            : () async {
                                setState(() => _downloading = true);
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                setState(() => _downloading = false);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Download complete!')));
                              },
                        icon: _downloading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.download_outlined, size: 18),
                        label:
                            Text(_downloading ? 'Downloading...' : 'Download'),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  const Text('About',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary)),
                  const SizedBox(height: 8),
                  Text(widget.film.description,
                      style: const TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 14,
                          height: 1.6)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoHeader() {
    final hasVideo = _controller != null && _controller!.value.isInitialized;
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: hasVideo
              ? VideoPlayer(_controller!)
              : Container(
                  color: AppTheme.bgCard,
                  child: const Center(
                      child: Icon(Icons.movie_outlined,
                          color: AppTheme.textMuted, size: 60))),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: _togglePlay,
            behavior: HitTestBehavior.translucent,
            child: Center(
              child: AnimatedOpacity(
                opacity: _isPlaying ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.play_arrow_rounded,
                      color: Colors.white, size: 36),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _metaTag(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderColor)),
        child: Text(label,
            style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
      );
}
