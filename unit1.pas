unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

  type
  myForm = record
    Left: integer;
    Top: integer;
    Height: integer;
    Width: integer;
    Caption: string[100];
    Checked: boolean;
    wsMax: boolean;
  end;

var
  Form1: TForm1;
  MyF: myForm;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
   if Edit1.Text <> '' then Form1.Caption:= Edit1.Text;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
  var
     f: file of myForm;
begin
  if not (Form1.WindowState = wsMaximized) then begin
    MyF.Left:= Form1.Left;
    MyF.Top:= Form1.Top;
    MyF.Height:= Form1.Height;
    MyF.Width:= Form1.Width;
    MyF.wsMax:= False;
  end
  else MyF.wsMax:= True;
  MyF.Caption:= Form1.Caption;
  MyF.Checked:= CheckBox1.Checked;
  try
    AssignFile(f, 'MyProg.dat');
    Rewrite(f);
    Write(f, MyF);
  finally
    CloseFile(f);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
  var
  f: file of myForm;
begin
  if not FileExists('MyProg.dat') then exit;
  try
    AssignFile(f, 'MyProg.dat');
    Reset(f);
    Read(f, MyF);
  finally
    CloseFile(f);
  end;
  if MyF.wsMax then Form1.WindowState:= wsMaximized
  else begin
    Form1.Left:= MyF.Left;
    Form1.Top:= MyF.Top;
    Form1.Height:= MyF.Height;
    Form1.Width:= MyF.Width;
  end;
  Form1.Caption:= MyF.Caption;
  CheckBox1.Checked:= MyF.Checked;
end;

end.

