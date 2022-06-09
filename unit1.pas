{ Kalkulace Additional Member System v kontextu Skotska a Walesu
  Author: Stepan Kosan
  Date: 2022

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}

unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Napoveda: TMemo;
    Vysledky: TMemo;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure EditAllChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
      private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.Button4Click(Sender: TObject);
var i, j, pocet_stran, pocet_reg_mand, maxmand : longint;
   strany, prime_mand, mand: array of longint;
   comp_strany: array of double;
   myStringList: TStringList;
begin
pocet_stran:=10;
pocet_reg_mand:=StrToInt (Edit11.text);

//inicializace arrays, +1 je pridano pro pohodlnejsi iterace (pascal jinak zacina
//na pozici nula
setlength(strany, pocet_stran+1);
setlength(comp_strany, pocet_stran+1);
setlength(prime_mand, pocet_stran+1);
setlength(mand, pocet_stran+1);

//nepekne vepsani hodnot do array, v budoucnu prepsat na iterativni loop s Edit[i] array.
strany[1]:=StrToInt (Edit1.text);
strany[2]:=StrToInt (Edit2.text);
strany[3]:=StrToInt (Edit3.text);
strany[4]:=StrToInt (Edit4.text);
strany[5]:=StrToInt (Edit5.text);
strany[6]:=StrToInt (Edit6.text);
strany[7]:=StrToInt (Edit7.text);
strany[8]:=StrToInt (Edit8.text);
strany[9]:=StrToInt (Edit9.text);
strany[10]:=StrToInt (Edit10.text);

prime_mand[1]:=StrToInt (Edit12.text);
prime_mand[2]:=StrToInt (Edit13.text);
prime_mand[3]:=StrToInt (Edit14.text);
prime_mand[4]:=StrToInt (Edit15.text);
prime_mand[5]:=StrToInt (Edit16.text);
prime_mand[6]:=StrToInt (Edit17.text);
prime_mand[7]:=StrToInt (Edit18.text);
prime_mand[8]:=StrToInt (Edit19.text);
prime_mand[9]:=StrToInt (Edit20.text);
prime_mand[10]:=StrToInt (Edit21.text);

//vyplneni array s celkovym poctem mandatu, primymi mandaty, o kterych
//nyni mame informaci
for i:=1 to pocet_stran do
        begin
        mand[i]:=mand[i]+prime_mand[i];
        end;
maxmand:=0;
for i:=1 to pocet_reg_mand do
begin

             //iterace pro kazde kolo udelovani mandatu
        for j:=1 to pocet_stran do
                begin

                     //celkovy pocet hlasu pro kazdou stranu vydelime formulkou a prehodime do
                     //samostastne array pro kazde kolo
                        comp_strany[j]:=strany[j] / (mand[j] + 1);
                end;

          for j:=1 to pocet_stran do
                begin

                     //pokud ma strana po vydeleni formulkou v tomto kole nejvyssi
                     //pocet hlasu, je ji pridelen mandat, ktery bude reflektovan pri
                     //pristi iteraci
                        If (comp_strany[j]=maxvalue(comp_strany)) then
                                begin

                                   //pri pripadne shode poctu hlasu pro dve strany
                                   //je udelen mandat obema stranam a je vynechano
                                   //posledni kolo - k implementaci shoda v poslednim
                                   //kole https://www.legislation.gov.uk/ukpga/2006/32/section/9
                                   If (maxmand<pocet_reg_mand) then
                                       begin
                                        mand[j]:=mand[j]+1;
                                        maxmand:=maxmand+1
                                       end;
                                end;
                end;
end;

//vypise strany s nenulovym poctem hlasou a jejich ziskane mandaty pomoci stringlist objektu
myStringList:=TStringList.Create;
for i:=1 to pocet_stran do
    begin
    If (strany[i] <> 0) then
     begin
     myStringList.Add('Strana číslo '+ IntToStr(i)+' obdržela celkem '+ IntToStr(mand[i])+' mandátů, z toho '+ IntToStr(prime_mand[i])+' přímé mandáty.');
     end;
    end;
