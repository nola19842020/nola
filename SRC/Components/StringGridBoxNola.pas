unit StringGridBoxNola;
{ MouseDown avaa ao. Celliin ComboBoxXY :n jos BxOpen                                              //<,,RePu 22.10.2002

}
interface

uses
  Windows, Messages, SysUtils, Classes, vcl.Graphics, vcl.Controls, vcl.Forms, vcl.Dialogs,
  vcl.Grids, StringGridNola{Delphi5}, ComboBoxXY{RePu};

type
  TOnTopLeftChanged = procedure{(Sender: TObject) }of object;

  TStringGridBoxNola = class(TStringGridNola)
  private
    ComBx    :TComboBoxXY;
    FBxOpen  :boolean;
    FBxWidth    :integer;
    FBxFirstCol :integer;
    FBxLastCol  :integer;
{    Sar,Riv       :integer;
    xStrGr,yStrGr :double;}
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;
    procedure TopLeftChanged; override;
  published
    property BxOpen  :boolean  read FBxOpen  write FBxOpen;
    property BxWidth :integer  read FBxWidth write FBxWidth;
    property BxFirstCol :integer  read FBxFirstCol write FBxFirstCol;
    property BxLastCol  :integer  read FBxLastCol  write FBxLastCol;
    property OnTopLeftChanged;
  end;

procedure Register;

implementation
//=====================================================================================================================

procedure Register;
begin
  RegisterComponents('Nola', [TStringGridBoxNola]);
end;

{procedure piipit;      VAR i :integer;      begin
  for i := 1 to 1000  do beep;
end;}
constructor TStringGridBoxNola.Create(Owner: TComponent);      begin
  inherited;
   ComBx := TComboBoxXY.Create (Self); //<Ei avaa
   
// ComBx := TComboBoxXY.CreateParented (Self); //<Ei avaa
     //ComBx.TabOrder := 1;
// ComBx := inherited TComboBoxXY.Create (Self);
// ComBx := TComboBoxXY.Create (Self.Owner);
// ComBx.Parent := Owner.Parent;
// ComBx.Owner := Owner.Parent;

   ComBx.Visible := true;

// ComBx.Parent := Self.Parent; //Ei tunnista vielä, ilmeisesti formia, johon kompon. tulee, ei vielä ole luotu.
{  if ComBx.Parent = nil
   then beep
   else beep;}

// ComBx.SetFocus;              //<Aiheuttaa NolaForms.PAS :ssa herjan:  "Control has no parent window".
   FBxOpen := false;           //<Ei StringGridBoxNola.FBxOpen := ..
// beep;
end;

destructor TStringGridBoxNola.Destroy;      begin
   ComBx.Destroy;
   inherited;
end;

procedure TStringGridBoxNola.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      CONST BxMarg=10;//=Marginaali, joka pitää jäädä mahd. seur. sarakkeesee, jotta siihen mahtuu HIIRELLÄ KLIKKAAMAAN.

(* function fX_Col (X: Integer) :Integer;      VAR Coln,Rw :integer;      begin //<,,,OK, mutta ei ole tarvetta.
      MouseToCell (X, 1{Y}, Coln, Rw);
      result := Coln;   end;
   function fY_Row (Y: Integer) :Integer;      VAR Coln,Rw :integer;      begin
      MouseToCell (1{X}, Y, Coln, Rw);
      result := Rw;   end; a*)

   function fCol_X :Longint;      VAR X :Longint;  qRect :TRect;      begin
      qRect := CellRect (Col,Row);
      X := qRect.Left;
      result := X;  end;
   function fRow_Y :Longint;      VAR Y :Longint;  qRect :TRect;      begin
      qRect := CellRect (Col,Row);
      Y := qRect.Top;
      result := Y;  end;

   function fWkorj :integer;      VAR Wkorj,Wbx :integer;      begin
      Wkorj := 0;  if GridLineWidth > 0  then Wkorj := 1; //<,,Boxin leveyden hienosäätöä. BxWidth on näköjään
      Wbx := 4 +Wkorj;                                    //   muuten 4 pix lyhyempi kuin ColWidth, TODETTU !!
      result := Wbx;  end;

begin
   inherited;
   if FBxOpen
   then begin
              //ColWidths[0] := 80;  ColWidths[1] := 80;  ColWidths[2] := 60;  ColWidths[3] := 30;  ColWidths[4] := 20;
        ComBx.Width := 50;  ComBx.Height := DefaultRowHeight +GridLineWidth;
        ComBx.Left := Left +fCol_X;// +GridLineWidth;
        ComBx.Top :=  Top  +fRow_Y;// +GridLineWidth;
        if ComBx.Parent = nil  //<,Muuten SetFocus aiheuttaa Forms.PAS :ssa herjan:  "Control '' has no parent window".
           then ComBx.Parent := Self.Parent;
        //if FBxFirstCol=nil  then           //<Ei worki = ei kerro tilannetta.
          if FBxFirstCol<0  then             //<,,Tarkistetaan onko arvot jo olemassa = asetetaan jos eioo.
             FBxFirstCol := FixedCols;
        //if FBxLastCol=nil  then            //<Ei worki = ei kerro tilannetta.
          if FBxLastCol>ColCount -1     then
             FBxLastCol := ColCount -1  else
          if FBxLastCol<FBxFirstCol     then
             FBxLastCol := FBxFirstCol;
        if Col IN [FBxFirstCol .. FBxLastCol]  then begin
           if BxWidth +fWkorj < ColWidths[Col]
           then BxWidth := ColWidths[Col] +fWkorj
           else if (Col<=ColCount -2) and (BxWidth +fWkorj > ColWidths[Col] +ColWidths[Col+1] -BxMarg)
           then BxWidth := ColWidths[Col] +ColWidths[Col+1] +fWkorj -BxMarg;

           FBxWidth := BxWidth;
           ComBx.Width := FBxWidth;
           ComBx.Visible := true;
           ComBx.SetFocus;  end
        else
           ComBx.Visible := false;
   end//if FBxOpen
   else ComBx.Visible := false;
                              {Cells[0,0] := 'x' +IntToStr(x) +' y' +IntToStr(y);
                             //Cells[0,1] := 'c' +IntToStr(fX_Col (X)) +' r' +IntToStr(fY_Row (Y));
                               Cells[0,2] := 'bx' +IntToStr(ComBx.Left) +' by' +IntToStr(ComBx.Top);
                               Cells[0,3] := 'bxw' +IntToStr(BxWidth);
                               Cells[0,4] := 'col=' +IntToStr(Col) +' wCo'+IntToStr(ColWidths[Col]);//}
end;

procedure TStringGridBoxNola.TopLeftChanged;      begin
   inherited;
   if Assigned(OnTopLeftChanged) then
      OnTopLeftChanged(self);
   ComBx.Visible := false;
end;

initialization

end.

