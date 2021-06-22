unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, StrUtils, Perdeu, Ganhou,
  Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Imagem: TImage;
    Label1: TLabel;
    LetrasUsadas: TListBox;
    ListaPalavrasJogo: TListBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListLetras: TListBox;
    lPalavra: TLabel;
    PalavraFinal: TListBox;
    Pimg: TPanel;
    i0: TImage;
    i1: TImage;
    i3: TImage;
    i4: TImage;
    i5: TImage;
    i6: TImage;
    i2: TImage;
    vPalavra: TEdit;
    vTentativa: TEdit;
    procedure vTentativaChange(Sender: TObject);
    procedure vPalavraChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure vTentativaKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ConfereLetras;
    procedure Zerar;
    procedure GeraPalavra;
    procedure MontaPalavra;
    Function SoLetra(Texto: String):Boolean;
  end;

var
  Form1: TForm1;
  auxTent: integer;

implementation

{$R *.dfm}

procedure TForm1.FormResize(Sender: TObject);
begin
  Label1.Left:=258;
  vTentativa.Left:=321;
  lPalavra.Left:=225;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  auxTent:=0;
  GeraPalavra;
end;

procedure TForm1.vPalavraChange(Sender: TObject);
var
  i: integer;
begin
{  ListLetras.Clear;
  lPalavra.Caption:=DupeString('_ ',length(vPalavra.Text));

  for i:=0 to Length(vPalavra.Text)-1 do
  begin
    ListBox2.Items.Add('_ ');
    ListLetras.Items.Add(leftStr(RightStr(trim(vPalavra.Text),length(vPalavra.Text)-i),1));
  end;
}
end;

procedure TForm1.MontaPalavra;
var
  i: integer;
begin
  ListLetras.Clear;
  lPalavra.Caption:=DupeString('_ ',length(vPalavra.Text));

  for i:=0 to Length(vPalavra.Text)-1 do
  begin
    ListBox2.Items.Add('_ ');
    ListLetras.Items.Add(leftStr(RightStr(trim(vPalavra.Text),length(vPalavra.Text)-i),1));
  end;
end;

procedure TForm1.Zerar;
begin
  PalavraFinal.Clear;
  ListLetras.Clear;
  vPalavra.Clear;
  LetrasUsadas.Clear;
  ListBox1.Clear;
  ListBox2.Clear;
  auxTent:=0;

  vTentativa.Text:='';
  imagem.Picture:=i0.Picture;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if SoLetra(lPalavra.Caption)=true then ShowMessage('so letra')
  else showmessage('nao tem so letra');

end;

procedure TForm1.ConfereLetras;
var
  Palavra: string;
  Letra: string;
  i: integer;
  j: integer;
  k: integer;

  PalavraAux: string;
begin
  PalavraFinal.Clear;

  for i:=0 to ListLetras.Items.Count-1 do
  begin
    if LetrasUsadas.Items.IndexOf(ListLetras.Items.Strings[i])>-1 then
      PalavraFinal.Items.Add(ListLetras.Items.Strings[i])
    else
      PalavraFinal.Items.Add('_');
  end;
end;

procedure TForm1.GeraPalavra;
var
  ver: integer;
begin
  ver:=random(23);
  vPalavra.Text:=ListaPalavrasJogo.Items.Strings[ver];
  MontaPalavra;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.vTentativaChange(Sender: TObject);
var
  Palavra: string;
  Letra: string;
  i: integer;
  j: integer;
  k: integer;

  PalavraAux: string;
begin
  if SoLetra(lPalavra.Caption) then
  begin
    sleep(2000);
    Ganhou.FGanhou.ShowModal;
    Zerar;
    GeraPalavra;
  end;

  if Length(vTentativa.Text)=0 then exit;

  if Length(trim(vTentativa.Text))>0 then
    LetrasUsadas.Items.Add(vTentativa.Text);

  if ListLetras.Items.IndexOf(trim(vTentativa.Text))<0 then
    auxTent:=auxTent+1;

  ConfereLetras;
  lPalavra.Caption:='';

  for i:=0 to PalavraFinal.Items.Count-1 do
  begin
    lPalavra.Caption:=lPalavra.Caption+PalavraFinal.Items.Strings[i]+' ';
  end;

  if auxTent=0 then
    Imagem.Picture:=i0.Picture;
  if auxTent=1 then
    Imagem.Picture:=i1.Picture;
  if auxTent=2 then
    Imagem.Picture:=i2.Picture;
  if auxTent=3 then
    Imagem.Picture:=i3.Picture;
  if auxTent=4 then
    Imagem.Picture:=i4.Picture;
  if auxTent=5 then
    Imagem.Picture:=i5.Picture;
  if auxTent=6 then
  begin
    Imagem.Picture:=i6.Picture;
    sleep(2000);
    Perdeu.FPerdeu.ShowModal;
    Zerar;
    GeraPalavra;
  end;

  vTentativa.Text:='';
  vTentativa.SetFocus;
end;

procedure TForm1.vTentativaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key:=#0;
    exit;
  end;
end;

Function TForm1.SoLetra(Texto: String):Boolean;
var Resultado:Boolean;
    nContador:Integer;
begin
  Texto:=StringReplace(Texto, ' ', '',
   [rfReplaceAll, rfIgnoreCase]);

  Resultado := true;

  For nContador:=1 to Length(Texto) do
    begin
      {Verifica sé é uma letra}
      if Texto[nContador] in ['a'..'z','A'..'Z'] then
      else
         Resultado := false;
    end;

    Result:=Resultado;
end;

end.
