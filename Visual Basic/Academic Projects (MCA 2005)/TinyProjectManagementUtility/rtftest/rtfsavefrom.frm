VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form Form1 
   Caption         =   "rtf form"
   ClientHeight    =   6345
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   10665
   Icon            =   "rtfsavefrom.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6345
   ScaleWidth      =   10665
   StartUpPosition =   3  'Windows Default
   Begin RichTextLib.RichTextBox rtf2 
      Height          =   1695
      Left            =   960
      TabIndex        =   1
      Top             =   3840
      Visible         =   0   'False
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   2990
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"rtfsavefrom.frx":030A
   End
   Begin RichTextLib.RichTextBox rtf 
      Height          =   5655
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   10455
      _ExtentX        =   18441
      _ExtentY        =   9975
      _Version        =   393217
      ScrollBars      =   3
      TextRTF         =   $"rtfsavefrom.frx":0395
   End
   Begin VB.Menu opts 
      Caption         =   "options"
      Begin VB.Menu loadf 
         Caption         =   "LOAD"
      End
      Begin VB.Menu SAVEF 
         Caption         =   "SAVE"
      End
      Begin VB.Menu paste 
         Caption         =   "PASTE"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub Form_Resize()
 rtf.Left = 50
 rtf.Top = 50
 rtf.Width = Abs(Me.ScaleWidth - 50)
 rtf.Height = Abs(Me.ScaleHeight - 50)
End Sub

Private Sub loadf_Click()
 
 rtf2.LoadFile App.Path & "\phelp.txt"
 rtf.Text = rtf.Text & rtf2.Text
 
    
    rtf.SelStart = 1
    rtf.SelLength = Len(rtf)
    rtf.SelFontName = "courier new"
    rtf.SelFontSize = 9
    rtf.SelColor = RGB(50, 50, 170)
End Sub

Private Sub paste_Click()

    If Trim(Clipboard.GetText) <> "" Then
        
    rtf.Text = rtf.Text & Clipboard.GetText
    rtf.SelStart = 1
    rtf.SelLength = Len(rtf)
    rtf.SelFontName = "courier new"
    rtf.SelFontSize = 9
    rtf.SelColor = RGB(50, 50, 170)
    End If
    
End Sub

Private Sub SAVEF_Click()
  If MsgBox("SAVE?", vbYesNo, "CONFIRM!!!") = vbYes Then
        rtf.SaveFile App.Path & "\phelp.txt"
  End If
End Sub