Vysledky.Lines.Assign(myStringList);
If (Vysledky.Text='') then
   begin
   Vysledky.Text:='Zde se zobrazí výsledky výpočtu.'
   end;
myStringList.Free;

//vycisteni arrays
setlength(strany, 0);
setlength(comp_strany, 0);
setlength(prime_mand, 0);
setlength(mand, 0)
  end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.EditAllChange(Sender: TObject);
var gt: longint;
begin
gt:=0;
  If (Edit1.text='') or not(TryStrToInt(Edit1.text,gt)) then
   begin
      Edit1.text:='0'
   end;
  If (Edit2.text='') or not(TryStrToInt(Edit2.text,gt)) then
   begin
      Edit2.text:='0'
   end;
  If (Edit3.text='') or not(TryStrToInt(Edit3.text,gt)) then
   begin
      Edit3.text:='0'
   end;
  If (Edit4.text='') or not(TryStrToInt(Edit4.text,gt)) then
   begin
      Edit4.text:='0'
   end;
  If (Edit5.text='') or not(TryStrToInt(Edit5.text,gt)) then
   begin
      Edit5.text:='0'
   end;
  If (Edit6.text='') or not(TryStrToInt(Edit6.text,gt)) then
   begin
      Edit6.text:='0'
   end;
  If (Edit7.text='') or not(TryStrToInt(Edit7.text,gt)) then
   begin
      Edit7.text:='0'
   end;
  If (Edit8.text='') or not(TryStrToInt(Edit8.text,gt)) then
   begin
      Edit8.text:='0'
   end;
  If (Edit9.text='') or not(TryStrToInt(Edit9.text,gt)) then
   begin
      Edit9.text:='0'
   end;
  If (Edit10.text='') or not(TryStrToInt(Edit10.text,gt)) then
   begin
      Edit10.text:='0'
   end;
  If (Edit11.text='') or not(TryStrToInt(Edit11.text,gt)) then
   begin
      Edit11.text:='0'
   end;
  If (Edit12.text='') or not(TryStrToInt(Edit12.text,gt)) then
   begin
      Edit12.text:='0'
   end;
  If (Edit13.text='') or not(TryStrToInt(Edit13.text,gt)) then
   begin
      Edit13.text:='0'
   end;
  If (Edit14.text='') or not(TryStrToInt(Edit14.text,gt)) then
   begin
      Edit14.text:='0'
   end;
  If (Edit15.text='') or not(TryStrToInt(Edit15.text,gt)) then
   begin
      Edit15.text:='0'
   end;
  If (Edit16.text='') or not(TryStrToInt(Edit16.text,gt)) then
   begin
      Edit16.text:='0'
   end;
  If (Edit17.text='') or not(TryStrToInt(Edit17.text,gt)) then
   begin
      Edit17.text:='0'
   end;
  If (Edit18.text='') or not(TryStrToInt(Edit18.text,gt)) then
   begin
      Edit18.text:='0'
   end;
  If (Edit19.text='') or not(TryStrToInt(Edit19.text,gt)) then
   begin
      Edit19.text:='0'
   end;
  If (Edit20.text='') or not(TryStrToInt(Edit20.text,gt)) then
   begin
      Edit20.text:='0'
   end;
  If (Edit21.text='') or not(TryStrToInt(Edit21.text,gt)) then
   begin
      Edit21.text:='0'
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var napovedalist: TStringList;
begin
Vysledky.Text:='Zde se zobrazí výsledky výpočtu.';
napovedalist:=TStringList.Create;
napovedalist.Add('Nápověda:');
napovedalist.Add('Zadávejte pouze celá čísla bez mezer a čárek.');
napovedalist.Add('V nevyužitých políčcích "Obdržené hlasy" ponechejte nulu.');
Napoveda.Lines.Assign(napovedalist);
napovedalist.Free;
end;


end.
