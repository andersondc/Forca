program Forca;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {Form1},
  Perdeu in 'Perdeu.pas' {FPerdeu},
  Ganhou in 'Ganhou.pas' {FGanhou};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFPerdeu, FPerdeu);
  Application.CreateForm(TFGanhou, FGanhou);
  Application.Run;
end.
