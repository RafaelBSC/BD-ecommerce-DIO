-- inserção de dados e queries
use ecommerce2;
show tables;
insert into Clients (Fname, Minit, Lname, Address)
		values('Maria','M','Silva','rua P 12, Paulista - PE'),
			  ('João','M','Souza','Av. Central 45, Recife - PE'),
              ('Ana','F','Pereira','Rua das Flores 210, Olinda - PE'),
              ('Carlos','M','Oliveira','Travessa Nova 33, Jaboatão - PE'),
			  ('Beatriz','F','Almeida','Rua Projetada 77, Cabo - PE'),
			  ('Fernanda','F','Costa','Av. Beira Mar 120, Ipojuca - PE');
			   	
              
insert into Clients (Fname, Minit, Lname, Address)  value            
			  (NULL, NULL, 'Tech Solutions LTDA', 'Av. Empresarial 100, Recife - PE'),
			  (NULL, NULL, 'Comercial ABC LTDA', 'Rua Comércio 50, São Paulo - SP'),
			  (NULL, NULL, 'Dist XYZ LTDA', 'Av. Distribuição 75, Belo Horizonte - MG');
              
              
select * from   Clients;

insert into clientPF (idClientPF, CPF)
values (1, '123123123'),
       (2, '987654321'),
       (3, '456789123'),
       (4, '852963741'),
       (5, '741258963'),
       (6, '369852147');
       
-- select * from clientPF;          
       
insert into clientPJ (idClientPJ, CNPJ, SocialName)
values (10, '11222333000181', 'Tech Solutions LTDA'),
       (11, '99887766000155', 'Comercial ABC LTDA'),
       (12, '55443322000199', 'Dist XYZ LTDA');       
       
       
-- select * from clientPJ;       

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

insert into delivery (idOrder, trackingCode, deliveryStatus)
values (5, 'BR123456789BR', 'Aguardando envio'),
       (6, 'BR987654321BR', 'Em trânsito'),
       (7, 'BR456123789BR', 'Entregue'),
       (8, 'BR741852963BR', 'Aguardando envio');
       
-- select * from delivery;   


insert into payments (idClient, typePayment, limitAvailable)
values (1, 'Cartão', 2000.00),
       (1, 'PIX', null),
       (2, 'Boleto', null),
       (3, 'Cartão', 1500.00),
       (4, 'PIX', null),
       (5, 'PIX', null),
       (6, 'Cartão', 1000.00),
       (6, 'Boleto', null),
       (2, 'Cartão', 500.00);
       
-- select * from payments;        

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
					(1,5,2,null),
                    (2,6,1,null),
                    (3,7,1,null),
                    (4,8,1,null);
                    
                    
-- select * from productOrder;                    

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
                        
-- Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.Fname,
    c.Lname,
    COUNT(o.idOrder) AS total_pedidos
FROM clients c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient, c.Fname, c.Lname
ORDER BY total_pedidos DESC;             

-- Algum vendedor também é fornecedor?
SELECT 
    s.SocialName AS nome_vendedor,
    sup.SocialName AS nome_fornecedor
FROM seller s
INNER JOIN supplier sup
    ON s.CNPJ IS NOT NULL 
    AND s.CNPJ = sup.CNPJ;

-- Relação de produtos fornecedores e estoques

SELECT 
    p.Pname AS produto,
    sup.SocialName AS fornecedor,
    ps.quantity AS quantidade_fornecedor,
    psStorage.quantity AS quantidade_estoque,
    psStorage.storageLocation AS local_estoque
FROM product p
INNER JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
INNER JOIN supplier sup ON ps.idPsSupplier = sup.idSupplier
LEFT JOIN productStorage psStorage ON psStorage.idProdStorage IN (
    SELECT idLstorage FROM storageLocation sl WHERE sl.idLproduct = p.idProduct
)
ORDER BY p.Pname;

-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
    sup.SocialName AS fornecedor,
    p.Pname AS produto
FROM supplier sup
INNER JOIN productSupplier ps ON sup.idSupplier = ps.idPsSupplier
INNER JOIN product p ON ps.idPsProduct = p.idProduct
ORDER BY sup.SocialName, p.Pname;


           
                        
                        