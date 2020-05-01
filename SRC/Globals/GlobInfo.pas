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

unit GlobInfo; //1414: Ei onaa, aina error koska tätä ei saa luoduksi riittävän ajoissa, todettu.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Defs{1415f/exz};

type
  TClobInfoFrm = class(TForm)
    Rich1: TRichEdit;
    PanA: TPanel;
    SuljeBtn: TButton;
    TulostaBtn: TButton;
    TalletaBtn: TButton;
    SaveDlg: TSaveDialog;
    procedure SuljeBtnClick(Sender: TObject);
    procedure TulostaBtnClick(Sender: TObject);
    procedure TalletaBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClobInfoFrm: TClobInfoFrm;

implementation

{$R *.dfm}

procedure TClobInfoFrm.FormShow(Sender: TObject);   begin //1414
   Rich1.Lines.Add('Kukkuu uusi.');
end;

procedure TClobInfoFrm.SuljeBtnClick(Sender: TObject);      begin
   Close;
end;

procedure TClobInfoFrm.TalletaBtnClick(Sender: TObject);      VAR fn :string;   begin
   fn := Application.ExeName;
   fn := ExtractFilePath(fn) +'_Alv-pohja.txt';
   Rich1.PlainText := true;
   SaveDlg.FileName := fn;
   if SaveDlg.Execute  then//CfgFn
      Rich1.Lines.SaveToFile(SaveDlg.FileName);
end;

procedure TClobInfoFrm.TulostaBtnClick(Sender: TObject);      begin
   Rich1.Print('');
end;

end.

