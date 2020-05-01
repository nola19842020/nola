//################################################################ TarifHin.INC
{Lukee TarifHinD.NOL -tekstitiedoston ja siirtää alustettuun tietueeseen:      HavTarif.............
 1 Mitoitusjakso               20          [a] : 21    ¯¿           Tpit    7  HavTarif.Tpit
 2 Laskentakorko_______________12.00_____[%/a]_: 13    ¯Á7.1        korko   8  HavTarif.korko
 3 Huoltokustannukset           1.00  [%inv/a] : 1.1     20.53      Hprs    9  HavTarif.Hprs
 4 Huipun käyttöaika   1,2)  2800        [h/a] : 2801    !          Tph     10 HavTarif.Tph
 5 YÖkulutuksen osuus  1)       5.00       [%] : 10      !          YOprs   11 HavTarif.YOprs
 6 Tyhjäkäyntivakio      2)     0.30           : .4      !          Ktyh    12 HavTarif.Ktyh
 7                Huipputeho    1.00     [%/a] : 2       !          dPprs   13 HavTarif.dPprs
 8                Energ.hinta   2.00     [%/a] : 6.4     !          dWmkprs 14 HavTarif.dWmkprs
 9 TARIFFImaksut: 1)PVenergia  33.30   [p/kWh] : 33.4    !          PVpen   15 HavTarif.PVpen
10                1)YÖenergia  13.30   [p/kWh] : 13.4    !          YOpen   16 HavTarif.YOpen
11                1)Tehomaksu 231.00 [mk/kW/a] : 232     !          Pmk     17 HavTarif.Pmk     }
{---------------------------------------------------------------------------------------------------
NolaJH.EXE :stä kaapattu............................................................................
 «-=Paluu   -»=Eteenp   Enter=OletOK    End=Lopet   Home=Alkup   Esc=Seur.ve
                                                             Uh%=0.00  Tj°C=80
ý + EI EDELTÄVIÄ JOHTOJA                                     +Nj 4.00% AsTapa=A
800kVA------PT                                               TAS=1     KORJ=0.95

Tiedosto: KUSLAS.NOL           Esim.    Dimens.  Syöttö  DISKONTATUT NYKYARVOT:
 1 Mitoitusjakso               20          [a] : 20    »|
_2_Laskentakorko_______________12.00_____[%/a]_: 12    »-7.47  DISKONT/Huol,Häv
 3 Huoltokustannukset           1.00  [%inv/a] : 1       7.47  % «-[12  %  20a]
 4 Huipun käyttöaika   1,2)  2800       [h /a] : 2000    --
 5 YÖkulutuksen osuus    1)     5.00       [%] : 5       --
 6 Tyhjäkäyntivakio      2)     0.30           : .3      LOPPUARVOT___________:
 7 KASVUennuste: Huipputeho     1.00     [%/a] : 11.2    +736  % «-[11.2%  20a]
 8               Energ.hinta    2.00     [%/a] : 2       +49   % «-[2   %  20a]
 9 TARIFFmaksut: 1) PVenergia  33.30   [p/kWh] : 33.3    49.48   «-[2   %  20a]
10               1) YÖenergia  13.30   [p/kWh] : 13.3    19.76   «-[2   %  20a]
11_______________1) Tehomaksu 231.00 [mk/kW/a]_: 231     343.25  «-[2   %  20a]
12 LASKETTU: 1) HÄVIÖenerg.keskih. p/kWh=  53.09/61.84    78.89/91.89 «["% 20a]
13 ::::::::: 2) HÄVIÖhuipun k.aika   h/a=   1111/782    «^[12,13: CosÝ 0.6/0.9]

 Anna parametrit pää-/nousujohtojen INVESTOINTI-, HUOLTO- ja HÄVIÖKUSTANNUSTEN
 kapitalisoimiseksi. HUIPPUTEHON KASVUENNUSTEEN ollessa >0 % /a, NOLA kasvattaa
 aikaisemmin syöttämääsi HUIPPUTEHOA ao. ennusteen mukaisesti.
    Rivejä 1 ja 2 voit käyttää myös esim. lainan NYKYARVOn laskemiseen=K x7.47
