/* import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_fome/src/data/repositories/products/produtc_repository_impl.dart';
import 'package:my_fome/src/domain/dtos/products/product_register_dto.dart';
import 'package:my_fome/src/domain/dtos/products/product_update_dto.dart';
import 'package:my_fome/src/domain/repositories/products/produtc_repository.dart';
import 'package:my_fome/src/data/services/client/client_service.dart';

class ClientMock extends Mock implements ClientService {}

class XFileMock extends Mock implements XFile {}

void main() {
  late ClientMock clientMock;
  late ProdutcRepository productRepositoryMock;
  late XFileMock imageMock;

  setUp(() {
    clientMock = ClientMock();
    productRepositoryMock = ProdutcRepositoryImpl(clientService: clientMock);
    imageMock = XFileMock();
  });

  group("Testando as operações do ProductRepository, usando mocks", () {
    final dataBaseTest = {
      "products": [
        {
          "id": "1",
          "name": "Cachorro Quente Padrão 270g",
          "description": "...",
          "image": "image.png",
          "active": true,
          "amount": 20,
          "price": "10.0",
          "store_id": "1",
        },
        {
          "id": "2",
          "name": "Cachorro Quente Premium 370g",
          "description": "...",
          "image": "image.png",
          "active": true,
          "amount": 18,
          "price": "14.99",
          "store_id": "1",
        },
        {
          "id": "3",
          "name": "Bolo no Pode de chocolate 350g",
          "description": "...",
          "image": "image.png",
          "active": false,
          "amount": 5,
          "price": "11.5",
          "store_id": "2",
        },
      ]
    };

    group("Testando o listActive.", () {
      test("Deve verificar que a lista de produtos não seja vazia.", () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: dataBaseTest,
        );

        when(() => clientMock.get(any())).thenAnswer((_) async => response);

        final listProduct = await productRepositoryMock.listActive();

        expect(listProduct.isSuccess(), isTrue);
        expect(listProduct.getOrNull()?.isNotEmpty, isTrue);

        verify(() => clientMock.get(any())).called(1);
      });
      test(
          "Deve verificar que existe o produto chamado 'Cachorro Quente Padrão 270g'.",
          () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: dataBaseTest,
        );

        when(() => clientMock.get(any())).thenAnswer((_) async => response);

        final listProduct = await productRepositoryMock.listActive();

        final hasProduct = (response.data?['products'] as List?)?.any(
            (element) => element["name"] == "Cachorro Quente Padrão 270g");

        expect(listProduct.isSuccess(), isTrue);
        expect(hasProduct, isTrue);

        verify(() => clientMock.get(any())).called(1);
      });
      test(
          "Deve verificar que não existe a produto chamada 'X-Tudo'.",
          () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: dataBaseTest,
        );

        when(() => clientMock.get(any())).thenAnswer((_) async => response);

        final listProduct = await productRepositoryMock.listActive();

        final hasProduct = (response.data?['products']as List?)?.any(
          (element) => element["name"] == "X-Tudo",
        );

        expect(listProduct.isSuccess(), isTrue);
        expect(hasProduct, isFalse);

        verify(() => clientMock.get(any())).called(1);
      });

      test("Deve retornar erro ao tentar listar produtos.", () async {
        final response = DioException(
          requestOptions: RequestOptions(),
        );
        when(
          () => clientMock.get(any()),
        ).thenThrow(response);

        final listProduct = await productRepositoryMock.listActive();

        expect(listProduct.isError(), isTrue);
        verify(() => clientMock.get(any())).called(1);
      });
    });

    group("Testando o listInactive.", () {
      test(
          "Deve verificar que existe a produto chamada 'Cachorro Quente Padrão 270g'.",
          () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: dataBaseTest,
        );

        when(() => clientMock.get(any())).thenAnswer((_) async => response);

        final listProduct = await productRepositoryMock.listActive();

        final hasProduct = response.data?['products']?.any(
          (element) => element["name"] == "Cachorro Quente Padrão 270g",
        );

        expect(listProduct.isSuccess(), isTrue);
        expect(hasProduct, isTrue);

        verify(() => clientMock.get(any())).called(1);
      });

      test("Deve verificar que não existe a produto chamada 'X-Tudo'.",
          () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: dataBaseTest,
        );

        when(() => clientMock.get(any())).thenAnswer((_) async => response);

        final listProduct = await productRepositoryMock.listActive();

        final hasProduct = response.data?['products']?.any(
          (element) => element["name"] == "X-Tudo",
        );

        expect(listProduct.isSuccess(), isTrue);
        expect(hasProduct, isFalse);

        verify(() => clientMock.get(any())).called(1);
      });

      test("Deve retornar erro ao tentar listar produtos.", () async {
        final response = DioException(
          requestOptions: RequestOptions(),
        );
        when(
          () => clientMock.get(any()),
        ).thenThrow(response);

        final listProduct = await productRepositoryMock.listActive();

        expect(listProduct.isError(), isTrue);
        verify(() => clientMock.get(any())).called(1);
      });
    });

    group("Testando o register.", () {
      final storeRegisterDto = ProductRegisterDto(
        name: "Novo Produto",
        description: "Descrição do novo produto",
        price: "12.9",
        amount: "1",
        storeId: "1",
      );

      test("Deve registrar um produto com sucesso.", () async {
        when(() => imageMock.readAsBytes())
            .thenAnswer((_) async => Uint8List(10));
        when(() => imageMock.name).thenReturn("image.png");

        final response = Response(
          requestOptions: RequestOptions(),
          data: {"product": storeRegisterDto.toMap()},
        );

        when(() => clientMock.post(any(), any(),
                requiresAuth: any(named: "requiresAuth"),
                contentType: any(named: "contentType")))
            .thenAnswer((_) async => response);

        final result =
            await productRepositoryMock.register(storeRegisterDto, imageMock);

        expect(result.isSuccess(), isTrue);
        verify(() => clientMock.post(any(), any(),
            requiresAuth: true, contentType: 'multipart/form-data')).called(1);
      });
    });

    group("Testando o update.", () {
      final productUpdateDto = ProductUpdateDto(
          name: "Produto Atualizado",
          description: "Descrição do produto atualizado",
          price: "12.9",
          amount: "1",
          storeId: "1");
      test("Deve atualizar uma loja com sucesso.", () async {
        when(() => imageMock.readAsBytes())
            .thenAnswer((_) async => Uint8List(10));
        when(() => imageMock.name).thenReturn("image.png");

        final response = Response(
          requestOptions: RequestOptions(),
          data: {"product": productUpdateDto.toMap()},
        );

        when(() => clientMock.post(any(), any(),
                requiresAuth: any(named: "requiresAuth"),
                contentType: any(named: "contentType")))
            .thenAnswer((_) async => response);

        final result = await productRepositoryMock.update("1", productUpdateDto,
            image: imageMock);

        expect(result.isSuccess(), isTrue);
        verify(() => clientMock.post(any(), any(),
            requiresAuth: true, contentType: 'multipart/form-data')).called(1);
      });
    });
    group("Testando o toggleActive.", () {
      test("Deve alternar o status de um produto com sucesso.", () async {
        final response = Response(
          requestOptions: RequestOptions(),
          data: {
            "product": {
              "id": "1",
              "name": "Cachorro Quente Padrão 270g",
              "description": "...",
              "image": "image.png",
              "active": false,
              "amount": 20,
              "price": "10.0",
              "store_id": "1",
            }
          },
        );

        when(() =>
                clientMock.put(any(), requiresAuth: any(named: "requiresAuth")))
            .thenAnswer((_) async => response);

        final result = await productRepositoryMock.toggleActive("1");

        expect(result.isSuccess(), isTrue);
        expect(result.getOrNull()?.id, equals("1"));

        verify(() => clientMock.put(any(), requiresAuth: true)).called(1);
      });

      test("Deve retornar erro ao tentar alternar o status de um produto.",
          () async {
        final response = DioException(
          requestOptions: RequestOptions(),
        );

        when(() =>
                clientMock.put(any(), requiresAuth: any(named: "requiresAuth")))
            .thenThrow(response);

        final result = await productRepositoryMock.toggleActive("1");

        expect(result.isError(), isTrue);
        verify(() => clientMock.put(any(), requiresAuth: true)).called(1);
      });
    });
  });
}
 */