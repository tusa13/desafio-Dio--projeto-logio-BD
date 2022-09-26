--- criacao de banco de dados para o cenario E-commerce
drop database ecommerce;
create database ecommerce;
use ecommerce;

--- criar tabela cliente

create table clients( 
       idClient int auto_increment primary key,
       Fname varchar(10),
       Minit char(3),
       Lname varchar(20),
       CPF char(11) not null,
       Address varchar(30),
       constraint unique_cpf_cliente unique (CPF)
);

alter table clients auto_increment=1;
desc clients;

--- criar tabela produto
--- size= dimensao do produto

create table product(
        idProduct int auto_increment primary key,
        Pname varchar(10),
        classification_kids bool default false,
        category enum ('eletronicos','brinquedos','alimentos','moveis'),
		avaliation float default 0,
        size varchar (10)
);

desc product;

 create table payments(
        idClient int,
        idPayment int,
        typePayment enum ('boleto', 'cartao',' transferencia bancaria'),
        limitAvaliable float,
        primary key( idClient, idpayment)
);        
   
   desc payments;
   
 --- criar tabela pedido
 
 create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('cancelado','confirmado','em andamento') default 'em andamento',
        orderDescription varchar(255),
        shipping float default 10,
        paymentCash bool default false,
        idPayment varchar(30),
        constraint fk_order_client foreign key (idOrderClient) references clients(idCliente)
                    on update cascade
);

desc orders;

--- criar tabela estoque

create table productStorage(
       idprodStorage int auto_increment primary key,
       storageLocation varchar(255),
       quantity int default 0
);      

desc productStorage;
        
--- criar tabela fornecedor

create table supplier(
        idSupplier int auto_increment primary key,
        SocialName varchar (255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);        
 
 desc supplier;
 
--- criar tabela vendedor

create table seller(
        idSeller int auto_increment primary key,
        SocialName varchar (255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(09), 
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_sellerr unique (CNPJ),
        constraint unique_cpf_sellerr unique (CPF)
);

desc seller;

create table productSeller(
        idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller, idProduct),
        constraint fk_product_selller foreign key (ipPseller) references seller(idSeller),
        constraint fk_product_product foreign key (ipPproduct) references product(idProduct)
  );      
  
desc productSelller;
  
 create table productOrder(
        idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum ('disponivel','sem estoque') default 'disponivel',
        primary key (idPOproduct, idPOorder),
        constraint fk_productorder_selller foreign key (idPOproduct) references product(idProduct),
        constraint fk_productorder_product foreign key (ipPOorder) references orders(idOrder)
  );      
        
desc productOrder;
        
       create table storageLocation(
        idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (ipLproduct) references product(idProduct),
        constraint fk_storage_location_storage foreign key (ipLstorage) references productStorage(idProdStorage)
  );    
  
desc productSuplier;
  
show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

  