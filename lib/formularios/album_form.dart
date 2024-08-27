import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/album.module.dart';
import '../repositories/album_repository.dart';
import '../utils/opcoes_cores.dart';

import 'campos_form.dart';

class AlbumForm extends StatefulWidget {
  final AlbumModel? album;
  final AlbumRepository albumR;
  const AlbumForm({super.key, required this.album, required this.albumR});

  @override
  State<AlbumForm> createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final campo = CamposForm();

  late AlbumModel _album;
  final _formAlbumKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _qtdPosicoesController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _corController = TextEditingController();

  final formataData = DateFormat('dd/MM/yyyy');

  bool autoValidar = false;

  @override
  void initState() {
    _corController.text = '0';
    if (widget.album != null) {
      _album = widget.album!;
      _tituloController.text = _album.nome;
      _qtdPosicoesController.text = _album.posicoes.toString();
      _descricaoController.text = _album.descricao;
      _corController.text = _album.temaCor.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        //enableDrag: false,
        //backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Form(
            key: _formAlbumKey,
            autovalidateMode: autoValidar ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: campo.linha(
                              context,
                              label: 'Título',
                              qtdLinha: 1,
                              valida: true,
                              controle: _tituloController,
                              cor: 1,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: campo.apenasNumeros(
                              context,
                              label: 'Posições',
                              qtdLinha: 1,
                              valida: true,
                              controle: _qtdPosicoesController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: campo.linha(
                        context,
                        label: 'Descrição',
                        qtdLinha: 2,
                        valida: false,
                        controle: _descricaoController,
                        cor: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  8.0),
                      child: OpcoesCores(
                        qtdElementLinha: 10,
                        controle: _corController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              _corController.clear();
                              _qtdPosicoesController.clear();
                              _descricaoController.clear();
                              _tituloController.clear();

                              widget.albumR.setForm(false);
                            },
                            title: const Text(
                              'Cancelar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            tileColor: Colors.red.shade300
                            // Colors.red.withAlpha(170),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              if (_formAlbumKey.currentState!.validate()) {
                                if (widget.album == null) {
                                  AlbumModel a1 = AlbumModel(
                                    nome: _tituloController.text,
                                    posicoes:
                                        int.parse(_qtdPosicoesController.text),
                                    descricao: _descricaoController.text.isEmpty
                                        ? ''
                                        : _descricaoController.text,
                                    temaCor: int.parse(_corController.text),
                                    id: 0,
                                    capa: '',
                                    criacao: DateFormat.yMd('pt_BR')
                                        .format(DateTime.now())
                                        .toString(),
                                    quantidadeFigurinhas: 0,
                                  );
                                  debugPrint('${a1.toMap()}');
                                  //widget.albumR.criar(a1);
                                } else {
                                  _album.nome = _tituloController.text;
                                  _album.descricao =
                                      _descricaoController.text.isEmpty
                                          ? ''
                                          : _descricaoController.text;
                                  _album.temaCor =
                                      int.parse(_corController.text);
                                  _album.posicoes =
                                      int.parse(_qtdPosicoesController.text);
                                  widget.albumR.atualizar(_album);
                                }
                                _corController.clear();
                                _qtdPosicoesController.clear();
                                _descricaoController.clear();
                                _tituloController.clear();
                                debugPrint('${_album.toMap()}');
                                //widget.albumR.setForm(false);
                              }
                              setState(() {
                                autoValidar = true;
                              });
                            },
                            title: Text(
                              widget.album == null ? 'Adicionar' : 'Salvar',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            tileColor:  Colors.green.shade300
                            // Colors.green.withAlpha(170),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
