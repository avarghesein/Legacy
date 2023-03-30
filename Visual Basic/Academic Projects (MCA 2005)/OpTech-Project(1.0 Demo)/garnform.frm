VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form grapher 
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "GRAPH GENERATOR"
   ClientHeight    =   5505
   ClientLeft      =   1215
   ClientTop       =   2265
   ClientWidth     =   9450
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   9
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "garnform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   367
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   630
   WindowState     =   2  'Maximized
   Begin VB.PictureBox garnpic 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFC0&
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2085
      Left            =   0
      ScaleHeight     =   135
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   340
      TabIndex        =   0
      ToolTipText     =   "Meant for showing Graphics related to LPP & SP."
      Top             =   105
      Width           =   5160
      Begin MSComDlg.CommonDialog dialog1 
         Left            =   0
         Top             =   0
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
   Begin VB.Menu lppg 
      Caption         =   "&Linear Programming"
      Begin VB.Menu showanni 
         Caption         =   "Show Animation"
         Shortcut        =   ^A
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu save_2_file 
         Caption         =   "Save To File"
         Shortcut        =   ^S
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu cpy 
         Caption         =   "Copy"
         Shortcut        =   ^C
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu prnt 
         Caption         =   "Print Form"
         Shortcut        =   ^P
      End
      Begin VB.Menu sep6 
         Caption         =   "-"
      End
      Begin VB.Menu lexit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu sp 
      Caption         =   "&Sequential Problem"
      Begin VB.Menu save_2_file1 
         Caption         =   "Save To File"
         Shortcut        =   ^F
      End
      Begin VB.Menu sep4 
         Caption         =   "-"
      End
      Begin VB.Menu cpy1 
         Caption         =   "Copy"
         Shortcut        =   ^O
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu prnt1 
         Caption         =   "Print Form"
         Shortcut        =   ^R
      End
      Begin VB.Menu sep7 
         Caption         =   "-"
      End
      Begin VB.Menu sxit 
         Caption         =   "Exit"
         Shortcut        =   ^E
      End
   End
End
Attribute VB_Name = "grapher"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public indx As Long
Public hold As Long

Dim errflg As Boolean

Dim pl As xy_plane
Dim ids As optimal_spj2
Dim rawshed As job_gp

Dim lpplines As lpp_lines
Dim corners As corner_points
Dim intsecs As corner_points
Dim rintsecs As corner_points
Dim xyp As xy_plane
Dim bndry As end_points


Private Sub cpy_Click()
On Error GoTo xit
    
    'SendKeys "%{PRTSC}", True
    'AppActivate "LPP GRAPH GENERATOR", True
    ''SendKeys "%{PRTSC}", True
    'Shell "mspaint.exe"
    ''Shell "%SystemRoot%\system32\mspaint.exe"
    'AppActivate "untitled - Paint", True
    'SendKeys "+{INSERT}", True
    If garnpic.Picture <> 0 Then
        Clipboard.SetData garnpic.Picture, vbCFDIB
    End If
    'SendKeys ("%{PRTSC}")
Exit Sub
xit:
    MsgBox Err.Description
End Sub

Private Sub cpy1_Click()
On Error GoTo xit
    If garnpic.Picture <> 0 Then
        Clipboard.SetData garnpic.Picture, vbCFDIB
    End If
Exit Sub
xit:
    MsgBox Err.Description
End Sub

Private Sub Form_load()
On Error GoTo xit

    
    errflg = False
    garnpic.AutoRedraw = True
    If hold = 0 Then
        Me.HelpContextID = 10
        lppg.Visible = False
        Me.Caption = "SP Graph Generator"
        Call create_raw_schedule(seqj2, rawshed)
        Call create_idles(job_mx, indx, ids, seqj2)
    End If
    If hold = 1 Or hold = 2 Then
        Me.HelpContextID = 7
        sp.Visible = False
        Me.Caption = "LPP Graph Generator"
        If Not initiate_lpplines(indx, xyp, lpplines, corners, intsecs, bndry, rintsecs) Then errflg = True
    End If
    Call Form_Resize

Exit Sub
xit:
    Call error_me(Me)
    
End Sub

Private Sub Form_Resize()
On Error GoTo xit
Dim i As Integer
Dim p1 As point
Dim p2 As point
    
    garnpic.Cls
    garnpic.AutoRedraw = True
    garnpic.left = 0
    garnpic.Top = 0
    garnpic.Height = Me.ScaleHeight
    garnpic.Width = Me.ScaleWidth
If Not errflg Then
    If hold = 0 Then
        Call initialize_graphic_spj2(pl, garnpic, seqj2, ids)
        If pl.x_max = 0 Or pl.y_max = 0 Then
            errflg = True
            Exit Sub
        End If
        Call draw_graph_spj2(garnpic, ids, rawshed, pl, job_mx, job_mx.optimal_schedule)
    End If
    If hold = 1 Or hold = 2 Then
        Call draw_lpp_graph(xyp, lpplines, corners, intsecs, rintsecs, bndry, garnpic, False)
    End If

    garnpic.Line (2, 2)-(garnpic.ScaleWidth - 2, 2), RGB(300, 0, 0)
    garnpic.Line (garnpic.ScaleWidth - 2, 2)-(garnpic.ScaleWidth - 2, garnpic.ScaleHeight - 2), RGB(300, 0, 0)
    garnpic.Line (garnpic.ScaleWidth - 2, garnpic.ScaleHeight - 2)-(2, garnpic.ScaleHeight - 2), RGB(300, 0, 0)
    garnpic.Line (2, garnpic.ScaleHeight)-(2, 2), RGB(300, 0, 0)
