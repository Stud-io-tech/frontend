import 'package:intl/intl.dart';
import 'package:my_fome/src/constants/deep_link_constant.dart';

final class TextConstant {
  static String welcome = 'Bem-vindo ao Capricha AÍ.';
  static String home = 'Home';
  static String products = 'Produtos';
  static String stores = 'Lojas';
  static String myStore = 'Minha Loja';
  static String logout = 'Sair';
  static String seeMore = 'ver mais';
  static String sucessLoggingAccountTitle = 'Bem-vindo ao Capricha AÍ!';
  static String sucessLoggingOutAccountTitle = 'Conta Desvinculada!';
  static String sucessCreatingAccountTitle = 'Conta Criada!';
  static String sucessCreatingStoreTitle = 'Loja Criada!';
  static String sucessCreatingProductTitle = 'Produto Criado!';
  static String sucessUpdatingStoreTitle = 'Loja Atualizada!';
  static String sucessUpdatingProductTitle = 'Produto Atualizado!';

  static String sucessSuspendingProductTitle = 'Produto Suspenso!';
  static String sucessRestoreProductTitle = 'Produto Restaurado!';

  static String logoutAccountTitle = 'Sair da Conta?';
  static String suspendProductTitle = 'Suspender o Produto?';
  static String reactivedProductTitle = 'Reativar o Produto?';

  static String sucessLoggingAccountMessage = 'Que tal fazer um pedido?';
  static String sucessLoggingOutAccountMessage =
      'Você saiu da conta. Volte sempre!';
  static String sucessCreatingAccountMessage =
      'Sua conta foi criada com sucesso.';
  static String sucessCreatingStoreMessage = 'A loja foi criada com sucesso.';
  static String sucessCreatingProductMessage = 'A loja foi criado com sucesso.';

  static String sucessUpdatingStoreMessage =
      'A loja foi atualizada com sucesso.';
  static String sucessUpdatingProductMessage =
      'O produto foi atualizado com sucesso.';
  static String sucessSuspendingProductMessage =
      'O produto foi suspenso com sucesso.';
  static String sucessRestoreProductMessage =
      'O produto foi restaurado com sucesso.';

  static String errorTitle = 'Erro!';
  static String errorLoggingAccountMessage = 'Houve um erro ao fazer login.';
  static String errorCreatingAccountMessage =
      'Houve um erro ao criar sua conta.';
  static String errorListStoresMessage = 'Houve um erro ao listar as lojas.';
  static String errorListProductsMessage =
      'Houve um erro ao listar os produtos.';
  static String errorCreatingStoreMessage = 'Houve um erro ao criar a loja.';
  static String errorCreatingProductMessage =
      'Houve um erro ao criar o produto.';
  static String errorUpdatingStoreMessage =
      'Houve um erro ao atualizar a loja.';
  static String errorUpdatingProductMessage =
      'Houve um erro ao atualizar o produto.';

  static String errorDetailsUserMessage =
      'Houve um erro ao encontrar o usuário.';

  static String errorDetailsStoreMessage = 'Houve um erro ao encontrar a loja.';
  static String errorDetailsProductMessage =
      'Houve um erro ao encontrar o produto.';
  static String errorExecutingProductMessage =
      'Houve um erro de execeução! Tente novamente.';

  static String yes = 'Sim';
  static String no = 'Não';
  static String send = 'Enviar';
  static String confirm = 'Confirmar';
  static String cancel = 'Cancelar';
  static String storeProducts = 'Produtos da Loja';
  static String newProduct = 'Novo Produto';
  static String newStore = 'Nova Loja';
  static String updateProduct = 'Editar Produto';
  static String updateStore = 'Editar Loja';

  static String editProduct = 'Editar Produto';

  static String helloUser(String? userName) =>
      userName != null ? 'Olá, $userName!' : 'Olá!';
  static String quantityAvailable(int quantity) => '$quantity restantes';
  static String monetaryValue(double value) =>
      'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  static String logoutAccountMessage(String userEmail) =>
      'Ao confirmar, a conta com o email "$userEmail" será desvinculada do sistema até que seja realizado um novo login.';
  static String suspendProductMessage(String productName) =>
      'Ao confirmar a suspensão, o produto "$productName" será arquivado para os usuários até que seja reativado novamente.';
  static String reactivedProductMessage(String productName) =>
      'Ao confirmar a reativação, o produto "$productName" será ativo para o público.';

