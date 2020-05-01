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

//Ks. pudostusvalikkolista:  (EdvNjAs.INC) Object Inspector
unit Z_PaaVal;

interface

uses
  Globals, Settings, Defs,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, NolaForms{, Koe};

type
  TZ_PaaValFrm = class(TFormNola)
    Z_PaaValBtn: TButton;
    Z_TyypBtn: TButton;
    Z_mm2Btn: TButton;
    Z_RakennBtn: TButton;
    Z_A2Btn: TButton;
    Z_PaaValLbl: TLabel;
    Z_TyypLbl: TLabel;
    Z_mm2Lbl: TLabel;
    Z_RakenLbl: TLabel;
    Z_A2lbl: TLabel;
    procedure Z_PaaValBtnClick(Sender: TObject);
    procedure Z_A2BtnClick(Sender: TObject);
    procedure Z_RakennBtnClick(Sender: TObject);
    procedure Z_mm2BtnClick(Sender: TObject);
    procedure Z_TyypBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Z_PaaValFrm: TZ_PaaValFrm;
  L,T,mm2,uT{+130.2e} :Real;
  Ktyp :String;
  procedure ohjaaZval;                     //<Tässä unitissa, =jotta ZS_ -unit tunnistaisi
  function Aok (aa2 :integer) :boolean;    //<NolaZ.INC :ssä, =jotta ZS_ unit tunnistaisi
  procedure asetaZval1_LftVis;
  procedure asetaZval2;

implementation
                                      //,Tässä PAAVAL, koska siellä FNC Demo:B;, jota käytetään yleis.
uses PaaVal{+},Y_, Unit0, Z_A2, ZS_, SyottoAv, TextBaseTexts,  // TÄSSÄ UNITissa kutsutaan + asetellaan.
     LaskeeOd{+6.2.2}, InfoDlgUnit{+6.2.2};
{$R *.DFM}

{$I '..\impedanssi\NOLAZ.INC'}


procedure TZ_PaaValFrm.Z_PaaValBtnClick(Sender: TObject);
begin
  Close;  Z_A2Frm.Close;  ZS_Frm.Close;
end;
//===============================================================================================================
procedure Z_A2Rich_Asetukset;    begin
  Screen.Cursor := crHourGlass;             //<Ilman SCREENiä vipattaa!!!
  with Z_A2Frm do begin
    Close;                 //<Ettei Richin ollessa päälle uusnäpäytys toisi valikkoa päälle
    Z_A2Rich.Clear;
    Z_A2Rich.PlainText := False; // RTF-format
    Z_A2Rich.Visible := true;
    (*  Z_A2Koko8.Enabled := false;             //<Ettei tuu ikuinen silmukka???
        Z_A2Koko10.Enabled := false;            //<-"-
        if NOT Z_A2Koko8.Checked and NOT Z_A2Koko10.Checked  then Z_A2Koko10.Checked := true;
        Z_A2Koko8.Enabled := true;
        Z_A2Koko10.Enabled := true;
        if Z_A2Koko10.Checked  then Z_A2Rich.Font.Size := 10
                               else Z_A2Rich.Font.Size := 8;*)
    (*  Z_A2Rich.Font.Name := 'Courier New';*)
  end;//with
end;
//===============================================================================================================
procedure ohjaaZval;      begin
   Pval := 1;                                         //<Pitää ajan tasalla, jos välillä Z_val/S_val
   if Aval=1  then K_typ
              else tulA (mm2);
   tarkistColCount;   //<Tutkii ja asettaa max.ColCountin niin, ettei kapeamman Gridin GridLinet näy harmaana osana
   topAlimmanMuk;
   ZS_Frm.Show;
