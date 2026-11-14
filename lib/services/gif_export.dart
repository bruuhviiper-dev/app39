import 'dart:io';
import 'dart:ui' as ui;

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

/// Monta um GIF animado a partir de quadros capturados (ui.Image RGBA) usando a
/// lib `image` (Dart puro — sem ffmpeg/dependência nativa pesada). Grava num
/// arquivo temporário e devolve o caminho.
class GifExport {
  GifExport._();

  /// Converte um [ui.Image] (RGBA) em [img.Image].
  static Future<img.Image> fromUiImage(ui.Image image) async {
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    return img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: data!.buffer,
      numChannels: 4,
      order: img.ChannelOrder.rgba,
    );
  }

  /// Codifica os [frames] como GIF em loop e grava num arquivo temporário.
  /// [frameMs] = duração de cada quadro em milissegundos.
  static Future<String> buildGifFile(
    List<img.Image> frames, {
    int frameMs = 90,
  }) async {
    final encoder = img.GifEncoder()..repeat = 0; // loop infinito
    final centi = (frameMs / 10).round(); // GIF usa centésimos de segundo
    for (final f in frames) {
      encoder.addFrame(f, duration: centi);
    }
    final bytes = encoder.finish();
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/cartao_${DateTime.now().millisecondsSinceEpoch}.gif';
    final file = File(path);
    await file.writeAsBytes(bytes!);
    return path;
  }
}
