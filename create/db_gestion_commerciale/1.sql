-- créer un lien vers db_entreprise depuis db_gestion_commerciale
CREATE DATABASE LINK EntrepriseDB_Link
CONNECT TO entreprise_user IDENTIFIED BY 'motdepasse'
USING 'EntrepriseDB';

--
CREATE TABLE Stock (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_produit INT NOT NULL,
    quantite_totale INT NOT NULL CHECK (quantite_totale >= 0),
    FOREIGN KEY (id_produit) REFERENCES Produit@EntrepriseDB_Link(id) ON DELETE CASCADE
);
