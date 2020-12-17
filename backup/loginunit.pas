unit LoginUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  RegisterUnit, InfoUnit, odbcconn, sqldb, db;

type

  { TLogin }

  TLogin = class(TForm)
    DataSource1: TDataSource;
    img_info: TImage;
    img_exit: TImage;
    img_login: TImage;
    Label_exit: TLabel;
    Label_register: TLabel;
    Label_retail: TLabel;
    Label_username: TLabel;
    Label_password: TLabel;
    ODBCConnection1: TODBCConnection;
    password: TEdit;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    username: TEdit;
    img_logo: TImage;
    Label_firm: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure img_infoClick(Sender: TObject);
    procedure img_exitClick(Sender: TObject);
    procedure img_loginClick(Sender: TObject);
    procedure Label_registerClick(Sender: TObject);
  private

  public

  end;

var
  Login: TLogin;
  FN, LN: string [15];

implementation
uses Unit1, AdminUnit;

{$R *.lfm}

{ TLogin }


procedure TLogin.img_exitClick(Sender: TObject);
begin
  Application.terminate;
end;

procedure TLogin.img_loginClick(Sender: TObject);
begin
  SQLQuery1.Close;
   SQLQuery1.UsePrimaryKeyAsKey := False;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.AddText ('select * from Employee');
   SQLQuery1.SQL.AddText ('where Username = ''' +username.text+''' and Passwd = '''+password.text+''' ');
   SQLQuery1.Open;

   if  (username.Text ='Admin') and (password.Text ='admin123') then
   begin
        Login.Hide;
        Form2:= TForm2.Create(Nil);
        Form2.ShowModal;
        FreeAndNil (Form2);
        Close;
   end
   else if (SQLQuery1.RecordCount >0)then
   begin
        FN := SQLQuery1.FieldByName('First_Name').AsString;
        LN := SQLQuery1.FieldByName('Last_Name').AsString;
        ShowMessage('Welcome...'+FN+' '+LN+' !');
        Login.Hide;
        Form1:= TForm1.Create(Nil);
        Form1.ShowModal;
        FreeAndNil(Form1);
        Close;
   end
   else begin
     Showmessage(' Wrong password or username');
   end;

end;




procedure TLogin.img_infoClick(Sender: TObject);
begin
  Info.Showmodal();
end;

procedure TLogin.FormCreate(Sender: TObject);
begin
     ODBCConnection1.Driver := 'Microsoft Access Driver (*.mdb, *.accdb)';
     ODBCConnection1.Params.Add('DBQ=C:\Users\Antonio\Desktop\g_database.accdb');
     ODBCConnection1.Params.Add('Locale Identifier=1031');
     ODBCConnection1.Params.Add('ExtendedAnsiSQL=l');
     ODBCConnection1.Params.Add('Charset=ansi');
     ODBCConnection1.Connected := True;
     ODBCConnection1.KeepConnection:= True;
     SQLTransaction1.Action := caCommit;
     SQLTransaction1.Active := True;


     SQLQuery1.UsePrimaryKeyAsKey:= False;
     SQLQuery1.Open;
end;

procedure TLogin.Label_registerClick(Sender: TObject);
begin
  Login.Hide;
  Register.Showmodal();
end;

end.

