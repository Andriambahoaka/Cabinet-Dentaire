/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     02/03/2017 09:39:05                          */
/*==============================================================*/


drop index RDV_FACTUREFILLE_FK;

drop index ASSOCIATION_3_FK;

drop index FACTUREFILLE_PK;

drop table FACTUREFILLE;

drop index FACTUREMERE_PK;

drop table FACTUREMERE;

drop index PATIENT_PK;

drop table PATIENT;

drop index RENDEZVOUS_PATIENT_FK;

drop index RDV_TRAITEMENT_FK;

drop index RENDEZVOUS_PK;

drop table RENDEZVOUS;

drop index TRAITEMENT_PK;

drop table TRAITEMENT;

/*==============================================================*/
/* Table: FACTUREFILLE                                          */
/*==============================================================*/
create table FACTUREFILLE (
   IDFACTUREFILLE       SERIAL               not null,
   IDRDV                INT4                 not null,
   IDFACTUREMERE        INT4                 not null,
   constraint PK_FACTUREFILLE primary key (IDFACTUREFILLE)
);

/*==============================================================*/
/* Index: FACTUREFILLE_PK                                       */
/*==============================================================*/
create unique index FACTUREFILLE_PK on FACTUREFILLE (
IDFACTUREFILLE
);

/*==============================================================*/
/* Index: ASSOCIATION_3_FK                                      */
/*==============================================================*/
create  index ASSOCIATION_3_FK on FACTUREFILLE (
IDFACTUREMERE
);

/*==============================================================*/
/* Index: RDV_FACTUREFILLE_FK                                   */
/*==============================================================*/
create  index RDV_FACTUREFILLE_FK on FACTUREFILLE (
IDRDV
);

/*==============================================================*/
/* Table: FACTUREMERE                                           */
/*==============================================================*/
create table FACTUREMERE (
   IDFACTUREMERE        SERIAL               not null,
   DATEFACTURE          DATE                 null,
   NOMPERSONNE          VARCHAR(40)          null,
   constraint PK_FACTUREMERE primary key (IDFACTUREMERE)
);

/*==============================================================*/
/* Index: FACTUREMERE_PK                                        */
/*==============================================================*/
create unique index FACTUREMERE_PK on FACTUREMERE (
IDFACTUREMERE
);

/*==============================================================*/
/* Table: PATIENT                                               */
/*==============================================================*/
create table PATIENT (
   IDPATIENT            SERIAL               not null,
   NOM                  VARCHAR(30)          null,
   PRENOM               VARCHAR(30)          null,
   CONTACT_             VARCHAR(30)          null,
   ADRESSE              VARCHAR(30)          null,
   constraint PK_PATIENT primary key (IDPATIENT)
);

/*==============================================================*/
/* Index: PATIENT_PK                                            */
/*==============================================================*/
create unique index PATIENT_PK on PATIENT (
IDPATIENT
);

/*==============================================================*/
/* Table: RENDEZVOUS                                            */
/*==============================================================*/
create table RENDEZVOUS (
   IDRDV                SERIAL               not null,
   IDTRAITEMENT_        INT4                 not null,
   IDPATIENT            INT4                 not null,
   DATERDV              DATE                 null,
   ETAT                 INT4                 null,
   HEUREDEBUT           TIME                 null,
   HEUREFIN_            TIME                 null,
   constraint PK_RENDEZVOUS primary key (IDRDV)
);

/*==============================================================*/
/* Index: RENDEZVOUS_PK                                         */
/*==============================================================*/
create unique index RENDEZVOUS_PK on RENDEZVOUS (
IDRDV
);

/*==============================================================*/
/* Index: RDV_TRAITEMENT_FK                                     */
/*==============================================================*/
create  index RDV_TRAITEMENT_FK on RENDEZVOUS (
IDTRAITEMENT_
);

/*==============================================================*/
/* Index: RENDEZVOUS_PATIENT_FK                                 */
/*==============================================================*/
create  index RENDEZVOUS_PATIENT_FK on RENDEZVOUS (
IDPATIENT
);

/*==============================================================*/
/* Table: TRAITEMENT                                            */
/*==============================================================*/
create table TRAITEMENT (
   IDTRAITEMENT_        SERIAL               not null,
   TRAITEMENT           VARCHAR(30)          null,
   MONTANT              NUMERIC              null,
   constraint PK_TRAITEMENT primary key (IDTRAITEMENT_)
);

/*==============================================================*/
/* Index: TRAITEMENT_PK                                         */
/*==============================================================*/
create unique index TRAITEMENT_PK on TRAITEMENT (
IDTRAITEMENT_
);

alter table FACTUREFILLE
   add constraint FK_FACTUREF_ASSOCIATI_FACTUREM foreign key (IDFACTUREMERE)
      references FACTUREMERE (IDFACTUREMERE)
      on delete restrict on update restrict;

alter table FACTUREFILLE
   add constraint FK_FACTUREF_RDV_FACTU_RENDEZVO foreign key (IDRDV)
      references RENDEZVOUS (IDRDV)
      on delete restrict on update restrict;

alter table RENDEZVOUS
   add constraint FK_RENDEZVO_RDV_TRAIT_TRAITEME foreign key (IDTRAITEMENT_)
      references TRAITEMENT (IDTRAITEMENT_)
      on delete restrict on update restrict;

alter table RENDEZVOUS
   add constraint FK_RENDEZVO_RENDEZVOU_PATIENT foreign key (IDPATIENT)
      references PATIENT (IDPATIENT)
      on delete restrict on update restrict;

