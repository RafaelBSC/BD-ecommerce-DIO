-- inserção de dados e queries
use ecommerce;
show tables;
insert into Clients (Fname, Minit, Lname, CPF, Address)
		values('Maria','M','Silva','123123123','rua P 12, Paulista - PE'),
			  ('João','M','Souza','987654321','Av. Central 45, Recife - PE'),
              ('Ana','F','Pereira','456789123','Rua das Flores 210, Olinda - PE'),
              ('Carlos','M','Oliveira','852963741','Travessa Nova 33, Jaboatão - PE'),
			  ('Beatriz','F','Almeida','741258963','Rua Projetada 77, Cabo - PE'),
			  ('Fernanda','F','Costa','369852147','Av. Beira Mar 120, Ipojuca - PE');		

-- select * from   Clients

insert into product (Pname, classification_kids, category, avaliacao, size) values
					('Fone de ouvido',false,'Eletrônico','4',null),
                    ('Barbie Elsa',true,'Brinquedos','3',null),
                    ('Body Carters',true,'Vestuário','5',null),
                    ('Microfone Vedo - Youtube',false,'Eletrônico','4',null),
                    ('Sofá retrátil',false,'Móveis','3','3x57x80'),
                    ('Farinha de arroz',false,'Alimentos','2',null),
                    ('Fire Stick Amazon',false,'Eletrônico','3',null);

-- select * from  product      
-- delete	from orders where idOrderClient in (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
					(1, default,'compra via aplicativo',null,1),
                    (2, default,'compra via aplicativo',null,1),
                    (3, 'Confirmado',null,null,1),
                    (4, default,'compra via web site',150,0);
                    
-- select * from orders;

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
					(1,5,2,null),
                    (2,6,1,null),
                    (3,7,1,null),
                    (4,8,1,null);
                    
                    
-- select * from productOrder;                    
-- SELECT * FROM productOrder;

insert into productStorage (storageLocation, quantity) values
						('Rio de Janeiro','1000'),
                        ('Rio de Janeiro','500'),
                        ('São Paulo','10'),
                        ('São Paulo','100'),
                        ('São Paulo','10'),
                        ('Brasília','60');
                        
-- SELECT * FROM productStorage;    

insert into storageLocation (idLproduct, idLstorage, locationDesc) values
						(1,2,'RJ'),
                        (2,6,'GO');
                        
-- SELECT * FROM storageLocation; 


insert into supplier (SocialName, CNPJ, contact) values     
						('Almeida e filhos','12345678000195','21963637474'),
                        ('Eletrônicos Silva','98765432000110','89998766666'),
                        ('Eletrônicos Valma','45678912000134','86912223344');

-- SELECT * FROM supplier; 

insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						(1,1,500),
                        (1,2,400),
                        (2,4,633),
                        (3,3,5),
                        (2,5,10);

-- SELECT * FROM productSupplier;

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
						('Tech eletronicos',null, 12345578000195, null, 'Rio de Janeiro',21935353535 ),
                        ('Botique Durgas',null, null, 09898787654, 'Rio de Janeiro', 34984847474),
                        ('Kids World', null, 45671112000134, null, 'São Paulo', 78976546543);

-- SELECT * FROM seller;

insert into productSeller (idPseller, idPproduct, prodQuantity) values
						(1,6,80),
                        (2,7,10);

-- SELECT * FROM productSeller;
-- RECUPERAR QUANTIDADE DE CLIENTES
select count(*) from clients;

-- VERIFICAR OS PEDIDOS FEITOS PELOS CLIENTES:
select * from clients c, orders o where c.idClient = idOrderClient;

-- ESPECIFICAR QUIAS ATRIBUTOS RECUPERADOS
select Fname,Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;





















































                   
                    