  static String found(int value) => "$value Encontrados";
  static String cityState(String city, String state) => "$city - $state";
  static String storeWhatsapp(String store) =>
      'Olá, $store! Eu gostaria de tirar algumas dúvidas. Você poderia me ajudar?';
  static String suspended = "Suspensos";
  static String actives = "Ativos";
  static const String search = 'Pesquisar...';
  static String save = 'Salvar';
  static String serverError = 'O Capricha AÍ está fora do ar!';
  static String fieldError = "Campo obrigarório!";
  static String minCaractersPhone = 'O mínimo de caracters é 11!';
  static String maxCaractersPhone = 'O máximo de caracters é 11!';
  static String productNotFound = 'Produto não encontrado!';
  static String storeNotFound = 'Loja não encontrada!';
  static String name = 'Nome';
  static String description = 'Descrição';
  static String schedules = 'Dias e Horários';
  static String amount = 'Quantidade';
  static String pixKey = 'Chave pix';
  static String price = 'Preço';
  static String whatsapp = 'Whatsapp';
  static String costPerShipping = 'Custo por Frete';
  static String image = 'Imagem';
  static String uploadImage = 'Upload da Imagem';
  static String placeOrder = 'Fazer Pedido';
  static String addQuantity = 'Adicionar quantidade';

  static String requiredLogin = 'Você precisa fazer login!';
  static String loggin = 'Fazer Login';

  static String total = 'Total:';

  static String share = 'Compartilhar';
  static String shareStore = 'Compartilhar QRCode da Loja?';
  static String shareProduct = 'Compartilhar QRCode do Produto?';
  static String storeName = 'Nome da loja';

  static String dynamicFreightKmLabel = 'Quanto custa a entrega a cada 1 km rodado?';
  static String dynamicFreightKmHint = 'Exemplo: R\$ 1,00';
  static String dynamicFreightKmDetail = 'Não informe o valor total da entrega.\nInforme apenas o valor cobrado para cada 1 km percorrido.\n\nExemplo:\nSe o entregador percorre 5 km e o valor da entrega é R\$ 5,00, então o custo por km rodado é de R\$ 1,00. Nesse caso, digite "1,00" no campo.';

  static String delieveryTimeKmLabel =
      'Quantos minutos o entregador demora para rodar 1 km?';
  static String delieveryTimeKmHint = 'Ex: 2 minutos por km percorrido';
  static String delieveryTimeKmDetail =
      'Não informe o tempo total da entrega.\nInforme apenas o tempo gasto em minutos por entrega a cada 1 km percorrido.\n\nExemplo:\nSe o entregador leva 10 minutos para rodar 5 km, então, ele leva 2 minutos para percorrer 1 km. Nesse caso, digite "2" no campo.';

  static String storeDescription = 'Descrição da loja';
  static String schedulesDescription =
      'Diga quais são dos dias e horários de funcionamento';

  static String storePixKey = 'Chave pix da loja';
  static String storeWhatsappNumber = 'Whatsapp da loja';

  static String shareMidia = 'Compartilhar Mídia';
  static String shareQRCode = 'Compartilhar QRCode';
  static String address = 'Endereço';
  static String editAddress = 'editar endereço';

  static String productName = 'Nome do produto';
  static String productDescription = 'Descrição do produto';
  static String productPrice = 'Preço do produto';
  static String productAmount = 'Quantidade do produto';

  static String shareTextProduct(
          String id, String name, int amount, String price) =>
      "$name | $amount restantes | R\$$price: ${DeepLinkConstant.productDetail}/$id";

  static String shareTextStore(String id, String name) =>
      "Loja $name: ${DeepLinkConstant.storeDetail}/$id";

  static String successLinkCopiedTitle = "Link Copiado!";
  static String successLinkCopiedMessage = "Link copiado com sucesso!";

  static String pixPayment =
      "Escaneie o QRCode de pagamento pix ao lado! Você também pode usar o Pix Copia e Cola ao copiar o código no painel de pedidos no aplicativo.";

  static String orderConfirmation = "Confirmação de pedido";

  static String thanks = "Obrigado por comprar no Capricha Aí!";
  static String payment = "Pagamento:";

  static String paymentOnDelivery = "Pagamento na Entrega.";
  static String bringChange(double bring) =>
      "Traga ${monetaryValue(bring)} de troco!";
  static String formatDateTime(DateTime dateTime) =>
      "${DateFormat('dd/MM/yyyy | HH:mm').format(dateTime)}h";
}
