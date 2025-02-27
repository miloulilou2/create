-- créer un lien vers db_entreprise depuis db_gestion_comptable
CREATE DATABASE LINK EntrepriseDB_Link
CONNECT TO entreprise_user IDENTIFIED BY 'motdepasse'
USING 'EntrepriseDB';

--

CREATE TABLE Facture (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_commande INT NOT NULL,
    date_facture DATE DEFAULT SYSDATE,
    montant_total NUMBER(10,2) NOT NULL,
    etat NVARCHAR2(15) CHECK (etat IN ('Non payée', 'Payée', 'Annulée')) NOT NULL,
    mode_paiement NVARCHAR2(20) CHECK (mode_paiement IN ('Virement', 'Carte', 'Espèces')) NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES Commande@EntrepriseDB_Link(id) ON DELETE CASCADE
);