Else
    garnpic.CurrentX = garnpic.ScaleWidth / 2 - 225
    garnpic.CurrentY = garnpic.ScaleHeight / 2
    garnpic.FontBold = True
    garnpic.ForeColor = RGB(250, 0, 0)
    garnpic.FontSize = 12
    If hold = 1 Or hold = 2 Then
        garnpic.Print "Error, The problem can't be solved." + "Please choose close."
    ElseIf hold = 0 Then
        garnpic.Print "Error, Unable to display Graphics." + "Please choose close."
    End If
End If
Exit Sub
xit:
    Call error_me(Me)

End Sub



Private Sub Form_Unload(cancel As Integer)
    If hold = 0 Then
        'spj2.Show
        Exit Sub
    End If
    If hold = 1 Then
        'or_form1.Show
        Exit Sub
    End If
    If hold = 2 Then
        'foptions.Show
        Exit Sub
    End If
End Sub


Private Sub garnpic_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
On Error GoTo xit
    If Button = vbRightButton Then
        'garnpic.Picture = LoadPicture(App.path + "\HELP\screen_shots\sp_1.bmp")
        If garnpic.Picture = 0 Then
            save_2_file.Enabled = False
            'prnt.Enabled = False
            cpy.Enabled = False
            save_2_file1.Enabled = False
            'prnt1.Enabled = False
            cpy1.Enabled = False
        Else
            save_2_file.Enabled = True
            prnt.Enabled = True
            cpy.Enabled = True
            save_2_file1.Enabled = True
            prnt1.Enabled = True
            cpy1.Enabled = True
        End If
            
        If hold = 1 Or hold = 2 Then
            PopupMenu lppg
        End If
        If hold = 0 Then
            PopupMenu sp
        End If
    End If
Exit Sub
xit:
    MsgBox Err.Description
End Sub



Private Sub lexit_Click()
    Unload Me
End Sub

Private Sub lppg_Click()
        If garnpic.Picture = 0 Then
            save_2_file.Enabled = False
            'prnt.Enabled = False
            cpy.Enabled = False
            save_2_file1.Enabled = False
            'prnt1.Enabled = False
            cpy1.Enabled = False
        Else
            save_2_file.Enabled = True
            prnt.Enabled = True
            cpy.Enabled = True
            save_2_file1.Enabled = True
            prnt1.Enabled = True
            cpy1.Enabled = True
        End If
End Sub

Private Sub prnt_Click()
On Error GoTo cancel
    Me.PrintForm
    'If garnpic.Picture <> 0 Then
        'Printer.PaintPicture garnpic.Picture, 0, 0
    'End If
Exit Sub
cancel:
   MsgBox Err.Description
End Sub

Private Sub prnt1_Click()
On Error GoTo cancel
    Me.PrintForm
    'If garnpic.Picture <> 0 Then
        'Printer.PaintPicture garnpic.Picture, 0, 0
    'End If
Exit Sub
cancel:
   MsgBox Err.Description
End Sub

Private Sub save_2_file_Click()
On Error GoTo cancel
    
    If garnpic.Picture <> 0 Then
        dialog1.DefaultExt = "bmp"
        dialog1.InitDir = "c:\"
        dialog1.Filter = "bmp Files (*.bmp)|*.bmp"
        dialog1.Flags = &H2000& Or &H2& Or &H800
        dialog1.ShowSave
        SavePicture garnpic.Picture, dialog1.FileName
    End If

Exit Sub
cancel:
   MsgBox Err.Description
End Sub

Private Sub save_2_file1_Click()
On Error GoTo cancel
    If garnpic.Picture <> 0 Then
        dialog1.DefaultExt = "bmp"
        dialog1.InitDir = "c:\"
        dialog1.Filter = "bmp Files (*.bmp)|*.bmp"
        dialog1.Flags = &H2000& Or &H2& Or &H800
        dialog1.ShowSave
        SavePicture garnpic.Picture, dialog1.FileName
    End If
Exit Sub
cancel:
   MsgBox Err.Description
End Sub

Private Sub showanni_Click()
On Error GoTo xit
    If Not errflg Then
        garnpic.Cls
        garnpic.AutoRedraw = False
        Call draw_lpp_graph(xyp, lpplines, corners, intsecs, rintsecs, bndry, garnpic, True)
        garnpic.Line (2, 2)-(garnpic.ScaleWidth - 2, 2), RGB(300, 0, 0)
        garnpic.Line (garnpic.ScaleWidth - 2, 2)-(garnpic.ScaleWidth - 2, garnpic.ScaleHeight - 2), RGB(300, 0, 0)
        garnpic.Line (garnpic.ScaleWidth - 2, garnpic.ScaleHeight - 2)-(2, garnpic.ScaleHeight - 2), RGB(300, 0, 0)
        garnpic.Line (2, garnpic.ScaleHeight)-(2, 2), RGB(300, 0, 0)
        garnpic.AutoRedraw = True
    Else
        garnpic.CurrentX = garnpic.ScaleWidth / 2 - 225
        garnpic.CurrentY = garnpic.ScaleHeight / 2
        garnpic.FontBold = True
        garnpic.ForeColor = RGB(250, 0, 0)
        garnpic.FontSize = 12
        If hold = 1 Or hold = 2 Then
            garnpic.Print "Error, The problem can't be solved." + "Please choose close."
        ElseIf hold = 0 Then
            garnpic.Print "Error, Unable to display Graphics." + "Please choose close."
        End If
    End If
Exit Sub
xit:
     Call error_me(Me)
    
End Sub

Private Sub sxit_Click()
    Unload Me
End Sub