K/R/E=oK/eRittely/EiOK  Ohita  Lue  Talleta  W=Tulosta ?apu:
----------------------------------------------------------------------------------------------------}
PROCEDURE LueTarif; //,,,,,KAIKKI PRC:t + FNC:t voisi olla pääPRC :n sisällä
      VAR TarifPolkuFilen :string;  TarifFile :Text;

   //...............................................................................................
                                                        //,RV=ao.sorcerivi  AOR=ao.arvorivi (<>';')
   PROCEDURE LueSijTarif;     CONST MaxAOR=11;   VAR i,mja,rv,aor :Integer;  sorc,s :string;
      //............................................................................................
      procedure Fherja (sh :string);   begin
         MessageDlg (sh, mtInformation, [mbOk], 0);   end;
      //............................................................................................
      procedure sorceherja;   begin
         Fherja ('Tariffihintatiedostossa '''+TarifPolkuFilen+''' virhe,   Rivi: '+fImrkt0 (rv,1) +
                     '  (sijoitetaan arvoksi 0).');   end;
      //............................................................................................
     {function fInt (ss :string) :integer;       VAR  i :integer;    BEGIN //<,,Ei käytetty
         if not SokI (ss,i)  then begin  sorceherja;  i := 0;   end;   Result := i;   end;}
      //............................................................................................
      procedure fRea (ss :string;  VAR alkio :ArvoTyyp);      VAR  r :real;      BEGIN //,Hoitaa myös ',' -> '.'
         if NOT SokR (ss,r)  then begin  sorceherja;  r := 0;   end;
         with alkio  do begin
            arvoTyp := Reaa;   arvoRea := r;
            {Ei tarvitsis:}    onArvo := true;  onAlar := false;  alarRea := 0;
                                                onYlar := false;  ylarRea := 0;  end;//with
      end;

   BEGIN//LueSijTarif ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      with HavTarif  do begin //<,,Jos file=EiOK, arvot jäävät voimaan (siitä lähtien)
         fRea (  '20', Tpit);       fRea (   '5', YOprs);        fRea ( '5.60', PVpen);
         fRea (  '12', korko);      fRea ( '0.3', Ktyh);         fRea ( '2.24', YOpen);
         fRea (   '1', Hprs);       fRea (   '1', dPprs);        fRea ('38.85', Pmk);
         fRea ('2800', Tph);        fRea (   '2', dWmkprs);
      end;
      rv := 0;  aor := 0;
      while NOT Eof (TarifFile)  {and (aor<MaxAOR)  }do begin //<OK, mutta kommentoimalla vex nähdään, onko mahd.
     {}  rv := rv+1;                                          //'useampia arvorivejä, jotta vois herjata !!!!!!!!
     {}  Readln (TarifFile, sorc);
     {}
     {}  i := 1;   mja := Length (sorc);
     {}  while (i<mja)  and  (sorc[i]=' ')  do                     //<Ohitetaan tyhjät
     {}     i := i+1;
     {}
     {}  s := '';
     {}  while (i<=mja)  and (CharInSet(sorc[i], ['0'..'9','.']))  do begin //<Luetaan Recordin yksiArvo =Rivin alku
     {}     s := s +sorc[i];   i := i+1;  end;                     //'Jos ekaMrk='.', SokR hoitaa 0 :ksi!!!
     {}
     {}  if s<>''  then with HavTarif  do begin
     {}     aor := aor +1;
     {}     case aor  of
     {}          1 :fRea (s, Tpit);
     {}          2 :fRea (s, Korko);
     {}          3 :fRea (s, Hprs);
     {}          4 :fRea (s, Tph);
     {}          5 :fRea (s, YOprs);
     {}          6 :fRea (s, Ktyh);
     {}          7 :fRea (s, dPprs);
     {}          8 :fRea (s, dWmkprs);
     {}          9 :fRea (s, PVpen);
     {}         10 :fRea (s, YOpen);
     {}        else fRea (s, Pmk);    end;//case
     {}  end;//if s<>''  with
      end;//while not Eof
      if aor<MaxAOR  then Fherja ('Tariffihintatiedostossa '''+TarifPolkuFilen+''' virhe,   Rivi: ' +
         fImrkt0 (rv,1) +',  arvorivejä liian vähän.   Ohjelma jatkaa, mutta pää-/nousujohtojen '+
         'häviökustannuslaskennan OLETUSTIEDOT ovat epäluotettavia!');
      if aor>MaxAOR  then Fherja ('Tariffihintatiedostossa '''+TarifPolkuFilen+''' virhe,   Rivi: ' +fImrkt0 (rv,1) +
           ',  arvorivejä liian monta.   Ohjelma jatkaa, mutta pää-/nousujohtojen häviökustannuslaskennan '+
           'OLETUSTIEDOT SAATTAVAT olla epäluotettavia!');
      //Beep;
   end;//LueSijTarif
BEGIN//LueTarif ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
                               //TarifFilen := 'TarifHinD.NOL';
                               //TarifPolku := 'C:\Projektit\NolaKehi\Bin\';
 //TarifPolkuFilen := fHaePolkuFilen (TARIFFIHINTA_FILE_ID);  //<fHae.. siirrtty Y_.PAS´siin 12.0.05  -130.0
   TarifPolkuFilen := gAjoConfPath +'TarifHinD.NOL';          //<+130.0
   if NOT fFileExists (TarifPolkuFilen)
   then  begin end                                            //<Vois tehdä jotain, ei liene tarvetta ???????????
   else try
                               //¿DefsFileen('AssgnFile 6');
         AssignFile (TarifFile, TarifPolkuFilen);
         Reset (TarifFile);
         LueSijTarif;
         CloseFile (TarifFile);
      except
         on E:Exception  do CloseFile (TarifFile);
      end;//try}
{   else try                                           //<',Jos AOR=11 ja rvja >=12 ->EAcces Violation, eikä nämä
         AssignFile (TarifFile, TarifPolkuFilen);      //   muutokset vaikuta mitenkään. Ei vaikka Herjainfo on
         Reset (TarifFile);                            //   on muutettu Fherjaksi =paikalliseksi !!!!!!!!!!!!!!!!
         LueSijTarif;
        finally
         Close (TarifFile);
        end;}
END;//LueTarif


