import 'package:share_plus/share_plus.dart';

import '../models/sticker.module.dart';

class Compartilhar {
  compartilharFigurinhasTexto(List<StickerModel> stickers, String opcao) async {
    String mensagem = '';
    switch (opcao) {
      case 'Faltantes':
        mensagem = 'Figurinhas Faltantes: \n\n';
        for(var sticker in stickers) {
          if(sticker.quantidade == 0) {
            mensagem += '🃏  *${sticker.posicao}*\n';
          }
        }
        break;
      case 'Repetidas':
        mensagem = 'Figurinhas Repetidas: \n\n';
        mensagem = '${mensagem}Indice --- Qtd\n';
        for(var sticker in stickers) {
          if(sticker.quantidade > 1) {
            mensagem += '🃏  *${sticker.posicao}*     [ ${sticker.quantidade}x ]\n';
          }
        }
        break;

      default:
        mensagem = 'Todas as Figurinhas: \n\n';
        mensagem = '${mensagem}Indice --- Qtd\n';
        for(var sticker in stickers) {
          
            mensagem += '🃏  *${sticker.posicao}*     ${sticker.quantidade == 0 ? "" : [" ${sticker.quantidade}x "]}\n';
          
        }
    }
    mensagem = '$mensagem \n\nCompartilhado através do app My_Sticker_Album 🎁 de _*Luan Sampaio*_.';
    await Share.share(mensagem);
  }
}
