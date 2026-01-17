import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_fome/app/data/repositories/users/user_repository_impl.dart';
import 'package:my_fome/app/data/services/client/client_service.dart';
import 'package:my_fome/app/domain/dtos/users/user_login_dto.dart';
import 'package:my_fome/app/domain/dtos/users/user_register_dto.dart';
import 'package:my_fome/app/domain/repositories/users/user_repository.dart';


class ClientMock extends Mock implements ClientService {}

void main() {
  late ClientMock clientMock;
  late UserRepository userRepositoryMock;

  setUp(() {
    clientMock = ClientMock();
    userRepositoryMock = UserRepositoryImpl(clientService: clientMock);
  });

  group("Testando as operações do UserRepository, usando mocks.", () {
    final dataBaseTest = {
      "user": [
        {
          "id": "1",
          "name": "Lázaro",
          "email": "lazaroalexandre@gmail.com",
          "image": "image.png",
        },
      ],
    };
    group("Testando o login.", () {
      test(
        "Deve verificar se é possível fazer login com uma conta existente.",
        () async {
          late String? token;
          final loginTest = UserLoginDto(email: "lazaroalexandre@gmail.com");

          final userExist = dataBaseTest["user"]!.any(
            (element) => element["email"] == "lazaroalexandre@gmail.com",
          );

          if (userExist) {
            token = "sldiuaosdiou87123981273e9woew";
          } else {
            token = null;
          }

          final response = Response(
              requestOptions: RequestOptions(), data: {"token": token});

          when(
            () => clientMock.post(any(), any()),
          ).thenAnswer((_) async => response);

          final result = await userRepositoryMock.login(loginTest);

          expect(result.isSuccess(), isTrue);
          expect(token, isNotNull);

          verify(() => clientMock.post(any(), any())).called(1);
        },
      );

      test(
        "Deve falhar ao tentar fazer login com uma conta inexistente.",
        () async {
          late String? token;

          final loginTest = UserLoginDto(email: "luis@gmail.com");

          final userExist = dataBaseTest["user"]!.any(
            (element) => element["email"] == "luis@gmail.com",
          );

          if (userExist) {
            token = "sldiuaosdiou87123981273e9woew";
          } else {
            token = null;
          }

          final response = DioException(
            requestOptions: RequestOptions(),
          );

          when(
            () => clientMock.post(any(), any()),
          ).thenThrow(response);

          final result = await userRepositoryMock.login(loginTest);

          expect(result.isError(), isTrue);
          expect(token, isNull);

          verify(() => clientMock.post(any(), any())).called(1);
        },
      );
    });

    group("Testando o Register.", () {
      test(
        "Deve verificar se é possível registro de uma conta inexistente.",
        () async {
          final registerTest =
              UserRegisterDto(name: "Luis", email: "luismartins@gmail.com");

          final response = Response(
            requestOptions: RequestOptions(),
            data: {
              'user': registerTest.toMap(),
            },
          );

          when(
            () => clientMock.post(any(), any()),
          ).thenAnswer((_) async => response);

          final result = await userRepositoryMock.register(registerTest);

          final userExist = dataBaseTest['user']!.any(
            (element) => element['email'] == registerTest.email,
          );

          expect(result.isSuccess(), isTrue);
          expect(userExist, isFalse);

          verify(() => clientMock.post(any(), any())).called(1);
        },
      );

      test(
        "Deve falhar ao tentar registrar com uma conta existente.",
        () async {
          final registerTest = UserRegisterDto(
              name: "Luis",
              email: "lazaroalexandre@gmail.com",
              image: "image.png");

          final response = DioException(
            requestOptions: RequestOptions(),
          );

          when(
            () => clientMock.post(any(), any()),
          ).thenThrow(response);

          final result = await userRepositoryMock.register(registerTest);

          final userExist = dataBaseTest["user"]!.any(
            (element) => element["email"] == registerTest.email,
          );

          expect(result.isError(), isTrue);
          expect(userExist, isTrue);

          verify(() => clientMock.post(any(), any())).called(1);
        },
      );
    });

    group("Testando o detalhe do usuário.", () {
      test(
        "Deve retornar os detalhes do usuário com sucesso.",
        () async {
          final userDetail = {
            "id": "9e287ae6-86d5-48ed-aa92-f2aeffe979cb",
            "name": "Lázaro Alexandre",
            "email": "lazaroalexandre2002@gmail.com",
            "image": null,
            "active": true,
            "email_verified_at": null,
            "created_at": "2025-02-07T22:22:58.000000Z",
            "updated_at": "2025-02-07T22:22:58.000000Z",
            "deleted_at": null,
          };

          final response = Response(
            requestOptions: RequestOptions(),
            data: {"user": userDetail},
          );

          when(() => clientMock.get(any(), requiresAuth: true))
              .thenAnswer((_) async => response);

          final result = await userRepositoryMock.detail();

          expect(result.isSuccess(), isTrue);
          expect(result.getOrNull()?.email, "lazaroalexandre2002@gmail.com");

          verify(() => clientMock.get(any(), requiresAuth: true)).called(1);
        },
      );

      test(
        "Deve falhar ao tentar obter os detalhes do usuário.",
        () async {
          final response = DioException(
            requestOptions: RequestOptions(),
          );

          when(() => clientMock.get(any(), requiresAuth: true))
              .thenThrow(response);

          final result = await userRepositoryMock.detail();

          expect(result.isError(), isTrue);

          verify(() => clientMock.get(any(), requiresAuth: true)).called(1);
        },
      );
    });

    group("Testando a recuperação da loja do usuário.", () {
      test(
        "Deve retornar os detalhes da loja do usuário.",
        () async {
          final storeDetail = {
            "id": "9e2edfe8-7511-497f-92d5-eb3347986e45",
            "owner_id": "9e287ae6-86d5-48ed-aa92-f2aeffe979cb",
            "name": "Nova Loja",
            "image": "image",
            "description": "Descrição da loja",
            "active": true,
            "whatsapp": "+5511999999999",
          };

          final response = Response(
            requestOptions: RequestOptions(),
            data: {"store": storeDetail},
          );

          when(() => clientMock.get(any(), requiresAuth: true))
              .thenAnswer((_) async => response);

          final result = await userRepositoryMock.getStoreByUser();

          expect(result.isSuccess(), isTrue);
          verify(() => clientMock.get(any(), requiresAuth: true)).called(1);
        },
      );

      test(
        "Deve retornar sucesso vazio quando não houver loja.",
        () async {
          final response = Response(
            requestOptions: RequestOptions(),
            data: {"store": null},
          );

          when(() => clientMock.get(any(), requiresAuth: true))
              .thenAnswer((_) async => response);

          final result = await userRepositoryMock.getStoreByUser();

          expect(result.isSuccess(), isTrue);

          verify(() => clientMock.get(any(), requiresAuth: true)).called(1);
        },
      );

      test(
        "Deve falhar ao tentar recuperar a loja do usuário.",
        () async {
          final response = DioException(
            requestOptions: RequestOptions(),
          );

          when(() => clientMock.get(any(), requiresAuth: true))
              .thenThrow(response);

          final result = await userRepositoryMock.getStoreByUser();

          expect(result.isError(), isTrue);

          verify(() => clientMock.get(any(), requiresAuth: true)).called(1);
        },
      );
    });
  });
}
