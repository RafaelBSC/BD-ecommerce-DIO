-- drop database ecommerce2;
create database ecommerce2;
use ecommerce2;

-- clientes (base)
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    Address varchar(255)
);
alter table clients auto_increment=1;

-- cliente pessoa física
create table clientPF(
	idClientPF int primary key,
    CPF char(11) not null unique,
    constraint fk_client_pf foreign key (idClientPF) references clients(idClient)
);

-- cliente pessoa jurídica
create table clientPJ(
	idClientPJ int primary key,
    CNPJ char(14) not null unique,
    SocialName varchar(255) not null,
    constraint fk_client_pj foreign key (idClientPJ) references clients(idClient)
);

-- produtos
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(255) not null,
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliacao float default 0,
    size varchar(10)
);
alter table product auto_increment=1;

-- pedidos
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
);
alter table orders auto_increment=1;

-- entregas
create table delivery(
	idDelivery int auto_increment primary key,
    idOrder int not null,
    trackingCode varchar(50) unique,
    deliveryStatus enum('Aguardando envio', 'Enviado', 'Em trânsito', 'Entregue', 'Devolvido') default 'Aguardando envio',
    constraint fk_delivery_order foreign key (idOrder) references orders(idOrder)
);
alter table delivery auto_increment=1;

-- formas de pagamento
create table payments(
	idPayment int auto_increment primary key,
    idClient int not null,
    typePayment enum('Boleto', 'Cartão', 'Pix', 'Dois cartões'),
    limitAvailable float,
    constraint fk_payment_client foreign key (idClient) references clients(idClient)
);
alter table payments auto_increment=1;

-- estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0,
    sendValue float default 10
);
alter table productStorage auto_increment=1;

-- fornecedores
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(14) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
alter table supplier auto_increment=1;

-- vendedores
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(14),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);
alter table seller auto_increment=1;

-- relação produto-vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- relação produto-pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_order foreign key (idPOorder) references orders(idOrder)
);

-- relação produto-estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    locationDesc varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- relação produto-fornecedor
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
