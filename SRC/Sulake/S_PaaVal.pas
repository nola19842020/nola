{
* Copyright (c) 2020, Reijo Pursiainen, Hannu Pursiainen
* All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*     * Redistributions of source code must retain the above copyright
*       notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above copyright
*       notice, this list of conditions and the following disclaimer in the
*       documentation and/or other materials provided with the distribution.
*     * Neither the name of Reijo Pursiainen, Hannu Pursiainen nor the
*       names of its contributors may be used to endorse or promote products
*       derived from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY REIJO PURSIAINEN, HANNU PURSIAINEN AND
* CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING,
* BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL REIJO PURSIAINEN,
* HANNU PURSIAINEN AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
* INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
* LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
* ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

unit S_PaaVal;   //DEVELOPER2, etsi ja täydennä kohdat:  DEVELOPER2TextBase
                 //##################### StringGrid on ZS_Frm´issa, missä myös tulostus yms. ##############################################
interface        //########################################################################################################################
{ZS_SuTimCm =uusin lisäys ComboBoxXY +130.0
                 ###############################################################################################
                 ###############################################################################################
                 ########## Yleispiirre:   PRC asetaSval1..4´ssa          sijoitukset, asetukset jne. ##########
                 ##########                PRC          1..4_Cells..´ssa  sijoitukset Celleihin.################
                 ########## Lbl´it +Box´ien sijoitus: PRC COMX_JalkSij_Lbl_MEDI tai ..COMX´llä.#################
                 ###############################################################################################
                 ############## KAIKKI Left := muutettu  ZS_Mm2Cm.Left :=  ===Komponentti näkyviin.#############
                 ###############################################################################################
Iq_T1_Cells =Ik :Sval=1
Tq_I2_Cells =Tk       2
Iq_I3_Cells           3
}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, defs, globals, NolaForms;

type
  TS_PaaValFrm = class(TFormNola)
    S_PaaValBtn: TButton;
    S_IkTimBtn: TButton;
    S_TimIkBtn: TButton;
    S_VrtBtn: TButton;
    S_IkTlkBtn: TButton;
    S_PaaLalLbl: TLabel;
    S_IkTimLbl: TLabel;
    S_TimIkLbl: TLabel;
    S_VrtLbl: TLabel;
    S_IkTlkLbl: TLabel;
    KayraBtn: TButton;
    Label1: TLabel;
    procedure S_IkTimBtnClick(Sender: TObject);
    procedure S_PaaValBtnClick(Sender: TObject);
    procedure S_TimIkBtnClick(Sender: TObject);
    procedure S_VrtBtnClick(Sender: TObject);
    procedure S_IkTlkBtnClick(Sender: TObject);
    procedure KayraBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  S_PaaValFrm: TS_PaaValFrm;
  suCs :string;
  Isu :integer;  Ik,Tk,Sftk :real;                              //<,Tässä jotta ZS_ -unit tunnistaisi
  procedure ohjaaSval;
  function okIsu  :boolean;
  function okSuc  :boolean;
  function okIk   :boolean;
  function okTk   :boolean;
  function okSftk :boolean;
  procedure AddSul_Mm2Lbl_jaCm_Lft;
  procedure asetaSval1;
  procedure asetaSval2;
  procedure asetaSval3;
  procedure asetaSval4;

function fRP (si :string) :string;

implementation

uses {koe,=@} PaaVal{+}, Y_, Unit0, Herja1, ZS_, textbasetexts, Kayra,  //<PaaVal vain var PVAL,SVAL,okIsu,okIk,okTk,okSftk :n takia
      DetEv{DetEvFrm.HIDE +130.1};
{$R *.DFM}

const cIsuPit=55;  cIkPit=45;  cAikaPit=40;  cSftPit=30;

function fRP (si :string) :string;      VAR ss :string;  u :integer;      begin
   result := '';
   ss := '__repu__¤';
   u := Pos(ss,si);                                //<,Ei lisätä jos on jo mukana.
   if fRePunKehi and (u=0)  then result := ss +si;
end;

{$I '..\sulake\NOLAS.INC'}

procedure TS_PaaValFrm.S_PaaValBtnClick(Sender: TObject);   begin
  Close;
  ZS_Frm.Close;
  KayraFrm.Close;   end;
//===============================================================================================================
procedure ohjaaSval;      begin //Aval=2/2. =Tullaan tokax tänne.    _<>'1 ohjaaSval '
   Pval := 2;             //<Pitää ajan tasalla, jos välillä Z_val/S_val
   {ZS_Frm.ZS_SuTypLbl.Hint :=  fRP('®ZS_SuTypLbl'); //<,,+130.0:  ® kertoo Hintin määrittyneen täällä.  -130.1:  Ei worki, muualta sijoitus näkyy.
    ZS_Frm.ZS_LLbl.Hint :=   fRP('®ZS_LLbl');
    ZS_Frm.ZS_TLbl.Hint :=   fRP('®ZS_TLbl');
    ZS_Frm.ZS_Mm2Lbl.Hint := fRP('®ZS_Mm2Lbl');
    ZS_Frm.ZS_TypLbl.Hint := fRP('®ZS_TypLbl');
    ZS_Frm.ZS_SuTypCm.Hint :=  fRP('®ZS_SuTypCm');
    ZS_Frm.ZS_SuTypLbl.Hint :=  fRP('®ZS_SuTypLbl');}

   case Aval of                  //Pval=1 =Z-valinta  2=S-valinta ###############################################
        1 :Ik_sv1_Cells;
        2 :Tk_sv2_Cells;
        3 :Ik_sv3_Cells;
     else  Ik_TxSv4_Cells;
   end; {case}

   tarkistColCount; //<Tutkii ja asettaa max.ColCountin niin, ettei kapeamman Gridin GridLinet näy harmaana osana
   topAlimmanMuk;
   ZS_Frm.Show;
NayAsetuksetGrd(0); //<+130.0:  Esiteltävä ZS_Frm´n VAR-osassa.  ZS_StrGridMouseDown´ssakin.  0=Lbl´eita ei muuteta.
   ZS_Frm.Caption := PROGRAM_VERSIO_STRING +':  Sulaketarkastelut   [ ' +Ints (Aval) +' ]';
   //ss := ZS_Frm.ZS_StrGrid.Cells[0,3];             //'+10.0.1: Sval jälkeen uusi Caption, ks. myös ZS_.PAS
   //ZS_Frm.ZS_StrGrid.Cells[0,3] := ss;
end;//ohjaaSval
//===============================================================================================================
procedure asetaSval_Y_Txt;      var S,sq :String;   {xx :integer;}      begin //Aval=2/5. tänne.
  fBxtNyt('asetaSval_Y_Txt');
  with ZS_Frm  do begin
    CASE Sval OF                          //,,Sijoitettu S´ään mutta sitä eioo käytetty ollenkaan. Tekstisijoitukset.. ks. alempana.
       1 :S := myTextBase.Get(S_1);             //<S_1='1   VIRTAA VASTAAVA SULAKKEEN TOIMINTA-AIKA  t = f (Isul,Ik)'),   <,,+130.0
       2 :S := myTextBase.Get(S_2);             //<S_2='2   AIKAA VASTAAVA SULAKKEEN TOIMINTAVIRTA  Ik = f (Isul,t)'),
       3 :S := myTextBase.Get(S_3);             //<S_3='3   SULAKEFUNKTION VERTAILUPISTEIDEN ero% = dI/Itod x100'),
    else  S := myTextBase.Get(S_4);  END; //case   S_4='4   SULAKE-VIRTATAULUKKO  Ik = f (Isut,t)'),
{Aval  Sval:,,siis painikeNrot                  //<S_5='5   SULAKEFUNKTION TARKISTUSPISTEET 30ms - 15s, VIRHE%'),
  1     1 =1   Tiedetään  VIRTA,  => AIKA ?              <,,Tekstisijoitukset KAIKKI objInsp´ssa.
  2     2 =2   Tiedetään  AIKA,  => VIRTA ?
  3     3 =3   Tiedetään tod.laukaisuVIRTA +AIKA  =>  ero% ?
  4     4 =4   Tiedetään AIKA,  => VIRTA ? (Kaikki sulakekoot)
  -     5 =5   Sulakekäyrät:  IECgG,  IECdZ, OFAA(gG), OFAM(aM)  <''+130.0
  'Aval := ao.BtnClickissä. }
//,#################################################################################################
//  Caption := S; //<ChkR_n :n kokeilussa kommentoi tämäVex, muutenCaptioniin sijoitettu sq häviää! <<< {#}sq :=
//'#################################################################################################

    if (Sval in [1..3,4]) and NOT okSul(Isu)                 //<,,Korjat ed.Sval:n arvot ettei Herjainfo
       then Isu := {4}2;                                     //<130.0: 4=>2
    if (Sval in [1..3,4]) and (abs(Sftk)>50)
       then begin  if Sftk<-50  then Sftk := -50  else Sftk := 50;  end;
    if (Sval in [2..3,4])
      {then begin  if fSu_Sama (suCs,su_OFAg)
                   then begin  if Tk<0.01   then Tk := 0.01   else
                               if Tk>60     then Tk := 60;     end
                   else begin  if Tk<0.005  then Tk := 0.005  else
                               if Tk>200    then Tk := 200;    end;  end;   -2.0.1}
       then  if Tk<fTimAR/2                 //,,Sisennykset +10.0.1
             then Tk := fTimAR
             else if Tk>fTimYR*2
             then Tk := fTimYR;

//ss := ZS_Frm.ZS_StrGrid.Cells[0,3];
    ZS_SuTypCm.Text := suCs;                                 //130.0:  Suorat sijoitukset vaihdettu => sq => Text := sq, jotta debugissa näkyisi.
    case Sval of                                             //,,Syöttöikkunoihin arvot
       1 :begin ZS_Frm.ZS_Mm2Cm.Text := fImrkt0 (Isu, 1);
                if Ik>100
                   then sq :=   sRmrkt0vex(Ik,  1,0)  else
                if Ik>10
                   then sq :=   sRmrkt0vex(Ik,  1,1)
                   else sq :=   sRmrkt0vex(Ik,  1,2);
                ZS_Frm.ZS_LMed.Text := sq;
                ZS_Frm.{ZS_TMed}ZS_xMed.Text := sRmrkt0vex(Sftk,1,1);  end; //<130.1
       2 :begin ZS_Mm2Cm.Text := fImrkt0   (Isu, 1);
              //with ZS_LMed  do                               //<-130.0
                if Tk<0.1
                   then sq :=   sRmrkt0vex(Tk,  1,3)  else     //<+130.0 ,,Mahtaakohan toimia ?!?!?
                if Tk<1
                   then sq :=   sRmrkt0vex(Tk,  1,2)
                   else sq :=   sRmrkt0vex(Tk,  1,1);
                {ZS_TMed}ZS_xMed.Text :=   sRmrkt0vex(Sftk,1,1); //<130.1
              //ZS_SuTimCm.Hint := ZS_SuTimCm.Hint +fRP('SuTim*');  //<,+130.0 -130.1
                ZS_SuTimCm.Text := sq;  end;
       3 :begin ZS_Mm2Cm.Text := fImrkt0   (Isu, 1);
                with ZS_LMed  do
                if Ik>100
                   then Text :=   sRmrkt0vex(Ik,  1,0)  else
                if Ik>10
                   then Text :=   sRmrkt0vex(Ik,  1,1)
                   else Text :=   sRmrkt0vex(Ik,  1,2);
                with {ZS_TMed}ZS_SuTimCm  do                        //<130.1
                if Tk<0.1
                   then Text :=   sRmrkt0vex(Tk,  1,3)  else
                if Tk<1
                   then Text :=   sRmrkt0vex(Tk,  1,2)
                   else Text :=   sRmrkt0vex(Tk,  1,1);
                ZS_xMed.Text :=   sRmrkt0vex(Sftk,1,1);  end;
       5 : ;
    else  begin with {ZS_LMed}ZS_SuTimCm  do                        //<Sval=4  ,,130.1:  ZS_LMed => ZS_SuTimCm
                if Tk<0.1
                   then Text :=   sRmrkt0vex(Tk,  1,3)  else
                if Tk<1
                   then Text :=   sRmrkt0vex(Tk,  1,2)
                   else Text :=   sRmrkt0vex(Tk,  1,1);
                {ZS_TMed}ZS_xMed.Text :=   sRmrkt0vex(Sftk,1,1);    //<130.1
                if ZS_SuTimCm.Text=''  then ;
          end;
    end;{case}
  end;//with ZS_Frm
end;//asetaSval_Y_Txt
//===============================================================================================================
//function SeurLeft (Lbl :TLabel;  Box :TComboBoxXY) :real;      begin  result := Lbl.Left + Box.Width;  end;
procedure Sij_SuTypet_Lft;      begin;
  with ZS_Frm  do begin
    with ZS_SuTypLbl  do begin
    //Caption := myTextBase.Get(???);                      //<DEVELOPER2TextBase
      ZS_SuTypLbl.Left := ZS_TulostBtn.Left +ZS_TulostBtn.Width +7;
      Visible := true;  end;
    with ZS_SuTypCm  do begin
      ZS_SuTypCm.Left := ZS_SuTypLbl.Left+ZS_SuTypLbl.Width +1;
      Visible := true;
      TabOrder := 0;                                       //<0 =Tulee aktiiviseksi, kun frm avataan
     {Hint := myTextBase.Get(???);  }                      //<DEVELOPER2TextBase
      Items.Clear;       {su_OFAg su_OFAm   (su_IECg) su_IECgAR su_IECgYR   (su_IECd) su_IECdAR su_IECdYR}
      Items.Add (su_IECgYR);
      Items.Add (su_IECgAR);
      Items.Add (su_IECdYR);
      Items.Add (su_IECdAR);
      Items.Add (su_OFAg);
      Items.Add (su_OFAm);
      Visible := true;  end;
  end;
end;
//===============================================================================================================
procedure AddSul_Mm2Lbl_jaCm_Lft;      VAR s :string;  u :integer;      begin;
   with ZS_Frm  do
   with ZS_Mm2Cm do begin
    //-130.1 Hint := myTextBase.Get(S_6) +fRP('Mm2Com*');
      ShowHint := true;
      u := cIsuPit;
      ZS_Mm2Cm.Width := u;
      Visible := true;
      //ZS_SuTypCm
      Sij_SuTypet_Lft;  //<+130.1:  Lisätty koska Mm2Lbl_Sulake_Lft_AddSul korvattiin AddSul_Mm2Lbl_jaCm_Lft´llä.

      s := myTextBase.Get(S_16)+'  :';    //<S_16= "Sulake[A]"
      ZS_Mm2Lbl.Caption := s;
      ZS_Mm2Lbl.Left := ZS_SuTypCm.Left +ZS_SuTypCm.Width +7; //<130.1
      ZS_Mm2Cm.Left := ZS_Mm2Lbl.Left +ZS_Mm2Lbl.Width +2;    //<130.1
      ZS_Mm2Lbl.Visible := true;
      if fSu_PerusSama (ZS_SuTypCm.Text,su_IECd)  or  fSu_PerusSama (ZS_SuTypCm.Text,su_IECg)  or
         fSu_PerusSama (ZS_SuTypCm.Text,su_OFAg)  or  fSu_PerusSama (ZS_SuTypCm.Text,su_OFAm)  then begin
        TabOrder := 1;
        Items.Clear;
        Items.Add ('  2');
        Items.Add ('  4');
        Items.Add ('  6');
        Items.Add (' 10');
        Items.Add (' 16');
        Items.Add (' 20');
        Items.Add (' 25');
        Items.Add (' 32');
        Items.Add (' 40');
        Items.Add (' 50');
        Items.Add (' 63');
        Items.Add (' 80');
        Items.Add ('100'); //<''Tulppasulakkeilla vain 100 A :iin asti
        if fSu_PerusSama (ZS_SuTypCm.Text,su_IECg)  or  fSu_PerusSama (ZS_SuTypCm.Text,su_OFAg)  or
           fSu_PerusSama (ZS_SuTypCm.Text,su_OFAm)  then begin
          Items.Add ('125');
          Items.Add ('160');
          Items.Add ('200');
          Items.Add ('250');
          Items.Add ('315');
          Items.Add ('400');
          Items.Add ('500');
          Items.Add ('630');
          if fSu_PerusSama (suCs,su_IECg)  then begin
            Items.Add ('800');
            Items.Add ('1000');
            Items.Add ('1250');  end;
  end; end;//<if (fSu_Perus.., if..
  end;//with
//ZS_Frm.ZS_Mm2Cm.Text := fImrkt0 (Isu,1); //< +2.0.2 KOE ?????????????????????????????????????????????????????????????
end;//AddSul_Mm2Cm_Lft
//..........................................................
procedure Kaikki_LblBoxVis_Vex;      begin
  with ZS_Frm  do begin
     ZS_TypLbl.Visible := false;
     ZS_SuTypLbl.Visible := false;
     ZS_LLbl.Visible := false;
     ZS_TLbl.Visible := false;
     ZS_Mm2Lbl.Visible := false;
     ZS_xLbl.Visible := false;
     ZS_LaskeLbl.Visible := false;

     ZS_TypCm.Visible := false;
     ZS_SuTypCm.Visible := false;
     ZS_LMed.Visible := false;
     ZS_TMed.Visible := false;
     ZS_SuTimCm.Visible := false;
     ZS_Mm2Cm.Visible := false;
     ZS_xMed.Visible := false;
  end;
end;

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Sval=1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure asetaSval1;      VAR s :string;      begin
  fBxtNyt('asetaSval1');
  Kaikki_LblBoxVis_Vex;
  PutsInfoRvt;                         //<Tyhjätään alimmat inforivit
  with ZS_Frm  do begin
      InfoRivitCapt;
    with ZS_StrGrid  do begin
      RowCount := RowMax;              //<Asetetaan maxiin, jotta kaikki rivit näkyisi aina
      ColCount := fTutColCount (7);    //<,,MaxKäytössäolevan mukaan jottei jo olevat pyyhkiytyisi
      FixedCols := 3;                  //<Vois olla 3, mutta Sval=4 :llä tarvitaan kaikki -> kaikille sama = 1.
      FixedRows := 0;
    end;
  //Mm2Lbl_Sulake_Lft_AddSul;          //<Sij SuLbl+SuCom +Mm2Lbl+Mm2Com: Left,TabOrder 0-1,Hint,ShowHint,Visible
    AddSul_Mm2Lbl_jaCm_Lft;            //<Tämä korvaa edRvn Mm2Lbl_Sulake_Lft_AddSul´in.

    with ZS_LLbl  do begin                                        //,,Ik <= ZS_LMed.Text
      s := myTextBase.Get(S_15) + ' :';                           //<S_15 ="Ik [A]"
      ZS_Frm.ZS_LLbl.Caption := s;
      ZS_Frm.ZS_LLbl.Left := ZS_Frm.ZS_Mm2Cm.Left +ZS_Frm.ZS_Mm2Cm.Width +7;
      Visible := true;  end;
    with ZS_LMed  do begin                                        //<=Ik
      ZS_Frm.ZS_LMed.Left := ZS_Frm.ZS_LLbl.Left +ZS_Frm.ZS_LLbl.Width +1;
      ZS_Frm.ZS_LMed.Width := cIkPit;
      TabOrder := 2;
    //-130.1 ZS_Frm.ZS_LMed.Hint := myTextBase.Get(S_7) +fRP('ZS_LMed*');  //<S_7 = "Sulakkeen haluttu toimintavirta ajalla Aika[s]  (Ik>In)"
      ShowHint := true;
      Visible := true;  end;

      ZS_TLbl.Visible := false;
      ZS_TMed.Visible := false;
      ZS_SuTimCm.Visible := false;                                         //<''+130.0, 1

    with ZS_xLbl  do begin                                                 //<130.1:  TLbl => xLbl
      s := myTextBase.Get(S_17) + ' :';                                    //<S_17 = "Sft[%]"
      ZS_Frm.ZS_xLbl.Caption := s;
      ZS_Frm.ZS_xLbl.Left := ZS_Frm.ZS_LMed.Left +ZS_Frm.ZS_LMed.Width +7; //<130.0, 1
      Hint := fRP('ZS_xLbl*');
      ShowHint := true;
      Visible := true;  end;
    with {ZS_TMed}ZS_xMed  do begin                                        //<130.1
      ZS_Frm.ZS_xMed.Left := ZS_Frm.ZS_xLbl.Left +ZS_Frm.ZS_xLbl.Width +2;
      ZS_Frm.ZS_xMed.Width := cSftPit;
      TabOrder := 3;                                                       //,,DEVELOPER2TextBase
      Hint := 'Toimintapisteen siirto (kun sulakkeen toiminta-aika ajatellaan pysyvän vakiona):   '+
            '<0% = Vasemmalle =Ik pienenee,   >0% = Oikealle =Ik kasvaa.';//-130.1: +fRP('ZS_TMed*');//myTextBase.Get(S_8);
      ShowHint := true;
      Visible := true;  end;

    Sij_SftnJalkeen_LasBtn_jaAvustChk;
    asetaSval_Y_Txt;                    //<Vasta nyt voi testailla + sij. olet.arvoja
  end;//with ZS_Frm
end;//asetaSval1;
//--------------------------------------------------------------------------------------------------
procedure TS_PaaValFrm.S_IkTimBtnClick(Sender: TObject);      begin
   Aval := 1;                          //<Tieto valinnasta PRC ZS_Frm /MouseDown :lle
   jatkaMm2 := 0;
   S_IkTimBtn.Enabled := false;
   ohjaaSval;
   S_IkTimBtn.Enabled := true;
end;//S_IkTimBtnClick

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Sval=2 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure asetaSval2;      VAR LbCap,LbHnt{,BxHnt} :string;  {u :integer;}      begin //Aval=2/4. tänne.
  fBxtNyt('asetaSval2');
  Kaikki_LblBoxVis_Vex;
  with ZS_Frm  do begin
      InfoRivitCapt;
    with ZS_StrGrid  do begin
      RowCount := RowMax;              //<Asetetaan maxiin, jotta kaikki rivit näkyisi aina
      ColCount := fTutColCount (7);    //<,,MaxKäytössäolevan mukaan jottei jo olevat pyyhkiytyisi
      FixedCols := 3;                  //<Vois olla 3, mutta Sval=4 :llä tarvitaan kaikki -> kaikille sama = 1.
      FixedRows := 0;
    end;
                                       //,Sij SuLbl+SuCom +Mm2Lbl+Mm2Com: Left,TabOrder 0-1,Hint,ShowHint,Visible =Samoja kuin seur, joka nyt on korvaava.
    AddSul_Mm2Lbl_jaCm_Lft;            //<Tämä korvaa edRvn Mm2Lbl_Sulake_Lft_AddSul´in.

        LbCap := myTextBase.Get(S_18) + ' :';                        //<S_18 =Aika[s]
        LbHnt := '!';                                                //<"!" merkiksi, että fRePunKehiAjo´ssa Hint=ComPonName.
    COMX_JalkSij_Lbl_COMX (ZS_Mm2Cm, ZS_TLbl,LbCap,LbHnt, ZS_SuTimCm,3,LbHnt);
    if ZS_Frm.ZS_TLbl.Hint='1'  then ;
    if ZS_Frm.ZS_SuTimCm.Hint ='1'  then ;

      LbCap := myTextBase.Get(S_17) + ' :';                           //<S_17 =Sft [%]
      LbHnt := '!';                                                   //<"!" merkiksi, että fRePunKehiAjo´ssa Hint=ComPonName.
    COMX_JalkSij_Lbl_MEDI (ZS_SuTimCm, ZS_xLbl,LbCap,LbHnt, ZS_xMed,4,LbHnt);
    if ZS_Frm.ZS_xLbl.Hint='1'  then ;   if ZS_Frm.ZS_xMed.Hint ='1'  then ;

    Sij_SftnJalkeen_LasBtn_jaAvustChk;
    asetaSval_Y_Txt;                         //<Vasta nyt voi testailla + sij. olet.arvoja
  end;//with ZS_Frm
end;//asetaSval2;
//--------------------------------------------------------------------------------------------------
procedure TS_PaaValFrm.S_TimIkBtnClick(Sender: TObject);      begin //Aval=2/1. =Tänne ekax.
   Aval := 2;                          //<Tieto valinnasta PRC ZS_Frm /MouseDown :lle
   jatkaMm2 := 0;
   S_TimIkBtn.Enabled := false;
   ohjaaSval;
   S_TimIkBtn.Enabled := true;
end; {S_TimIkBtnClick}

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Sval=3 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure asetaSval3;      VAR LbCap,LbHnt,BxHnt :string;  {u :integer;}      begin
  fBxtNyt('asetaSval3');
  PutsInfoRvt;                         //<Tyhjätään alimmat inforivit
  Kaikki_LblBoxVis_Vex;
  with ZS_Frm  do begin
      InfoRivitCapt;
    with ZS_StrGrid  do begin
      RowCount := RowMax;              //<Asetetaan maxiin, jotta kaikki rivit näkyisi aina
      ColCount := fTutColCount (8);    //<,,MaxKäytössäolevan mukaan jottei jo olevat pyyhkiytyisi
      FixedCols := 3;                  //<Vois olla 3, mutta Sval=4 :llä tarvitaan kaikki -> kaikille sama = 1.
      FixedRows := 0;
    end;
                                       //,Sij SuLbl+SuCom +Mm2Lbl+Mm2Com: Left,TabOrder 0-1,Hint,ShowHint,Visible =Samoja kuin seur, joka nyt on korvaava.
    AddSul_Mm2Lbl_jaCm_Lft;            //<Tämä korvaa edRvn Mm2Lbl_Sulake_Lft_AddSul´in.
      LbCap := myTextBase.Get(S_22)+' :';                            //<S_22 =Itod.[A]
      LbHnt := '!';                                                  //<"!" merkiksi, että fRePunKehiAjo´ssa Hint=ComPonName.
      BxHnt := '!';
    COMX_JalkSij_Lbl_MEDI (ZS_Mm2Cm, ZS_LLbl,LbCap,LbHnt, ZS_LMed,2,BxHnt);
    if ZS_Frm.ZS_LLbl.Hint='1'  then ;   if ZS_Frm.ZS_LMed.Hint ='1'  then ;

        LbCap := myTextBase.Get(S_18) + ' :';                     //<S_18 =Aika[s]
        LbHnt := '!';                                             //<"!" merkiksi, että fRePunKehiAjo´ssa Hint=ComPonName.
    MEDI_JalkSij_Lbl_COMX (ZS_LMed, ZS_TLbl,LbCap,LbHnt, ZS_SuTimCm,3,LbHnt);
    if ZS_Frm.ZS_TLbl.Hint='1'  then ;
    if ZS_Frm.ZS_SuTimCm.Hint ='1'  then ;

      LbCap := myTextBase.Get(S_17) + ' :';                           //<S_17 =Sft [%]
      LbHnt := '!';                                                   //<"!" merkiksi, että fRePunKehiAjo´ssa Hint=ComPonName.
    COMX_JalkSij_Lbl_MEDI (ZS_SuTimCm, ZS_xLbl,LbCap,LbHnt, ZS_xMed,4,LbHnt);
    if ZS_Frm.ZS_xLbl.Hint='1'  then ;   if ZS_Frm.ZS_xMed.Hint ='1'  then ;

    Sij_SftnJalkeen_LasBtn_jaAvustChk;
    asetaSval_Y_Txt;                   //<Vasta nyt voi testailla + sij. olet.arvoja
  end;//with ZS_Frm
end;//asetaSval3;
//--------------------------------------------------------------------------------------------------
procedure TS_PaaValFrm.S_VrtBtnClick(Sender: TObject);      begin
   Aval := 3;                          //<Tieto valinnasta PRC ZS_Frm /MouseDown :lle
   jatkaMm2 := 0;
   S_VrtBtn.Enabled := false;
   ohjaaSval;
   S_VrtBtn.Enabled := true;
end; {S_VrtBtnClick}

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Sval=4 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure asetaSval4;      VAR LbCap,{LbHnt,}BxHnt :string; {u :integer;}      begin
  fBxtNyt('asetaSval4ed');
  PutsInfoRvt;                         //<Tyhjätään alimmat inforivit
  Kaikki_LblBoxVis_Vex;
  with ZS_Frm  do begin
      InfoRivitCapt;
    with ZS_StrGrid  do begin          //1=COL  0=ROW, =Eka col (0) jätetään tyhjksi
      RowCount := RowMax;              //<Asetetaan maxiin, jotta kaikki rivit näkyisi aina
      ColCount := fTutColCount (12);   //<,,MaxKäytössäolevan mukaan jottei jo olevat pyyhkiytyisi
      FixedCols := 1;                  //<Ei voi olla 3
      FixedRows := 0;
    end;
    Sij_SuTypet_Lft;
      LbCap := myTextBase.Get(S_18) + ' :';       //<S_18= "Aika[s]"
      BxHnt := 'Sulakkeen haluttu toiminta-aika (0.01 ... 100s ... 10000s OFAA, tarkkuusalue 0.005-200s, '+
               '20000s OFAA, IECdZ 0.1 ... 100s, tarkkuusalue 0.05-200s) virralla Ik[A].';
    COMX_JalkSij_Lbl_COMX (ZS_SuTypCm, ZS_LLbl,LbCap,'!', ZS_SuTimCm,2,BxHnt);
    if ZS_Frm.ZS_LLbl.Hint='1'  then ;   if ZS_Frm.ZS_SuTimCm.Hint ='1'  then ;

      LbCap := myTextBase.Get(S_17) + ' :';                           //<S_17 =Sft [%]
      BxHnt := '!';                                                   //<"!" merkiksi, että fRePunKehiAjo´ssa Hint=ComPonName.
    COMX_JalkSij_Lbl_MEDI (ZS_SuTimCm, ZS_xLbl,LbCap,BxHnt, ZS_xMed,3,BxHnt);
    if ZS_Frm.ZS_xLbl.Hint='1'  then ;   if ZS_Frm.ZS_xMed.Hint ='1'  then ;

    Sij_SftnJalkeen_LasBtn_jaAvustChk;
    asetaSval_Y_Txt;                                                  //<Vasta nyt voi testailla + sij. olet.arvoja  end;//with ZS_Frm
  end;//with ZS_Frm
end;//asetaSval4;
//--------------------------------------------------------------------------------------------------
procedure TS_PaaValFrm.S_IkTlkBtnClick(Sender: TObject);      begin
   Aval := 4;                               //<Tieto valinnasta PRC ZS_Frm /MouseDown :lle
   jatkaMm2 := 0;
   S_IkTlkBtn.Enabled := false;
   ohjaaSval;
   S_IkTlkBtn.Enabled := true;
end; {S_IkTlkBtnClick}
//--------------------------------------------------------------------------------------------------
procedure TS_PaaValFrm.FormShow(Sender: TObject);       begin //+130.0: jotta sain frmn pois Breakpoint listan päältä omassa käytössä.
  inherited;
   if fRePunKehi  then begin
      if (Left<1200)  then begin
         Left := Screen.Width -S_PaaValFrm.Width -100;  Top := 20;  end;
        {DetEv}DetEvFrm.HIDE;                                            //<+130.1
   end;
end;

procedure TS_PaaValFrm.KayraBtnClick(Sender: TObject);
begin
   jatkaMm2 := 0;
  Screen.Cursor := crHourGlass;             //<Ilman SCREENiä vipattaa!!!
   KayraBtn.Enabled := false;
   KayraFrm.Show;
   KayraBtn.Enabled := true;
  Screen.Cursor := crDefault;
end;

initialization
  suCs := su_IECgYR;  Isu := 6;  Ik := 26.8;{5s IECgG-yr 6A} {16.7;=5s/6A}   Tk := 5;  Sftk := 0;
end.

