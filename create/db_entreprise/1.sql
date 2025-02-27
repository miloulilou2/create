CREATE TABLE Categorie_Article (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom NVARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE Produit (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    designation NVARCHAR2(50) NOT NULL,
    description NVARCHAR2(255),
    seuil_reapprovisionnement INT NOT NULL,
    article_fini BOOLEAN NOT NULL,
    methode_valorisation VARCHAR2(10) CHECK (methode_valorisation IN ('FIFO', 'LIFO', 'CMUP')),
    prix_unitaire NUMBER(10,2) NOT NULL,
    id_categorie INT NOT NULL,
    ref_fournisseur VARCHAR2(50),
    date_ajout DATE DEFAULT SYSDATE,
    code_ean VARCHAR2(12) UNIQUE NOT NULL,
    poids_unite NUMBER(10,3) NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES Categorie_Article(id) ON DELETE CASCADE
);

CREATE TABLE Tiers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom NVARCHAR2(100) NOT NULL,
    adresse NVARCHAR2(255),
    email NVARCHAR2(100) UNIQUE NOT NULL,
    role NVARCHAR2(20) CHECK (role IN ('client', 'fournisseur')) NOT NULL,
    iban NVARCHAR2(34) UNIQUE NOT NULL
);

CREATE TABLE Commande (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_tiers INT NOT NULL,
    date_transaction DATE DEFAULT SYSDATE,
    type_commande NVARCHAR2(10) CHECK (type_commande IN ('achat', 'vente')) NOT NULL,
    statut NVARCHAR2(10) CHECK (statut IN ('Brouillon', 'Nouveau', 'Confirmé')) NOT NULL,
    FOREIGN KEY (id_tiers) REFERENCES Tiers(id) ON DELETE CASCADE
);

CREATE TABLE Commande_Produit (
    id_commande INT NOT NULL,
    id_produit INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_commande, id_produit),
    FOREIGN KEY (id_commande) REFERENCES Commande(id) ON DELETE CASCADE,
    FOREIGN KEY (id_produit) REFERENCES Produit(id) ON DELETE CASCADE
);
