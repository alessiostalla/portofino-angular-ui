PGDMP                 
        n           hibernatetest    8.4.2    8.4.2 "    
           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     )   SET standard_conforming_strings = 'off';
                       false                       1262    384478    hibernatetest    DATABASE     k   CREATE DATABASE hibernatetest WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE hibernatetest;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                       0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    3            9           2612    16386    plpgsql    PROCEDURAL LANGUAGE     $   CREATE PROCEDURAL LANGUAGE plpgsql;
 "   DROP PROCEDURAL LANGUAGE plpgsql;
             postgres    false            �           1259    384479    table1    TABLE     [   CREATE TABLE table1 (
    id integer NOT NULL,
    testo character varying(15) NOT NULL
);
    DROP TABLE public.table1;
       public         postgres    false    3            �           1259    384482    table1_id_seq    SEQUENCE     o   CREATE SEQUENCE table1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 $   DROP SEQUENCE public.table1_id_seq;
       public       postgres    false    1500    3                       0    0    table1_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE table1_id_seq OWNED BY table1.id;
            public       postgres    false    1501                       0    0    table1_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('table1_id_seq', 63, true);
            public       postgres    false    1501            �           1259    384490    table2    TABLE     �   CREATE TABLE table2 (
    id1 character varying(3) NOT NULL,
    id2 character varying(3) NOT NULL,
    testo character varying(15)
);
    DROP TABLE public.table2;
       public         postgres    false    3            �           1259    388867    table3    TABLE     �   CREATE TABLE table3 (
    id integer NOT NULL,
    t2_id1 character varying(3) NOT NULL,
    t2_id2 character varying(3) NOT NULL,
    tb4_id integer,
    tb1_id integer
);
    DROP TABLE public.table3;
       public         postgres    false    3            �           1259    388865    table3_id_seq    SEQUENCE     o   CREATE SEQUENCE table3_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 $   DROP SEQUENCE public.table3_id_seq;
       public       postgres    false    1504    3                       0    0    table3_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE table3_id_seq OWNED BY table3.id;
            public       postgres    false    1503                       0    0    table3_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('table3_id_seq', 2, true);
            public       postgres    false    1503            �           1259    388886    table4    TABLE     [   CREATE TABLE table4 (
    id integer NOT NULL,
    testo character varying(15) NOT NULL
);
    DROP TABLE public.table4;
       public         postgres    false    3            �           1259    388884    table4_id_seq    SEQUENCE     o   CREATE SEQUENCE table4_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
 $   DROP SEQUENCE public.table4_id_seq;
       public       postgres    false    1506    3                       0    0    table4_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE table4_id_seq OWNED BY table4.id;
            public       postgres    false    1505                       0    0    table4_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('table4_id_seq', 3, true);
            public       postgres    false    1505            �           2604    384484    id    DEFAULT     S   ALTER TABLE table1 ALTER COLUMN id SET DEFAULT nextval('table1_id_seq'::regclass);
 8   ALTER TABLE public.table1 ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1501    1500            �           2604    388870    id    DEFAULT     S   ALTER TABLE table3 ALTER COLUMN id SET DEFAULT nextval('table3_id_seq'::regclass);
 8   ALTER TABLE public.table3 ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1504    1503    1504            �           2604    388889    id    DEFAULT     S   ALTER TABLE table4 ALTER COLUMN id SET DEFAULT nextval('table4_id_seq'::regclass);
 8   ALTER TABLE public.table4 ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    1506    1505    1506                      0    384479    table1 
   TABLE DATA               $   COPY table1 (id, testo) FROM stdin;
    public       postgres    false    1500   �                  0    384490    table2 
   TABLE DATA               *   COPY table2 (id1, id2, testo) FROM stdin;
    public       postgres    false    1502   !                 0    388867    table3 
   TABLE DATA               =   COPY table3 (id, t2_id1, t2_id2, tb4_id, tb1_id) FROM stdin;
    public       postgres    false    1504   5!       	          0    388886    table4 
   TABLE DATA               $   COPY table4 (id, testo) FROM stdin;
    public       postgres    false    1506   b!       �           2606    384489    table1_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY table1
    ADD CONSTRAINT table1_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.table1 DROP CONSTRAINT table1_pkey;
       public         postgres    false    1500    1500            �           2606    384494    table2_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY table2
    ADD CONSTRAINT table2_pkey PRIMARY KEY (id1, id2);
 <   ALTER TABLE ONLY public.table2 DROP CONSTRAINT table2_pkey;
       public         postgres    false    1502    1502    1502                        2606    388872    table3_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY table3
    ADD CONSTRAINT table3_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.table3 DROP CONSTRAINT table3_pkey;
       public         postgres    false    1504    1504                       2606    388891    table4_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY table4
    ADD CONSTRAINT table4_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.table4 DROP CONSTRAINT table4_pkey;
       public         postgres    false    1506    1506                       2606    388873    table3_t2_id1_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY table3
    ADD CONSTRAINT table3_t2_id1_fkey FOREIGN KEY (t2_id1, t2_id2) REFERENCES table2(id1, id2);
 C   ALTER TABLE ONLY public.table3 DROP CONSTRAINT table3_t2_id1_fkey;
       public       postgres    false    1502    1504    1504    1789    1502                       2606    388892    table3_tb1_id_fkey    FK CONSTRAINT     j   ALTER TABLE ONLY table3
    ADD CONSTRAINT table3_tb1_id_fkey FOREIGN KEY (tb1_id) REFERENCES table1(id);
 C   ALTER TABLE ONLY public.table3 DROP CONSTRAINT table3_tb1_id_fkey;
       public       postgres    false    1787    1504    1500                       2606    388897    table3_tb4_id_fkey    FK CONSTRAINT     j   ALTER TABLE ONLY table3
    ADD CONSTRAINT table3_tb4_id_fkey FOREIGN KEY (tb4_id) REFERENCES table4(id);
 C   ALTER TABLE ONLY public.table3 DROP CONSTRAINT table3_tb4_id_fkey;
       public       postgres    false    1506    1504    1793                  x�3�L-N�-���2����=... �V
N         "   x�stt�tb���|.�$ �ɉ�ĉ���� v�            x�3�tttcCN#.C8�ȋ���� _;      	      x�3�t�2�t�2�t����� Q>     