end;//ohjaaZval
//===============================================================================================================
procedure asetaZval_;      begin
  with ZS_Frm  do begin
    {if Zval=1  then Caption := myTextBase.Get(ZS_1)  //<"1 Impedanssikomponentit kaapelityypin mukaan.."
                else Caption := myTextBase.Get(ZS_2); //<"2 Kaapelityypit saman poikkipinnan mukaan, imped"}

     ZS_LMed.Text := sRmrkt0vex(L, 1,1);              //<L :n MaskEditiin arvo
     ZS_TMed.Text := sRmrkt0vex(T, 1,1);              //<T :n MaskEditiin arvo
     with ZS_Frm.ZS_Mm2Cm  do
          if mm2<4  then Text := sRmrkt0vex(mm2, 1,1)      //<mm2 :n ComboBoxiin arvo
                    else Text := fImrkt0 (trunc(mm2), 1);
     ZS_TypCm.Text := Ktyp;                                //<Typ :n ComboBoxiin arvo
  end;//with
end;//asetaZval_
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Zval=1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure asetaZval1_LftVis;      begin
  ZS_Frm.ZS_StrGrid.ColCount := fTutColCount (19);    //<,,MaxKäytössäolevan mukaan jottei jo olevat pyyhkiytyisi
  ZS_Frm.ZS_StrGrid.RowCount := RowMax;
  ZS_Frm.ZS_StrGrid.FixedCols := 1;    //<S_ saattoi asettaa 0 :ksi
  ZS_Frm.ZS_StrGrid.FixedRows := 0;    //<S_ Asetti 1 :ksi
  with ZS_Frm  do begin
    with ZS_LLbl  do begin
      ZS_Frm.ZS_LLbl.Caption := myTextBase.Get(ZS_3);                 //<"L [m]"
      ZS_Frm.ZS_LLbl.Left := ZS_Frm.ZS_TulostBtn.Left +ZS_Frm.ZS_TulostBtn.Width +10;
      ZS_Frm.ZS_LLbl.Visible := true;  end;
    with ZS_LMed  do begin
      ZS_Frm.ZS_LMed.Left := ZS_Frm.ZS_LLbl.Left +ZS_Frm.ZS_LLbl.Width +1;
      ZS_Frm.ZS_LMed.Width := 53;
      TabOrder := 0;
      ZS_Frm.ZS_LMed.Hint := myTextBase.Get(ZS_4);
      ShowHint := true;
      ZS_Frm.ZS_LMed.Visible := true;  end;
    with ZS_TLbl  do begin
      ZS_Frm.ZS_TLbl.Caption := myTextBase.Get(ZS_5);
      ZS_Frm.ZS_TLbl.Left := ZS_Frm.ZS_LMed.Left +ZS_Frm.ZS_LMed.Width +10;
      ZS_Frm.ZS_TLbl.Visible := true;  end;
    with ZS_TMed  do begin
      ZS_Frm.ZS_TMed.Left := ZS_Frm.ZS_TLbl.Left +ZS_Frm.ZS_TLbl.Width +1;
      ZS_Frm.ZS_TMed.Width := 34;
      TabOrder := 1;
      ZS_Frm.ZS_TMed.Hint := myTextBase.Get(ZS_6);
      ShowHint := true;
      ZS_Frm.ZS_TMed.Visible := true;  end;

    ZS_Mm2Lbl.Visible := false;             //<Nämä nyt vex
    ZS_Mm2Cm.Visible := false;             //< - " -
    with ZS_TypLbl  do begin                //<...ja tämä tilalle
      ZS_Frm.ZS_TypLbl.Caption := myTextBase.Get(ZS_7);
      ZS_Frm.ZS_TypLbl.Left := ZS_Frm.ZS_TMed.Left +ZS_Frm.ZS_TMed.Width +10;
      Visible := true;  end;
    with ZS_TypCm  do begin
      ZS_Frm.ZS_TypCm.Left := ZS_Frm.ZS_TypLbl.Left +ZS_Frm.ZS_TypLbl.Width +1;
      TabOrder := 2;
      ZS_Frm.ZS_TypCm.Visible := true;  end;

    with ZS_LaskeLbl  do begin
      Visible := false;                           //<"Sottaa ruutua vähemmän, jos vanha sij. vex
      ZS_Frm.ZS_LaskeLbl.Left := ZS_Frm.ZS_TypCm.Left +ZS_Frm.ZS_TypCm.Width +3;
      ZS_Frm.ZS_LaskeLbl.Visible := true;  end;
    with ZS_LaskeBtn  do begin
      ZS_Frm.ZS_LaskeBtn.Visible := false;                           //<"Sottaa ruutua vähemmän, jos vanha sij. vex
      ZS_Frm.ZS_LaskeBtn.Left := ZS_Frm.ZS_LaskeLbl.Left +ZS_Frm.ZS_LaskeLbl.Width +2;
      ZS_Frm.ZS_LaskeBtn.Hint := myTextBase.Get(ZS_8);
      TabOrder := 3;
      ShowHint := true;
      ZS_Frm.ZS_LaskeBtn.Visible := true;  end;

    with ChkBxAv  do begin
      Visible := false;                           //<"Sottaa ruutua vähemmän, jos vanha sij. vex
      Left := ZS_LaskeBtn.Left+ZS_LaskeBtn.Width +15;
      Visible := true;  end;

    ZS_Frm.ZS_SuTypLbl.Visible := false;
    ZS_Frm.ZS_SuTypCm.Visible := false;
  end;{with}

  asetaZval_;
end;//asetaZval1_LftVis
//--------------------------------------------------------------------------------------------------
procedure TZ_PaaValFrm.Z_TyypBtnClick(Sender: TObject);      begin
  Screen.Cursor := crHourGlass;
  Aval := 1;                           //<Tieto valinnasta ZS_LaskeBtnClick :lle
  jatkaMm2 := 0;
   Z_TyypBtn.Enabled := true;
  ohjaaZval;
   Z_TyypBtn.Enabled := true;
  Screen.Cursor := crDefault;
end;//Z_TyypBtnClick
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Zval=2 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure asetaZval2;      begin
  ZS_Frm.ZS_StrGrid.ColCount := fTutColCount (19);    //<,,MaxKäytössäolevan mukaan jottei jo olevat pyyhkiytyisi
  ZS_Frm.ZS_StrGrid.RowCount := RowMax;
  ZS_Frm.ZS_StrGrid.FixedCols := 1;    //<S_ saattoi asettaa 0 :ksi
  ZS_Frm.ZS_StrGrid.FixedRows := 0;    //<S_ Asetti 1 :ksi
  with ZS_Frm  do begin
    with ZS_LLbl  do begin
      Caption := myTextBase.Get(ZS_3);
      Left := ZS_TulostBtn.Left+ZS_TulostBtn.Width +10;
      Visible := true;  end;
    with ZS_LMed  do begin
      Left := ZS_LLbl.Left+ZS_LLbl.Width +1;
      ZS_Frm.ZS_LMed.Width := 53;
      TabOrder := 0;
      Hint := myTextBase.Get(ZS_4);
      ShowHint := true;
      Visible := true;  end;

    with ZS_TLbl  do begin
      Caption := myTextBase.Get(ZS_5);
      Left := ZS_LMed.Left+ZS_LMed.Width +10;
      Visible := true;  end;
    with ZS_TMed  do begin
      Left := ZS_TLbl.Left+ZS_TLbl.Width +1;
      ZS_Frm.ZS_TMed.Width := 34;
      TabOrder := 1;
      Hint := myTextBase.Get(ZS_6);
      ShowHint := true;
      Visible := true;  end;

    ZS_TypLbl.Visible := false;             //<Nämä nyt vex
    ZS_TypCm.Visible := false;              //< - " -
    with ZS_Mm2Lbl  do begin                //<..ja tämä tilalle
      Caption := myTextBase.Get(ZS_9);
      Left := ZS_TMed.Left+ZS_TMed.Width +10;
      Visible := true;  end;
    with ZS_Mm2Cm  do begin
      Left := ZS_Mm2Lbl.Left+ZS_Mm2Lbl.Width +1;
      ZS_Frm.ZS_Mm2Cm.Width := 55;
      Hint := myTextBase.Get(ZS_10);
      ShowHint := True;
      Items.Clear;
      Items.Add ('1.5');
      Items.Add ('2.5');
      Items.Add ('  6');
      Items.Add ('10');
      Items.Add ('16');
      Items.Add ('21');
      Items.Add ('25');
      Items.Add ('34');
      Items.Add ('35');
      Items.Add ('50');
      Items.Add ('54');
      Items.Add ('70');
      Items.Add ('85');
      Items.Add ('95');
      Items.Add ('120');
      Items.Add ('150');
      Items.Add ('185');
      Items.Add ('240');
      Items.Add ('300');
      Items.Add ('600');
      Items.Add ('800');
      Items.Add ('900');
      Items.Add ('1200');
      Items.Add ('1600');
      Items.Add ('2400');
      Items.Add ('3200');
      Items.Add ('Kaikki'); //<+6.2.2
      TabOrder := 2;
      Visible := true;  end;

    with ZS_LaskeLbl  do begin                    //< "=>"
      Visible := false;                           //<"Sottaa ruutua vähemmän, jos vanha sij. vex
      Left := ZS_Mm2Cm.Left+ZS_Mm2Cm.Width +3;
      Visible := true;  end;
    with ZS_LaskeBtn  do begin
      Visible := false;                           //<"Sottaa ruutua vähemmän, jos vanha sij. vex
      Left := ZS_LaskeLbl.Left+ZS_LaskeLbl.Width +2;
      Hint := myTextBase.Get(ZS_8);
      ShowHint := true;
      Visible := true;  end;

    with ChkBxAv  do begin
      Visible := false;                           //<"Sottaa ruutua vähemmän, jos vanha sij. vex
      Left := ZS_LaskeBtn.Left+ZS_LaskeBtn.Width +15;
      Visible := true;  end;

    ZS_SuTypLbl.Visible := false;
    ZS_SuTypCm.Visible := false;
    ZS_TypLbl.Visible := false;
    ZS_TypCm.Visible := false;
    ZS_xLbl.Visible :=  false;
    ZS_xMed.Visible :=  false;
  end;{with ZS_Frm}

  asetaZval_;
end;//asetaZval2
//--------------------------------------------------------------------------------------------------
procedure TZ_PaaValFrm.Z_mm2BtnClick(Sender: TObject);      begin
  Screen.Cursor := crHourGlass;
  Aval := 2;                           //<Tieto valinnasta ZS_LaskeBtnClick :lle
   Z_mm2Btn.Enabled := false;
  ohjaaZval;
   Z_mm2Btn.Enabled := true;
  Screen.Cursor := crDefault;
end;//Z_mm2BtnClick
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Zval=3 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure TZ_PaaValFrm.Z_RakennBtnClick(Sender: TObject);
var
   fileName, installDir: string;
begin
  Screen.Cursor := crHourGlass;
  SyottoAvFrm.Hide;
  Zval := 3;                           //<Tieto valinnasta ZS_LaskeBtnClick :lle. 3,4 ei tarvita ?
   jatkaMm2 := 0;
  Z_RakennBtn.Enabled := false;
  Z_A2Rich_Asetukset;
  Z_A2Frm.Z_A2TulostBtn.Hint := myTextBase.Get(ZS_11);
  Z_A2Frm.Z_A2TulostBtn.ShowHint := true;
//Z_A2Frm.Caption := myTextBase.Get(ZS_12);

  {DEVELOPER2 BEGIN}
  installDir := myRegSettings.GetStringValue(SETTINGS_USED, PROGRAM_DIR_ID);
  fileName :=   myRegSettings.GetStringValue(SETTINGS_USED, NOLAZ_KAAPRAK_FILE_ID);
   Z_A2Frm.Z_A2Rich.PlainText := false; //<Ettei muotoiluMRKT näkyisi.  +5.0.0
                    {Z_A2Frm.Z_A2Rich.Clear;               //<,,Teksti tuli näkyviin muotoiluMRKein, ei vaikutusta.
                     Z_A2Frm.Z_A2Rich.AddText ('XXX');
                     Z_A2Frm.Show;
                     MessageDlg ('?', mtInformation, [mbOK], 0);}
                  //   Z_A2Frm.Z_A2Rich.Clear;
  {DEVELOPER2 END}
  // try Z_A2Frm.Z_A2Rich.Lines.LoadFromFile('C:\Projektit\NolaINC\NOLAZ1.RTF');        //,+130.0:  ajovirhe koska näkyi vain ..BIN: installDir => gAjoConfPath
  try Z_A2Frm.Z_A2Rich.Lines.LoadFromFile({installDir}gAjoConfPath + fileName);         //<,Teksti tuli näkyviin muotoiluMRKein,
      Z_A2Frm.Z_A2Rich.Lines.LoadFromFile({installDir}gAjoConfPath + fileName);         //  2.lataus korjaa, TODETTU.##########
      //try with Z_A2Frm.Z_A2Rich.Lines do begin  //Oli OK
      //Z_A2Frm.Visible := true;                  //<SHOW ei workkinut RichEdit:ssä
      Z_A2Frm.Show;
      //Z_A2Frm.Z_A2Rich.Show;                    //< -5.0.0
  finally Screen.Cursor := crDefault;
  end;
  Z_RakennBtn.Enabled := true;
  Screen.Cursor := crDefault;
end;//TZ_PaaVal.Z_RakennBtnClick
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Zval=4 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
procedure TZ_PaaValFrm.Z_A2BtnClick(Sender: TObject);
var
   fileName, installDir: string;
begin                          //RichEdit !!!!!!!!!!!!!
  Screen.Cursor := crHourGlass;
  (*Z_A2Frm.Close;         //<Ettei Richin ollessa päälle uusnäpäytys toisi valikon päälle
  Z_A2Frm.Z_A2TulostBtn.Hint := 'Tulostaa koko tiedoston = A4 x3';
  Z_A2Frm.Z_A2TulostBtn.ShowHint := true;
{  Z_A2Rich_Asetukset;}
  Z_A2Frm.Z_A2Rich.PlainText := False; // RTF-format
  Z_A2Frm.Z_A2Rich.Visible := true;
  Z_A2Frm.Z_A2Rich.Lines.LoadFromFile('C:\Projektit\NolaINC\NOLAZ1.RTF');
  Z_A2Frm.Show;
  Z_A2Frm.Z_A2Rich.Show;   //Tässä järjestyksessä kokeiltu =OK*)


  Z_A2Btn.Enabled := false;
  SyottoAvFrm.Hide;
  Zval := 4;                           //<Tieto valinnasta ZS_LaskeBtnClick :lle. 3,4 ei tarvita ?
   jatkaMm2 := 0;
  Z_A2Rich_Asetukset;
  Z_A2Frm.Z_A2TulostBtn.Hint := myTextBase.Get(ZS_13);
  Z_A2Frm.Z_A2TulostBtn.ShowHint := true;
//Z_A2Frm.Caption := myTextBase.Get(ZS_14);

  {DEVELOPER2 BEGIN}
  installDir := myRegSettings.GetStringValue(SETTINGS_USED, PROGRAM_DIR_ID);
  fileName :=   myRegSettings.GetStringValue(SETTINGS_USED, NOLAZ_A2_MAARAYKSET_FILE_ID);
  {DEVELOPER2 END}
  installDir := gAjoConfPath;                                             //<130.0:  Herja: Cannot open file...,, koska yritti gAjoPath´ista lukea.
  // try Z_A2Frm.Z_A2Rich.Lines.LoadFromFile('C:\Projektit\NolaINC\NOLAZ2.RTF');
  try Z_A2Frm.Z_A2Rich.Lines.LoadFromFile(installDir + fileName);         //<,Teksti tuli näkyviin muotoiluMRKein,
      Z_A2Frm.Z_A2Rich.Lines.LoadFromFile(installDir + fileName);         //  2.lataus korjaa, TODETTU.##########
                   //Z_A2Frm.Z_A2Rich.Font.Size := 10;    //<Ei muuta kokoa, joka asetettu WP:ssä
      Z_A2Frm.Z_A2Rich.Refresh;
      Z_A2Frm.Show;
      Z_A2Frm.Z_A2Rich.Show;
                                    {Z_A2Frm.Z_A2Rich.Lines[2] := '!>>>>>>>>>>'+
                                    '  PRNw='+IntToStr(Printer.PageWidth)+
                                    '  PRNh='+IntToStr(Printer.PageHeight); //=2326,3389}
  finally Screen.Cursor := crDefault;
  end;
  Z_A2Btn.Enabled := true;
end;//TZ_PaaVal.Z_A2BtnClick

initialization
  L := 1000;  T := 20{80}; { IF Demö  THEN T := 20; }
  mm2 := 70;  Ktyp := 'MMJ/MMK*';
end.

