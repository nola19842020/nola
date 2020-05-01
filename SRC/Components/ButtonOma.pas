unit ButtonOma;

interface

uses
  Windows, Messages, SysUtils, Classes, vcl.Graphics, vcl.Controls, vcl.Forms, vcl.Dialogs,
  vcl.StdCtrls;

type
  TButtonOma = class(TButton)
  private
  protected
  public
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;
  published
  end;

procedure Register;

implementation
//=====================================================================================================================

procedure Register;
begin
  RegisterComponents('Nola', [TButtonOma]);
end;

constructor TButtonOma.Create(Owner: TComponent);      begin
  inherited;
  Caption := 'OmaButton';
end;

destructor TButtonOma.Destroy;      begin
   inherited;
end;

end.
