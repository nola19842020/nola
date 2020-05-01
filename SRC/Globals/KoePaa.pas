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

unit KoePaa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RichEditNola, StdCtrls, ComCtrls;

type
  TKoePaaFrm = class(TForm)
    Rich2: TRichEdit;
    Rich1: TRichEditNola;
    procedure FormShow(Sender: TObject);
    procedure Rich1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Rich2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  KoePaaFrm: TKoePaaFrm;

implementation

uses PaaVal, Defs;

{$R *.DFM}

procedure TKoePaaFrm.FormShow(Sender: TObject);      begin
   //Rich2.Font.Name := 'MS Sans Serif';
   Rich1.Clear;
   //Rich1.Font.Name := 'Symbol'; //<Tätä ei tarvita, CharSet := SYMBOL_CHARSET sijoitus riittää.!!!!!!
   //Rich1.Font.CharSet := SYMBOL_CHARSET;//ANSI_CHARSET;
   Rich1.AddText ('A');
(* Rich1.AddText ('A<br>');
   Rich1.AddText (FONT_OMEGA +'<br>');
   Rich1.AddText ('<b>B</b><br>');
   Rich1.AddText (FONT_2JUURI +FONT_FII +FONT_FII1 +FONT_DELTAP +FONT_OIKEALLE);
   Rich1.AddText ('<b>Norm</b>Tekstiä<br>');

(*
   {Rich1.AddText ('<f n="Symbol" s="" c="">');
   {Rich1.AddText                          ('abcd<br>');
   Rich1.AddText ('<f n="Courier" s="" c="">abcd</f><br>');
   Rich1.AddText ('<f n="Symbol" s="" c="">A</f><br>');
   Rich1.AddText ('<f n="Symath" s="" c="">A</f><br>');}

   //Rich1.AddText ('<f n="MS Sans Serif" s="" c="">');
   Rich1.AddText ('<f n="MS Sans Serif">');
   Rich1.AddText ('abcde fghij klmno pqrst uvwxy zåäö<br>'+
                  'ABCDE GGHIJ KLMNO PQRST UVQXY ZÅÄÖ<br>');
   //Rich1.AddText ('<f n="Symbol" s="" c="">');
   //Rich1.AddText ('<f n="Symbol">');
   Rich1.AddText ('<f n="Symbol" s="" c="">');
   Rich1.AddText ('abcde fghij klmno pqrst uvwxy zåäö<br>'+
                  'ABCDE GGHIJ KLMNO PQRST UVQXY ZÅÄÖ<br>');
   {Rich1.AddText ('Tekstiä '+
                  'OMEGA='+FONT_OMEGA +' DELTA='+FONT_DELTA+' SIGMA='+FONT_SIGMA+' PII='+FONT_PII+' MYY='+FONT_MYY+
                  'DIV='+FONT_DIV     +' KAPPA='+FONT_KAPPA+' GAMMA='+FONT_GAMMA+' EETTA='+FONT_EETTA+' EPSIL='+FONT_EPSIL+
                  ' SIGMA1='+FONT_SIGMA1+' 2JUURI='+FONT_2JUURI+' FII='+FONT_FII+' FII1='+FONT_FII1+' DELTAP='+FONT_DELTAP+
                  ' OIKEALLE='+FONT_OIKEALLE +'Norm.');}
   =================================================================================================*)
   Rich1.SetFocus;
end;

procedure TKoePaaFrm.Rich1KeyDown(Sender: TObject;  var Key: Word;  Shift: TShiftState);      begin
   if (CharInSet(Chr(Key), ['P','p'])) and (ssCtrl IN Shift) and PaaValFrm.PrinterSetupDialog1.Execute
    //then PrintRichEditNolaSymbolText (SyoAv,SyottoAvFrm);
      then Rich1.Print('');
end;

procedure TKoePaaFrm.Rich2KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);      begin
   if (CharInSet(Chr(Key), ['P','p'])) and (ssCtrl IN Shift) and PaaValFrm.PrinterSetupDialog1.Execute
    //then PrintRichEditNolaSymbolText (SyoAv,SyottoAvFrm);
      then Rich2.Print('');
end;

end.
